import json

# مسیر فایل JSON خود را در اینجا مشخص کنید
file_path = "./simulation/RCA/corners/FF/power/static/measure.json"


def analyze_static_power(file_path):
    try:
        # ۱. خواندن فایل JSON
        with open(file_path, "r", encoding="utf-8") as file:
            data = json.load(file)

        # ۲. استخراج مقادیر مربوط به توان استاتیک
        measurements = data.get("measurements", {})
        if not measurements:
            print("هیچ داده‌ای در بخش measurements یافت نشد.")
            return

        values = list(measurements.values())

        # ۳. محاسبات میانگین و ماکزیمم
        avg_value = sum(values) / len(values)
        max_value = max(values)

        # ۴. ایجاد یا به‌روزرسانی بخش summary در داده‌ها
        data["summary"] = {"avg": avg_value, "max": max_value}

        # ۵. نوشتن داده‌های جدید در همان فایل JSON
        with open(file_path, "w", encoding="utf-8") as file:
            json.dump(data, file, indent=4, ensure_ascii=False)

        print(
            "محاسبات با موفقیت انجام شد و بخش 'summary' به فایل JSON اضافه گردید."
        )

    except FileNotFoundError:
        print(f"خطا: فایل '{file_path}' پیدا نشد.")
    except json.JSONDecodeError:
        print("خطا: ساختار فایل JSON معتبر نیست.")


# اجرای تابع
analyze_static_power(file_path)
