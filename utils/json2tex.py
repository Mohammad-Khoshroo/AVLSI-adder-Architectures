import os
import re
import json

BASE_DIR = "./"
TARGET_BASENAME = "sim"
OUTPUT_FILE = "latex_tables_from_json.txt"

CORNERS = ['TT', 'SF', 'FS', 'SS', 'FF']
TEMPS = [10, 25, 40, 55, 70]
BETAS = [1, 2, 3, 4, 5]

PARAMS_CONFIG = {
    'tplh_out': 'single',
    'tphl_out': 'single',
    'tp_out': 'combined'
}

results = {
    param: {t: {b: {c: "value" for c in CORNERS} for b in BETAS} for t in TEMPS}
    for param in PARAMS_CONFIG.keys()
}

def parse_json_file(filepath, corner, temp):
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            data = json.load(f)
        
        records = data.get("records_by_index", {})
        for idx_str, record in records.items():
            try:
                beta_val = int(idx_str) 
            except ValueError:
                continue
            
            if beta_val in BETAS:
                for param in PARAMS_CONFIG.keys():
                    if param in record:
                        val = record[param].get("si_formatted", record[param].get("raw", "value"))
                        results[param][temp][beta_val][corner] = str(val)
                        
    except Exception as e:
        print(f"Error reading {filepath}: {e}")

abs_base_dir = os.path.abspath(BASE_DIR)
print(f"Starting scan from root directory: {abs_base_dir}")
print(f"Looking for '{TARGET_BASENAME}_eval.mt*.json' files...\n")
print("-" * 60)

pattern = r'^' + re.escape(TARGET_BASENAME.lower()) + r'\_eval\.mt(\d+)\.json$'

for root, dirs, files in os.walk(BASE_DIR):
    for file in files:
        match = re.search(pattern, file.lower())
        if match:
            idx = int(match.group(1))
            if 0 <= idx <= 24:
                corner = CORNERS[idx // 5]
                temp = TEMPS[idx % 5]
                filepath = os.path.join(root, file)
                
                print(f"Extracting data from: {filepath}  -> Corner: {corner}, Temp: {temp}")
                
                parse_json_file(filepath, corner, temp)

print("-" * 60)
print(f"Data extraction complete! Writing LaTeX tables to '{OUTPUT_FILE}'...\n")

with open(OUTPUT_FILE, "w", encoding="utf-8") as out_file:
    
    def write_tex(text):
        print(text, file=out_file)

    def print_single_table(param_key):
        write_tex(f"\n% --- Table for {param_key.upper()} ---")
        for t in TEMPS:
            write_tex(f"            % ================= temp {t} =================")
            for b in BETAS:
                line = "            "
                if b == 1: line += f"\\multirow{{5}}*{{{t}}}                    & 1                             & "
                else:      line += f"                                                   & {b}                             & "
                
                vals = [f"\\lr{{{results[param_key][t][b][c]}}}" if results[param_key][t][b][c] != "value" else "value" for c in CORNERS]
                line += " & ".join(vals)
                line += " \\\\ " + ("\\cline{2-7}" if b < 5 else "\\hline")
                write_tex(line)

    def print_combined_table(param_key):
        write_tex(f"\n% --- Combined Table (Split) for {param_key.upper()} ---")
        pairs = [(10, 55), (25, 70), (40, None)]
        for r_temp, l_temp in pairs:
            write_tex(f"    % --- Pair: {r_temp} and {l_temp} ---")
            for b in BETAS:
                row = f"    \\multirow{{5}}*{{{r_temp}}} & {b} & " if b == 1 else f"                        & {b} & "
                row += " & ".join([f"\\lr{{{results[param_key][r_temp][b][c]}}}" if results[param_key][r_temp][b][c] != "value" else "value" for c in CORNERS])
                
                if l_temp:
                    row += " & & " 
                    row += f"\\multirow{{5}}*{{{l_temp}}} & {b} & " if b == 1 else f"                    & {b} & "
                    row += " & ".join([f"\\lr{{{results[param_key][l_temp][b][c]}}}" if results[param_key][l_temp][b][c] != "value" else "value" for c in CORNERS])
                    row += " \\\\ " + ("\\cline{2-7} \\cline{10-15}" if b < 5 else "\\cline{1-7} \\cline{9-15}")
                else:
                    row += " & \\multicolumn{8}{c}{} \\\\ " + ("\\cline{2-7}" if b < 5 else "\\cline{1-7}")
                write_tex(row)

    for param, table_type in PARAMS_CONFIG.items():
        write_tex("\n" + "% "+"="*50)
        
        if table_type in ['single', 'both']:
            print_single_table(param)
            
        if table_type in ['combined', 'both']:
            print_combined_table(param)

print("Done! LaTeX codes have been successfully saved to the output file.")
