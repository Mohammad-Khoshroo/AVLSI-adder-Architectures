import io
import matplotlib.pyplot as plt
import pandas as pd

# ==================== تنظیمات کاربر (پیکربندی) ====================
FILE_PATH = r"./simulation/RCA/mont-carlo/sim.qqt0.csv"  # مسیر فایل ورودی شما

# لیست پارامترهایی که می‌خواهید رسم شوند
PARAMETERS_TO_PLOT = ["tp_avg", "p_avg", "tp_max", "p_max", "vdd_actual"]

# محور افقی
X_AXIS_PARAMETER = "StdNormalQuantiles"

SAVE_PLOT_PATH = "hspice_plot.png"  # مسیر و نام فایل ذخیره شده خروجی
# ==================================================================


def load_hspice_csv(file_path):
    """این تابع هدرهای متنی HSPICE را فیلتر کرده و داده‌ها را به DataFrame تبدیل می‌کند."""
    with open(file_path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    start_idx = -1
    for i, line in enumerate(lines):
        clean_line = line.strip()
        # هدر اصلی جدول معمولاً شامل لیستی از متغیرهاست که با کاما جدا شده‌اند
        # ما دنبال خطی می‌گردیم که شامل نام یکی از پارامترهای کلیدی مثل i_avg یا tp_avg باشد
        if "i_avg" in clean_line and "StdNormalQuantiles" in clean_line:
            start_idx = i
            break
            
    if start_idx == -1:
        # اگر فرمت خاصی بود و پیدا نشد، خط اولی که با هشتگ شروع نمی‌شود و حاوی کاما است را پیدا می‌کنیم
        for i, line in enumerate(lines):
            clean_line = line.strip()
            if not clean_line.startswith(("#", "*", "=")) and "," in clean_line:
                start_idx = i
                break

    if start_idx == -1:
        raise ValueError("خط هدر ستون‌ها در فایل CSV پیدا نشد!")

    # ترکیب خطوط داده از محل هدر به بعد
    csv_data = "".join(lines[start_idx:])
    return pd.read_csv(io.StringIO(csv_data))


def main():
    try:
        # ۱. بارگذاری داده‌ها
        df = load_hspice_csv(FILE_PATH)
        print("دسته‌بندی ستون‌های یافت شده در فایل:")
        print(list(df.columns))

        # ۲. رسم نمودار
        fig, ax1 = plt.subplots(figsize=(10, 6))

        # بررسی اینکه آیا محور افقی مشخص شده و در فایل وجود دارد یا خیر
        use_x = X_AXIS_PARAMETER and X_AXIS_PARAMETER in df.columns
        if use_x:
            # مرتب‌سازی داده‌ها بر اساس محور X برای رسم بدون نقص خطوط
            df = df.sort_values(by=X_AXIS_PARAMETER)
            x_data = df[X_AXIS_PARAMETER]
            ax1.set_xlabel(X_AXIS_PARAMETER, fontsize=11, fontweight="bold")
        else:
            x_data = df.index
            ax1.set_xlabel("Sample Index", fontsize=11, fontweight="bold")

        cmap = plt.get_cmap("tab10")
        
        for i, param in enumerate(PARAMETERS_TO_PLOT):
            # حذف فاصله‌های خالی احتمالی در نام ستون‌ها
            df.columns = df.columns.str.strip()
            param = param.strip()

            if param not in df.columns:
                print(f"هشدار: پارامتر '{param}' در فایل یافت نشد و نادیده گرفته شد.")
                continue

            # ایجاد محور Y دوم در صورت وجود بیش از یک پارامتر برای نمایش بهتر مقیاس‌ها
            if i == 0:
                ax = ax1
                ax.set_ylabel(param, color = cmap(i % 10), fontsize=11)
            else:
                ax = ax1.twinx()
                ax.spines["right"].set_position(("outward", 70 * (i - 1)))
                ax.set_ylabel(param, color = cmap(i % 10), fontsize=10)

            ax.plot(
                x_data,
                df[param],
                marker="o",
                linestyle="-",
                color = cmap(i % 10),
                label=param,
                alpha=0.8,
            )
            ax.tick_params(axis="y", labelcolor=cmap(i % 10))
            ax.grid(True, linestyle=":", alpha=0.6)

        plt.title("Q-Q (Quantile-Quantile) Plot", fontsize=14, fontweight="bold")
        fig.tight_layout()

        # ۳. ذخیره و نمایش
        plt.savefig(SAVE_PLOT_PATH, dpi=300)
        print(f"نمودار با موفقیت در مسیر '{SAVE_PLOT_PATH}' ذخیره شد.")
        
        # در محیط WSL یا لینوکس بدون نمایشگر دسکتاپ، plt.show() ممکن است خطا دهد
        # به همین دلیل آن را داخل try-except می‌گذاریم تا ذخیره فایل بدون مشکل انجام شود
        try:
            plt.show()
        except Exception:
            print("محیط شما بدون دسکتاپ گرافیکی (GUI) است؛ تصویر فقط ذخیره شد و باز نشد.")

    except FileNotFoundError:
        print(f"خطا: فایلی در مسیر '{FILE_PATH}' پیدا نشد. لطفاً مسیر فایل را بررسی کنید.")
    except Exception as e:
        print(f"یک خطا رخ داد: {e}")


if __name__ == "__main__":
    main()
