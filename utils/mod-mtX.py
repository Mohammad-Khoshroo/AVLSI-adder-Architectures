import os
import re
import sys
import math
import logging

# ==========================================
# CONFIGURATION
# ==========================================
MT_DIR = r"./"
SP_FILE = r"./sim.sp"
# ==========================================

logging.basicConfig(
    filename='hspice_debug.log',
    level=logging.DEBUG,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

class ResolverDict(dict):
    def __init__(self, data, expressions):
        super().__init__()
        self.data = {k.lower(): float(v) for k, v in data.items()}
        self.expressions = {k.lower(): v.lower() for k, v in expressions.items()}
        self.cache = {}
        
        self.math_funcs = {
            'max': max,
            'min': min,
            'abs': abs,
            'sqrt': math.sqrt,
            'exp': math.exp,
            'log': math.log,
            'log10': math.log10
        }

    def __getitem__(self, key):
        key = key.lower()
        if key in self.math_funcs: return self.math_funcs[key]
        if key in self.cache: return self.cache[key]
        if key in self.expressions:
            expr_str = self.expressions[key]
            try:
                expr_str = expr_str.replace('^', '**')
                val = eval(expr_str, {"__builtins__": None}, self)
                self.cache[key] = float(val)
                return float(val)
            except Exception as e:
                logging.error(f"Failed to evaluate '{key}': {e}")
                self.cache[key] = 0.0
                return 0.0
        if key in self.data:
            self.cache[key] = self.data[key]
            return self.data[key]
        self.cache[key] = 0.0
        return 0.0
        
    def __contains__(self, key):
        return True


def extract_expressions(sp_file_path):
    expressions = {}
    if not os.path.isfile(sp_file_path):
        return expressions
    meas_pattern = re.compile(r"\.meas(?:ure)?\s+(?:tran|dc|ac)?\s+([a-zA-Z0-9_]+)\s+param\s*=\s*'([^']+)'", re.IGNORECASE)
    param_pattern = re.compile(r"\.param\s+([a-zA-Z0-9_]+)\s*=\s*'([^']+)'", re.IGNORECASE)
    with open(sp_file_path, 'r', encoding='utf-8', errors='ignore') as f:
        for line in f:
            line = line.strip()
            m_meas = meas_pattern.search(line)
            if m_meas: expressions[m_meas.group(1).lower()] = m_meas.group(2).upper()
            m_param = param_pattern.search(line)
            if m_param: expressions[m_param.group(1).lower()] = m_param.group(2).upper()
    return expressions


def get_source_transitions(var_name, resolver_cache, expressions_dict, base_vars):
    var_name = var_name.lower()
    if var_name in base_vars: return {var_name}
    if var_name not in expressions_dict: return {var_name}
        
    expr = expressions_dict[var_name]
    deps = set(re.findall(r'[a-zA-Z_][a-zA-Z0-9_]*', expr))
    math_keywords = {'max', 'min', 'abs', 'sqrt', 'exp', 'log', 'log10'}
    valid_deps = [d.lower() for d in deps if d.lower() in resolver_cache and d.lower() not in math_keywords]
    
    sources = set()
    current_val = resolver_cache.get(var_name, 0.0)
    is_pass_through = False
    
    for dep in valid_deps:
        dep_val = resolver_cache.get(dep, 0.0)
        if math.isclose(dep_val, current_val, rel_tol=1e-6, abs_tol=1e-15):
            is_pass_through = True
            sources.update(get_source_transitions(dep, resolver_cache, expressions_dict, base_vars))
            
    if not is_pass_through and valid_deps:
        for dep in valid_deps:
            sources.update(get_source_transitions(dep, resolver_cache, expressions_dict, base_vars))
            
    return sources if sources else {var_name}


def format_transition_logic(var_name):
    var_name = var_name.lower()
    
    m = re.match(r'^t_(.+?)_([a-z0-9]+)_([a-z0-9]+)_w([12])_[lh]{2}$', var_name)
    if m:
        changing_pin = m.group(2).upper()
        static_pins_str = m.group(3).upper()
        window = m.group(4)
    else:
        m = re.match(r'^t_(.+?)_([a-z0-9]+)_w([12])_[lh]{2}$', var_name)
        if m:
            changing_pin = m.group(2).upper()
            static_pins_str = ""
            window = m.group(3)
        else:
            return var_name 

    pin_states = {}
    if static_pins_str:
        static_matches = re.finditer(r'([A-Z]+[0-9]*?)([01])(?=[A-Z]|$)', static_pins_str)
        for match in static_matches:
            pin = match.group(1)
            val = match.group(2)
            pin_states[pin] = val

    if window == '1':
        start_change, end_change = '0', '1'
    else:             
        start_change, end_change = '1', '0'

    all_inputs = set(pin_states.keys())
    all_inputs.add(changing_pin)
    
    order = sorted(list(all_inputs))

    start_logic = []
    end_logic = []

    for p in order:
        if p == changing_pin:
            start_logic.append(start_change)
            end_logic.append(end_change)
        else:
            start_logic.append(pin_states[p])
            end_logic.append(pin_states[p])

    inputs_str = ",".join(order)
    start_str = ",".join(start_logic)
    end_str = ",".join(end_logic)
    
    return f"({inputs_str}):{start_str}->{end_str}"


def process_mt_file(mt_path, math_expressions):
    out_path = mt_path.replace('.mt', '_eval.mt')
    
    with open(mt_path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

    # جایگزینی کلمه failed با مقدار صفر
    content = re.sub(r'\bfailed\b', '0.0000e+00', content, flags=re.IGNORECASE)
    
    lines = content.splitlines()
    out_lines = []
    tokens = []
    
    for line in lines:
        stripped = line.strip().upper()
        # عبور از خطوط توضیحات و متادیتا
        if stripped.startswith('.TITLE') or stripped.startswith('$DATA'):
            out_lines.append(line)
        else:
            tokens.extend(line.split())
            
    if not tokens:
        return

    # یافتن هدرها تا رسیدن به 'alter#'
    headers = []
    i = 0
    # ممکن است کلمه index در فایل باشد، آن را نادیده میگیریم اگر قبل از هدرها بود
    if tokens[i].lower() == 'index':
        headers.append('index')
        i += 1
        
    while i < len(tokens):
        h = tokens[i].strip('"\'').lower()
        headers.append(h)
        i += 1
        if h == 'alter#':
            break
            
    num_headers = len(headers)
    if num_headers == 0:
        return

    base_vars = set([h for h in headers if h not in math_expressions])
    
    trace_vars = []
    for h in headers:
        if h in math_expressions and not re.search(r'_m\d+$', h):
            trace_vars.append(h)
            
    trace_headers = [f"SRC_{v}" for v in trace_vars]
    all_headers = headers + trace_headers
    
    # چاپ هدرها در فایل خروجی
    for j in range(0, len(all_headers), 3):
        out_lines.append("   " + "   ".join(f"{h:>50}" for h in all_headers[j:j+3]))
        
    # پردازش مقادیر عددی (دیتا)
    while i < len(tokens):
        # بررسی وجود کلمه index وسط داده ها (برای فایل‌های ترکیبی)
        if tokens[i].lower() == 'index':
            i += 1
            continue
            
        row_vals = tokens[i:i+num_headers]
        if len(row_vals) < num_headers:
            i += len(row_vals)
            break
        
        row_dict = {headers[k]: row_vals[k] for k in range(num_headers)}
        resolver = ResolverDict(row_dict, math_expressions)
        new_vals = []
        
        for h in headers:
            val = resolver[h]
            if h in ['index', 'alter#']:
                new_vals.append(str(int(val)))
            else:
                new_vals.append(f"{val:.4e}")
                
        for v in trace_vars:
            sources = get_source_transitions(v, resolver.cache, math_expressions, base_vars)
            logic_strings = [format_transition_logic(src) for src in sorted(list(sources))]
            src_str = "|".join(logic_strings)
            new_vals.append(src_str)
                
        for j in range(0, len(new_vals), 3):
            out_lines.append("   " + "   ".join(f"{v:>50}" for v in new_vals[j:j+3]))
            
        i += num_headers

    with open(out_path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(out_lines) + '\n')
    
    print(f"Processed: {mt_path} -> Saved as: {out_path}")


def main():
    print("=== HSPICE .mt File Processor with Dynamic Vector Decoding ===")
    
    mt_dir = MT_DIR.strip('"\'')
    sp_file = SP_FILE.strip('"\'')
    
    mt_dir = os.path.abspath(mt_dir)
    sp_file = os.path.abspath(sp_file)
    
    if not os.path.isdir(mt_dir):
        print(f"Error: Directory not found -> {mt_dir}")
        sys.exit(1)
        
    math_expressions = extract_expressions(sp_file)
    print(f"Loaded {len(math_expressions)} mathematical expressions.")
    
    found_mt = False
    for root, _, files in os.walk(mt_dir):
        for file in files:
            if file.startswith('sim') and '.mt' in file and '_eval' not in file:
                mt_path = os.path.join(root, file)
                process_mt_file(mt_path, math_expressions)
                found_mt = True
                
    if not found_mt:
        print("No .mt files found in the specified directory.")
    else:
        print("All files processed successfully!")

if __name__ == "__main__":
    main()
