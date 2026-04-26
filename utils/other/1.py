import matplotlib.pyplot as plt
import numpy as np

# تنظیمات فونت برای نمایش بهتر (اختیاری)
plt.rcParams['font.family'] = 'sans-serif'

# استخراج داده‌ها از جداول (مقادیر بر حسب پیکوثانیه ps هستند)
# شاخص‌ها: S(pLH), S(pHL), S(p), Cout(pLH), Cout(pHL), Cout(p), Total(p)
labels = [
    '$S\ (t_{pLH})$', 
    '$S\ (t_{pHL})$', 
    '$S\ (t_{p})$', 
    '$C_{out}\ (t_{pLH})$', 
    '$C_{out}\ (t_{pHL})$', 
    '$C_{out}\ (t_{p})$', 
    'Total Circuit\ $(t_{p})$'
]

# داده‌های جدول اول (tab:fa-nand-timing)
data_table1 = [213.3, 196.4, 204.85, 256.6, 164.4, 210.5, 210.5]

# داده‌های جدول دوم (tab:fa-timing)
data_table2 = [192.7, 189.0, 190.85, 189.9, 188.1, 189.0, 190.85]

x = np.arange(len(labels))  # مکان برچسب‌ها روی محور ایکس
width = 0.35  # عرض میله‌ها

# ساخت نمودار
fig, ax = plt.subplots(figsize=(12, 6))

# رسم میله‌ها
rects1 = ax.bar(x - width/2, data_table1, width, label='Table 1 (NAND)', color='#e74c3c', edgecolor='black')
rects2 = ax.bar(x + width/2, data_table2, width, label='Table 2 (Base)', color='#3498db', edgecolor='black')

# اضافه کردن متن‌ها، عنوان و برچسب‌های محور
ax.set_ylabel('Delay (ps)', fontsize=12, fontweight='bold')
ax.set_title('Comparison of Delay Parameters in Full Adder Simulation', fontsize=14, fontweight='bold', pad=20)
ax.set_xticks(x)
ax.set_xticklabels(labels, fontsize=11, rotation=15)
ax.legend(fontsize=11)

# اضافه کردن خطوط شبکه پس‌زمینه برای خوانایی بهتر
ax.grid(axis='y', linestyle='--', alpha=0.7)

# تابعی برای نوشتن مقادیر روی هر میله
def autolabel(rects):
    """Attach a text label above each bar in *rects*, displaying its height."""
    for rect in rects:
        height = rect.get_height()
        ax.annotate('{}'.format(height),
                    xy=(rect.get_x() + rect.get_width() / 2, height),
                    xytext=(0, 3),  # 3 points vertical offset
                    textcoords="offset points",
                    ha='center', va='bottom', fontsize=9, rotation=90)

# فراخوانی تابع برای هر دو گروه میله
autolabel(rects1)
autolabel(rects2)

# تنظیم حاشیه‌ها برای جا شدن کامل برچسب‌ها
fig.tight_layout()

plt.savefig(fname= "FA-Comparition")
# نمایش نمودار
plt.show()
