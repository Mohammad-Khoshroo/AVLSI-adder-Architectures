import os
import re
import math
import json

BASE_DIR = "./simulations/low-power-vs-high-performance/static/"
FILE_PATTERN = r'\.mt\d+$'

def scientific_to_si(num_str):
    try:
        val = float(num_str)
    except (ValueError, TypeError):
        return str(num_str)

    if val == 0:
        return "0"

    si_prefixes = {
        24: 'Y',  21: 'Z',  18: 'E',  15: 'P',  12: 'T',  9:  'G',  6:  'M',
        3:  'k',  0:  '',   -3: 'm',  -6: 'µ',  -9: 'n',  -12:'p',  -15:'f',
        -18:'a',  -21:'z',  -24:'y'
    }

    try:
        exponent = math.floor(math.log10(abs(val)))
        si_exponent = (exponent // 3) * 3
    except ValueError:
        return "0"

    if si_exponent > 24: si_exponent = 24
    elif si_exponent < -24: si_exponent = -24

    new_val = val / (10 ** si_exponent)
    prefix = si_prefixes.get(si_exponent, "")
    
    return f"{new_val:g}{prefix}".strip()

def is_number(s):
    try:
        float(s)
        return True
    except ValueError:
        return False

def parse_mt_to_json(filepath, filename):
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()

    tokens = []
    
    for line in lines:
        line_stripped = line.strip()
        if not line_stripped:
            continue
            
        upper_line = line_stripped.upper()
        if upper_line.startswith('.TITLE') or upper_line.startswith('$DATA'):
            continue
            
        tokens.extend(line_stripped.split())

    if not tokens:
        print(f"Warning: No valid tokens found in {filename}. Skipping.")
        return

    headers = []
    i = 0
    
    while i < len(tokens):
        token = tokens[i]
        
        if is_number(token) or token.lower() == 'failed':
            break
            
        h = token.strip('"\'').lower()
        headers.append(h)
        i += 1

    if not headers:
        print(f"Warning: No headers found in {filename}. Skipping.")
        return

    data_tokens = []
    while i < len(tokens):
        if tokens[i].lower() == 'index':
            i += 1
            continue
        data_tokens.append(tokens[i])
        i += 1

    if not data_tokens:
        print(f"Warning: No data found in {filename}. Skipping.")
        return

    json_data = {
        "metadata": {
            "source_file": filename,
            "total_parameters": len(headers),
            "headers": headers
        },
        "records_by_index": {}
    }

    record_len = len(headers)
    
    if len(data_tokens) % record_len != 0:
        print(f"Warning: Data tokens ({len(data_tokens)}) is not an exact multiple of headers ({record_len}) in {filename}.")

    id_index = 0
    if 'alter#' in headers:
        id_index = headers.index('alter#')
    elif 'index' in headers:
        id_index = headers.index('index')

    for i in range(0, len(data_tokens), record_len):
        chunk = data_tokens[i : i + record_len]
        
        if len(chunk) != record_len:
            break
            
        record_dict = {}
        for h, v_str in zip(headers, chunk):
            try:
                raw_val = float(v_str)
            except ValueError:
                raw_val = v_str

            param_obj = {"raw": raw_val}

            if isinstance(raw_val, float) and 0 < abs(raw_val) < 1:
                param_obj["si_formatted"] = scientific_to_si(v_str)
                
            record_dict[h] = param_obj

        try:
            idx_key = str(int(float(chunk[id_index])))
        except:
            idx_key = str(chunk[id_index])

        while idx_key in json_data["records_by_index"]:
            idx_key += "_dup"

        json_data["records_by_index"][idx_key] = record_dict

    json_filepath = filepath + ".json"
    with open(json_filepath, 'w', encoding='utf-8') as jf:
        json.dump(json_data, jf, indent=4, ensure_ascii=False)
        
    print(f"Successfully created: {json_filepath}")

print("Scanning directories for HSPICE .mt files...")
json_count = 0

for root, dirs, files in os.walk(BASE_DIR):
    for file in files:
        if re.search(FILE_PATTERN, file.lower()):
            filepath = os.path.join(root, file)
            parse_mt_to_json(filepath, file)
            json_count += 1

print("-" * 50)
print(f"Done! Extracted data to {json_count} JSON files.")
