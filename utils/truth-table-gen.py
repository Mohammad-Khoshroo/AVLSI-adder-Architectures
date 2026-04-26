import itertools
import json
import re

# ==========================================
# 1. تنظیمات پین‌ها
# ==========================================
INPUT_DEFS = {"A": 8, "B": 8, "Cin":1}

OUTPUT_DEFS = {"S": 8, "Cout": 1}

# ==========================================
# 2. منطق شما
# ==========================================
LOGIC = {"S": "A + B + Cin", "Cout": "(A + B + Cin) >> 8"}


# ==========================================
# 3. مترجم وریلاگ به پایتون
# ==========================================
def translate_verilog_to_python(expr):
    def replace_slice(m):
        var, msb, lsb = m.group(1), int(m.group(2)), int(m.group(3))
        mask = (1 << (msb - lsb + 1)) - 1
        return f"(({var} >> {lsb}) & {mask})"

    def replace_bit(m):
        var, bit = m.group(1), m.group(2)
        return f"(({var} >> {bit}) & 1)"

    expr = re.sub(r"([a-zA-Z_]\w*)\[(\d+):(\d+)\]", replace_slice, expr)
    expr = re.sub(r"([a-zA-Z_]\w*)\[(\d+)\]", replace_bit, expr)
    return expr


# ==========================================
# 4. موتور تولید جدول
# ==========================================
def generate_truth_table():
    compiled_logic = {
        out_name: translate_verilog_to_python(expr) for out_name, expr in LOGIC.items()
    }

    total_in_bits = sum(INPUT_DEFS.values())
    combinations = list(itertools.product([0, 1], repeat=total_in_bits))
    truth_table = {}

    for combo in combinations:
        current_idx = 0
        input_vals = {}
        for name, bits in INPUT_DEFS.items():
            var_bits = combo[current_idx : current_idx + bits]
            input_vals[name] = int("".join(map(str, var_bits)), 2)
            current_idx += bits

        out_str = ""
        for name, bits in OUTPUT_DEFS.items():
            val = eval(compiled_logic[name], {}, input_vals)
            val = val & ((1 << bits) - 1)
            out_str += format(val, f"0{bits}b")

        in_str = "".join(map(str, combo))
        truth_table[in_str] = out_str

    return truth_table


if __name__ == "__main__":
    print(
        "Generating truth table... Please wait (this might take a few seconds for large inputs)."
    )

    table = generate_truth_table()

    # ساخت ساختار دیکشنری نهایی
    output_data = {"truth_table": table}

    # نام فایلی که قرار است ساخته شود
    output_filename = "TB-out.json"

    # نوشتن در فایل
    with open(output_filename, "w", encoding="utf-8") as f:
        json.dump(output_data, f, indent=4)

    print(f"Done! Generated {len(table)} combinations.")
    print(f"The result has been successfully saved to '{output_filename}'.")
