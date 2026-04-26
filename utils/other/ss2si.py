import math


def scientific_to_si(num_str):
    try:
        val = float(num_str)
    except ValueError:
        return "invalid-input"

    if val == 0:
        return "0"

    si_prefixes = {
        24: "Y",  # Yotta
        21: "Z",  # Zetta
        18: "E",  # Exa
        15: "P",  # Peta
        12: "T",  # Tera
        9: "G",  # Giga
        6: "M",  # Mega
        3: "k",  # kilo
        0: "",  # Base unit
        -3: "m",  # milli
        -6: "µ",  # micro
        -9: "n",  # nano
        -12: "p",  # pico
        -15: "f",  # femto
        -18: "a",  # atto
        -21: "z",  # zepto
        -24: "y",  # yocto
    }

    exponent = math.floor(math.log10(abs(val)))

    si_exponent = (exponent // 3) * 3

    if si_exponent > 24:
        si_exponent = 24
    elif si_exponent < -24:
        si_exponent = -24

    new_val = val / (10**si_exponent)
    prefix = si_prefixes.get(si_exponent, "")
    formatted_val = f"{new_val:g}"

    return f"{formatted_val}{prefix}".strip()


test = "enter input"
mode = "time"

result = scientific_to_si(test)
if mode == "time":
    print("\\lr{" + result + "s}")
else:
    print("\\lr{" + result + "}")
