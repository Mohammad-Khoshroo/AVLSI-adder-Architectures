import os
import json
import numpy as np
import matplotlib.pyplot as plt

# ==========================================
# 1. تنظیمات مسیرها و پارامترها
# ==========================================
TARGET_DIRS = [
    r"./simulation/FA/gate-level/delay/",
    r"./simulation/FA/nand-based/delay/",
    r"./simulation/FA/mirror/delay/",
    r"./simulation/FA/TG-based/delay/",
]

DIR_LABELS = ["Gate-Level", "NAND-Based", "Mirror", "TG-Based"]

PARAM_PATHS = [
    ["summary", "avg_case_delay"],                 
    ["summary", "worst_case_delay"],               
    ["summary", "delay", "t_p_s", "avg"],          
    ["summary", "delay", "t_p_cout", "avg"],       
    ["summary", "area"],                           
    ["summary", "measurements", "p_avg", "avg"],   
]

PARAM_LABELS = ["tp(avg)", "tp(worst)", "tp_sum", "tp_cout", "area", "power(avg)"]

COLORS = ['#636EFA', '#EF553B', '#00CC96', '#AB63FA']

# ==========================================
# 2. تابع کمکی برای خواندن مقادیر تو در تو
# ==========================================
def get_nested_value(data_dict, path_list):
    temp = data_dict
    for key in path_list:
        if isinstance(temp, dict) and key in temp:
            temp = temp[key]
        else:
            return 0.0
    return float(temp)

# ==========================================
# 3. استخراج داده‌ها به صورت خام (بدون پیش‌فرض ضرب در 1e12)
# ==========================================
raw_data = {d: [] for d in TARGET_DIRS}

for d in TARGET_DIRS:
    file_path = os.path.join(d, "measure.json") 
    
    if os.path.exists(file_path):
        with open(file_path, 'r') as f:
            file_data = json.load(f)
        
        for path in PARAM_PATHS:
            val = get_nested_value(file_data, path)
            raw_data[d].append(val)
    else:
        print(f"Warning: File not found -> {file_path}")
        raw_data[d] = [0.0] * len(PARAM_PATHS)

# ==========================================
# 4. نرمال‌سازی ستونی (مستقل برای هر پارامتر)
# ==========================================
raw_matrix = np.array([raw_data[d] for d in TARGET_DIRS]) # ماتریس ۴ در ۶

# پیدا کردن ماکسیمم هر ستون (هر پارامتر) برای نرمال‌سازی
max_vals = np.max(raw_matrix, axis=0)
max_vals[max_vals == 0] = 1.0 # جلوگیری از تقسیم بر صفر

normalized_data = {}
for i, d in enumerate(TARGET_DIRS):
    # تقسیم مقادیر هر ستون بر ماکسیمم همان ستون (تمام مقادیر بین 0 و 1 قرار می‌گیرند)
    normalized_data[d] = raw_matrix[i] / max_vals

# ==========================================
# 5. آماده‌سازی زوایا برای نمودار عنکبوتی
# ==========================================
num_vars = len(PARAM_LABELS)
angles = np.linspace(0, 2 * np.pi, num_vars, endpoint=False).tolist()

# بستن حلقه نمودار
angles += angles[:1]

# ==========================================
# 6. رسم نمودار عنکبوتی
# ==========================================
fig, ax = plt.subplots(figsize=(9, 9), subplot_kw=dict(polar=True))

# رسم داده‌های نرمال‌شده
for i, d in enumerate(TARGET_DIRS):
    values = normalized_data[d].tolist()
    values_closed = values + values[:1]  # بستن خط چندضلعی
    
    # رسم خطوط دور
    ax.plot(angles, values_closed, color=COLORS[i % len(COLORS)], linewidth=2, label=DIR_LABELS[i])
    # پر کردن درون چندضلعی
    ax.fill(angles, values_closed, color=COLORS[i % len(COLORS)], alpha=0.15)

# ==========================================
# 7. تنظیمات ظاهری و استایل نمودار
# ==========================================
ax.set_theta_offset(np.pi / 2) # شروع از ساعت ۱۲
ax.set_theta_direction(-1)     # حرکت ساعت‌گرد

# تنظیم نام پارامترها روی پره‌ها
ax.set_xticks(angles[:-1])
ax.set_xticklabels(PARAM_LABELS, fontweight='bold', fontsize=11)

# تنظیم رنج دایره‌ها از 0 تا 1 (نمایش به صورت درصد عملکرد نسبی)
ax.set_ylim(0, 1.05)
ax.set_rgrids([0.2, 0.4, 0.6, 0.8, 1.0], labels=['20%', '40%', '60%', '80%', '100%'], color='grey', size=9)

ax.yaxis.grid(True, color='#E0E0E0', linestyle='--', linewidth=0.8)
ax.xaxis.grid(True, color='#B0B0B0', linestyle='-', linewidth=0.8)

# عنوان و لند
plt.title('Full Adder Architectures Comparison', fontweight='bold', fontsize=13, pad=30)
plt.legend(loc='upper right', bbox_to_anchor=(1.2, 1.1), fontsize=10)

plt.tight_layout()

# ذخیره تصویر با کیفیت بالا
plt.savefig('radar_chart_normalized.png', dpi=300, bbox_inches='tight')
plt.show()
