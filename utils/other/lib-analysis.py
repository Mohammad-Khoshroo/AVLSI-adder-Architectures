import re
import argparse
import sys
import os

def analyze_spice_tech_file(file_path, mosfet_only=False, output_file="lib_report.txt"):
    corners = set()
    base_models = {}  # Format: {'nch': {'type': 'NMOS', 'bins': set(), 'unbinned': False}}
    subcircuits = set()

    # Regex patterns
    regex_lib = re.compile(r'^\s*\.lib\s+(\S+)', re.IGNORECASE)
    regex_model = re.compile(r'^\s*\.model\s+(\S+)\s+([a-zA-Z0-9_]+)', re.IGNORECASE)
    regex_subckt = re.compile(r'^\s*\.subckt\s+(\S+)', re.IGNORECASE)

    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            for line in f:
                line = line.strip()
                
                if not line or line.startswith('*') or line.startswith('//'):
                    continue

                # 1. Extract Corners
                match_lib = regex_lib.match(line)
                if match_lib:
                    corner_name = match_lib.group(1).upper()
                    if corner_name != 'ENDL':
                        corners.add(corner_name)
                    continue

                # 2. Extract Subcircuits
                match_subckt = regex_subckt.match(line)
                if match_subckt:
                    subcircuits.add(match_subckt.group(1).lower())
                    continue

                # 3. Extract Models and Group by Base Name
                match_model = regex_model.match(line)
                if match_model:
                    full_model_name = match_model.group(1).lower()
                    model_type = match_model.group(2).upper()
                    
                    # Split base name and bin (e.g., 'nch.15' -> base='nch', bin='15')
                    if '.' in full_model_name:
                        parts = full_model_name.rsplit('.', 1)
                        base_name = parts[0]
                        bin_str = parts[1]
                    else:
                        base_name = full_model_name
                        bin_str = None

                    if base_name not in base_models:
                        base_models[base_name] = {'type': model_type, 'bins': set(), 'unbinned': False}
                    
                    if bin_str is not None:
                        base_models[base_name]['bins'].add(bin_str)
                    else:
                        base_models[base_name]['unbinned'] = True

        # Group models by type for reporting
        grouped_by_type = {}
        for base_name, info in base_models.items():
            m_type = info['type']
            if mosfet_only and ('NMOS' not in m_type and 'PMOS' not in m_type):
                continue
            
            if m_type not in grouped_by_type:
                grouped_by_type[m_type] = {}
            grouped_by_type[m_type][base_name] = info

        # ================= WRITING TO FILE =================
        with open(output_file, 'w', encoding='utf-8') as out_f:
            out_f.write("="*80 + "\n")
            out_f.write(" SPICE TECHNOLOGY FILE ANALYSIS REPORT (CLEAN SUMMARY)\n")
            out_f.write("="*80 + "\n\n")
            
            # Print Corners
            out_f.write(" 1. SUPPORTED PROCESS CORNERS (.lib):\n")
            out_f.write("-" * 40 + "\n")
            if corners:
                out_f.write(f"  Found {len(corners)} corners:\n")
                out_f.write(f"  {', '.join(sorted(corners))}\n")
            else:
                out_f.write("  No corners found.\n")
            out_f.write("\n")

            # Print Base Models
            out_f.write(" 2. BASE TRANSISTOR MODELS (Grouped by flavor):\n")
            out_f.write("-" * 40 + "\n")
            if grouped_by_type:
                for m_type, models in sorted(grouped_by_type.items()):
                    out_f.write(f"\n  ► TYPE: {m_type} (Total flavors: {len(models)})\n")
                    for base_name, info in sorted(models.items()):
                        bin_count = len(info['bins'])
                        bin_text = f"Has {bin_count} dimension bins" if bin_count > 0 else "No bins (Single model)"
                        unbinned_text = " + 1 default unbinned model" if info['unbinned'] and bin_count > 0 else ""
                        out_f.write(f"     - {base_name:<12s} : {bin_text}{unbinned_text}\n")
            else:
                out_f.write("  No models found matching the criteria.\n")
            out_f.write("\n")

            
            out_f.write("\n" + "="*80 + "\n")

        # ================= PRINTING SUMMARY TO CONSOLE =================
        print("="*60)
        print(" 📊 CLEAN SPICE ANALYSIS SUMMARY")
        print("="*60)
        print(f" 🔹 Process Corners        : {len(corners)} corners found")
        print(f" 🔹 Transistor Flavors     : {sum(len(v) for v in grouped_by_type.values())} base models")
        print("="*60)
        print(f" ✅ Clean report saved to  : {os.path.abspath(output_file)}")
        print("="*60)

    except FileNotFoundError:
        print(f"ERROR: File '{file_path}' not found!")
        sys.exit(1)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Analyze SPICE Technology Files (Clean Summary).")
    parser.add_argument("file_path", type=str, help="Path to the SPICE technology file")
    parser.add_argument("-M", "--mosfet", action="store_true", help="Show ONLY MOSFET models")
    args = parser.parse_args()
    
    analyze_spice_tech_file(args.file_path, mosfet_only=args.mosfet)
