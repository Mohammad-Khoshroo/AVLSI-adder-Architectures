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
]

PARAM_LABELS = ["tp(avg)", "tp(worst)", "tp_sum", "tp_cout"]

COLORS = ['#636EFA', '#EF553B', '#00CC96', '#AB63FA', '#FFA15A', '#19D3F3', '#FF6692', '#B6E880', '#FF97FF', '#FECB52']

# ==========================================
# 2. تابع کمکی برای خواندن مقادیر تو در تو
# ==========================================
def get_nested_value(data_dict, path_list):
    """پیمایش در دیکشنری با استفاده از لیست مسیرها"""
    temp = data_dict
    for key in path_list:
        if isinstance(temp, dict) and key in temp:
            temp = temp[key]
        else:
            return 0.0 # در صورت پیدا نشدن مقدار صفر برمی‌گرداند
    return float(temp)

# ==========================================
# 3. استخراج داده‌ها
# ==========================================
# ایجاد دیکشنری بر اساس اندیس برای نگه‌داری داده‌ها به همراه لیبل تمیز
extracted_data = {label: [] for label in DIR_LABELS}

for idx, d in enumerate(TARGET_DIRS):
    file_path = os.path.join(d, "measure.json") 
    label = DIR_LABELS[idx]  # گرفتن برچسب متناظر با این فولدر
    
    if os.path.exists(file_path):
        with open(file_path, 'r') as f:
            file_data = json.load(f)
        
        for path in PARAM_PATHS:
            val = get_nested_value(file_data, path)
            # تبدیل ثانیه به پیکوثانیه (ضرب در 10 به توان 12)
            val_ps = val * 1e12 
            extracted_data[label].append(val_ps)
    else:
        print(f"Warning: File not found -> {file_path}")
        # اگر فایل پیدا نشد، عدد صفر قرار بده
        extracted_data[label] = [0.0] * len(PARAM_PATHS)

# ==========================================
# 4. رسم نمودار
# ==========================================
fig, ax = plt.subplots(figsize=(10, 6))

x = np.arange(len(PARAM_LABELS))  # مکان‌های روی محور X
width = 0.8 / len(DIR_LABELS)    # عرض هر میله بسته به تعداد پوشه‌ها

# رسم میله‌ها برای هر برچسب تمیز
for i, label in enumerate(DIR_LABELS):
    # محاسبه شیفت مکان میله‌ها برای قرارگیری در کنار هم
    x_offset = x + (i - len(DIR_LABELS)/2 + 0.5) * width
    
    # رسم میله با برچسب تمیز
    rects = ax.bar(x_offset, extracted_data[label], width, 
                   label=label, color=COLORS[i % len(COLORS)], edgecolor='black', linewidth=0.5)
    
    # نمایش اعداد روی میله‌ها
    ax.bar_label(rects, padding=3, fmt='%.2f', fontsize=9)

# ==========================================
# 5. استایل‌دهی به نمودار
# ==========================================
ax.set_ylabel('Time (ps)', fontweight='bold')
ax.set_title('Timing Parameters Comparison', fontweight='bold', fontsize=14, pad=15)
ax.set_xticks(x)
ax.set_xticklabels(PARAM_LABELS, fontweight='bold')
ax.legend(title="Architectures", frameon=True)

# حذف خطوط بالا و راست
ax.spines['top'].set_visible(False)
ax.spines['right'].set_visible(False)

# تنظیم گرید (فقط محور Y و زیر میله‌ها)
ax.set_axisbelow(True)
ax.yaxis.grid(True, linestyle='--', alpha=0.7)

plt.tight_layout()

# ذخیره با کیفیت بالا
plt.savefig('styled_bar_plot.png', dpi=300)
plt.show()
