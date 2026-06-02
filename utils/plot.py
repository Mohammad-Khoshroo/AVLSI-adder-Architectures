import os
import re
import json
import matplotlib.pyplot as plt

# =======================================================================
TARGET_DIR = r"./simulations/low-power-vs-high-performance/"
X_PARAM = "scale"

Y_PARAMS = ["p_avg"] 

Y_MULTIPLIER = 1e6 
Y_UNIT = "µ"

LINE_WIDTH = 2
MARKER_SIZE = 6
# =======================================================================

FILE_PATTERN = r"\.json$"

SI_PREFIX_POWER = {
    'Y': 24, 'Z': 21, 'E': 18, 'P': 15, 'T': 12, 'G': 9, 'M': 6, 'k': 3,
    '': 0, 'm': -3, 'u': -6, 'µ': -6, 'n': -9, 'p': -12, 'f': -15, 'a': -18, 'z': -21, 'y': -24
}

def parse_si_value(val_str):
    val_str = str(val_str).strip()
    
    match = re.match(r"^([-+]?[0-9]*\.?[0-9]+(?:[eE][-+]?[0-9]+)?)\s*([a-zA-Zµ]?)$", val_str)
    if match:
        num_str, suffix = match.groups()
        num = float(num_str)
        power = SI_PREFIX_POWER.get(suffix, 0)
        return num * (10 ** power)
    
    return float(val_str)

def plot_data():
    print(f"Plotting multiple time parameters: {Y_PARAMS} vs '{X_PARAM}'...\n")

    plot_series = {y_param: [] for y_param in Y_PARAMS}
    files_found = False

    if not os.path.exists(TARGET_DIR):
        print(f"Directory not found: {TARGET_DIR}")
        return

    for root, dirs, files in os.walk(TARGET_DIR):
        for file in files:
            if re.search(FILE_PATTERN, file.lower()):
                filepath = os.path.join(root, file)
                files_found = True

                try:
                    with open(filepath, "r", encoding="utf-8") as jf:
                        data = json.load(jf)

                    records = data.get("records_by_index", {})
                    
                    for y_param in Y_PARAMS:
                        x_values = []
                        y_values = []
                        
                        for index_key, record in records.items():
                            if X_PARAM in record and y_param in record:
                                x_raw = record[X_PARAM].get("raw", record[X_PARAM]) if isinstance(record[X_PARAM], dict) else record[X_PARAM]
                                y_raw = record[y_param].get("raw", record[y_param]) if isinstance(record[y_param], dict) else record[y_param]

                                x_val = parse_si_value(x_raw)
                                y_val = parse_si_value(y_raw) * Y_MULTIPLIER

                                x_values.append(x_val)
                                y_values.append(y_val)

                        sorted_points = sorted(zip(x_values, y_values))
                        if sorted_points:
                            x_values, y_values = zip(*sorted_points)
                            plot_series[y_param].append((list(x_values), list(y_values), file))

                except Exception as e:
                    print(f"Error reading {filepath}: {e}")

    if not files_found:
        print("No JSON files matching the pattern were found.")
        return

    fig, ax = plt.subplots(figsize=(8, 6))

    for y_param in Y_PARAMS:
        for x_vals, y_vals, filename in plot_series[y_param]:
            label_str = y_param if len(plot_series[y_param]) == 1 else f"{y_param} ({filename})"
            
            ax.plot(
                x_vals,
                y_vals,
                marker='o',
                color="red",
                linewidth=LINE_WIDTH,
                markersize=MARKER_SIZE,
                label=label_str,
            )

    ax.set_title(f"{Y_PARAMS} vs {X_PARAM.capitalize()}", fontsize=14, fontweight="bold")
    ax.set_xlabel(X_PARAM.capitalize(), fontsize=12)
    ax.set_ylabel(f"POWER ({Y_UNIT})", fontsize=12)
    ax.grid(True, which="both", linestyle="--", linewidth=0.5, alpha=0.7)
    ax.legend(title="Parameters", title_fontsize="11", fontsize="9", loc="best")

    plt.tight_layout()

    output_filename = f"{Y_PARAMS}_vs_{X_PARAM}.png"
    plt.savefig(output_filename, dpi=300, bbox_inches="tight")
    print(f"Plot saved successfully as: {output_filename}")

if __name__ == "__main__":
    plot_data()
