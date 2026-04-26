import os
import re
import json
import matplotlib.pyplot as plt

# =======================================================================
TARGET_GATES = {
    "XNOR": r"./xor/",
    "MUX": r"./",
    # "NOR": r"./path_to_NOR" # می‌توانید هر تعداد که می‌خواهید اضافه کنید
}

TARGET_CORNERS = ["TT", "SS", "FF"]
Y_PARAM = "tp_out"
X_PARAM = "beta"
Y_MULTIPLIER = 1e12
Y_UNIT = "ps"

LINE_WIDTH = 2
MARKER_SIZE = 6

# استایل‌های مختلف برای گیت‌های مختلف تا در نمودار قابل تشخیص باشند
GATE_STYLES = {
    "MUX": "-",    # خط پیوسته
    # "XNOR-SYM": "--",  # خط چین
    # "NOR": "-."    # خط و نقطه
}
# =======================================================================

CORNERS = ["TT", "SF", "FS", "SS", "FF"]
TEMPS = [10, 25, 40, 55, 70]
FILE_PATTERN = r"\_eval\.mt(\d+)\.json$"

def plot_data():
    plot_series = {gate: {corner: {} for corner in TARGET_CORNERS} for gate in TARGET_GATES.keys()}

    print(f"Plotting '{Y_PARAM}' vs '{X_PARAM}' for corners: {TARGET_CORNERS}...\n")

    files_found = False

    # حلقه روی گیت‌ها و مسیرهایشان
    for gate_name, root_dir in TARGET_GATES.items():
        print(f"Searching for {gate_name} in: '{os.path.abspath(root_dir)}'")
        
        if not os.path.exists(root_dir):
            print(f"Directory not found: {root_dir}")
            continue

        for root, dirs, files in os.walk(root_dir):
            for file in files:
                match = re.search(FILE_PATTERN, file.lower())
                if match:
                    idx = int(match.group(1))
                    if 0 <= idx <= 24:
                        corner = CORNERS[idx // 5]
                        temp = TEMPS[idx % 5]

                        if corner in TARGET_CORNERS:
                            filepath = os.path.join(root, file)
                            files_found = True

                            try:
                                with open(filepath, "r", encoding="utf-8") as jf:
                                    data = json.load(jf)

                                x_values = []
                                y_values = []

                                for index_key, record in data.get("records_by_index", {}).items():
                                    if X_PARAM in record and Y_PARAM in record:
                                        x_raw = record[X_PARAM]["raw"]
                                        y_raw = record[Y_PARAM]["raw"]

                                        x_values.append(float(x_raw))
                                        y_values.append(float(y_raw) * Y_MULTIPLIER)

                                sorted_points = sorted(zip(x_values, y_values))
                                if sorted_points:
                                    x_values, y_values = zip(*sorted_points)
                                    plot_series[gate_name][corner][temp] = (list(x_values), list(y_values))

                            except Exception as e:
                                print(f"Error reading {filepath}: {e}")

    if not files_found:
        print("No JSON files matching the pattern were found in any directories.")
        return

    num_corners = len(TARGET_CORNERS)
    fig, axes = plt.subplots(1, num_corners, figsize=(6 * num_corners, 6), sharey=True)

    if num_corners == 1:
        axes = [axes]

    for i, corner in enumerate(TARGET_CORNERS):
        ax = axes[i]
        
        # رسم داده‌ها برای هر گیت
        for gate_name in TARGET_GATES.keys():
            corner_data = plot_series[gate_name][corner]
            line_style_base = GATE_STYLES.get(gate_name, "-")

            for temp in sorted(corner_data.keys()):
                x_vals, y_vals = corner_data[temp]
                # استفاده از مارکر و استایل خط برای تشخیص بهتر
                
                # اگر فقط یک گیت داریم، نیازی نیست اسم گیت را در Legend بیاوریم
                label_str = f"{gate_name} ({temp}°C)" if len(TARGET_GATES) > 1 else f"{temp} °C"
                
                ax.plot(
                    x_vals,
                    y_vals,
                    linestyle=line_style_base,
                    marker='o',
                    linewidth=LINE_WIDTH,
                    markersize=MARKER_SIZE,
                    label=label_str,
                )

        ax.set_title(f"Corner: {corner}", fontsize=14, fontweight="bold")
        ax.set_xlabel(X_PARAM.capitalize(), fontsize=12)
        ax.grid(True, which="both", linestyle="--", linewidth=0.5, alpha=0.7)
        
        legend_title = "Gate & Temp" if len(TARGET_GATES) > 1 else "Temperature"
        ax.legend(title=legend_title, title_fontsize="11", fontsize="9", loc="best")

    axes[0].set_ylabel(f"{Y_PARAM} ({Y_UNIT})", fontsize=12)

    # تنظیم عنوان اصلی (Suptitle) بر اساس تعداد گیت‌ها
    if len(TARGET_GATES) > 1:
        title_str = f"Comparison: {Y_PARAM.upper()} vs {X_PARAM.capitalize()}"
    else:
        title_str = f"{Y_PARAM.upper()} vs {X_PARAM.capitalize()}"

    fig.suptitle(title_str, fontsize=16, fontweight="bold", y=1.02)

    plt.tight_layout()

    # تنظیم نام فایل خروجی بر اساس تعداد گیت‌ها
    gates_str = "_".join(TARGET_GATES.keys())
    corners_str = "_".join(TARGET_CORNERS)
    
    if len(TARGET_GATES) > 1:
        output_filename = f"Comparison_{gates_str}_{corners_str}_{Y_PARAM}_vs_{X_PARAM}.png"
    else:
        output_filename = f"{gates_str}_plot_{corners_str}_{Y_PARAM}_vs_{X_PARAM}.png"

    plt.savefig(output_filename, dpi=300, bbox_inches="tight")
    print(f"Plot saved successfully as: {output_filename}")

    # plt.show()

if __name__ == "__main__":
    plot_data()
