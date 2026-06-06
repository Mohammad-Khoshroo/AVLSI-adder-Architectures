import json
import os

# ==========================================
# 1. Define your input file path here:
FILE_PATH = r"./simulation/RCA/mont-carlo/sim.mc0"  # Supports any extension (e.g., .lis, .txt, .tr0)
# ==========================================


def parse_hspice_data(file_path):
    data = []
    headers = []
    header_found = False

    with open(file_path, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()

            # Skip empty lines, comments, and HSPICE configuration options
            if not line or line.startswith("$") or line.startswith("."):
                continue

            # Identify the header line (starts with "index")
            if line.lower().startswith("index"):
                raw_headers = line.split()
                headers = []
                for h in raw_headers:
                    # Clean headers from extra strings like ':@:dev:@:IGNC'
                    clean_h = h.split(":@:")[0]
                    headers.append(clean_h)
                header_found = True
                continue

            # Extract data values after the header has been identified
            if header_found:
                parts = line.split()
                if len(parts) == len(headers):
                    row_dict = {}
                    for col, val in zip(headers, parts):
                        # Convert to appropriate numeric types (int or float)
                        try:
                            if "." in val:
                                row_dict[col] = float(val)
                            else:
                                row_dict[col] = int(val)
                        except ValueError:
                            row_dict[col] = val  # Keep as string if conversion fails
                    data.append(row_dict)

    return data


def main():
    if not os.path.exists(FILE_PATH):
        print(f"Error: File not found at specified path: {FILE_PATH}")
        return

    # Extract directory and filename to save the output JSON in the same directory
    directory, filename = os.path.split(FILE_PATH)
    name_without_ext, _ = os.path.splitext(filename)

    json_filename = f"dev.json"
    json_path = os.path.join(directory, json_filename)

    print("Processing file...")
    parsed_data = parse_hspice_data(FILE_PATH)

    if not parsed_data:
        print("Error: No data extracted from the file.")
        return

    print(f"Saving JSON to: {json_path}")
    with open(json_path, "w", encoding="utf-8") as json_file:
        json.dump(parsed_data, json_file, indent=4, ensure_ascii=False)

    print("Success: File successfully converted to JSON!")


if __name__ == "__main__":
    main()
