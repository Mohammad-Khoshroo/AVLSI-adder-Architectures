import json

CONFIG_FILE_PATH = "config.json"
OUTPUT_VEC_PATH = "input.vec"

def generate_vec():
    with open(CONFIG_FILE_PATH, 'r') as f:
        config = json.load(f)

    settings = config['settings']
    inputs = config['pins']['inputs']
    outputs = config['pins']['outputs']
    truth_table = config['truth_table']

    vnames = []
    ios = []
    radixes = []

    for pin, width in inputs.items():
        if width == 1:
            vnames.append(pin)
        else:
            vnames.append(f"{pin}[{width-1}:0]")
        
        ios.extend(['i'] * width)
        radixes.extend(['1'] * width)

    for pin, width in outputs.items():
        if width == 1:
            vnames.append(pin)
        else:
            vnames.append(f"{pin}[{width-1}:0]")
            
        ios.extend(['o'] * width)
        radixes.extend(['1'] * width)

    with open(OUTPUT_VEC_PATH, 'w') as f:
        f.write(f"radix {' '.join(radixes)}\n")
        f.write(f"vname {' '.join(vnames)}\n")
        f.write(f"io {' '.join(ios)}\n")
        f.write(f"tunit {settings['tunit']}\n")
        f.write(f"trise {settings['trise']}\n")
        f.write(f"tfall {settings['tfall']}\n")
        f.write(f"vih {settings['vih']}\n")
        f.write(f"vil {settings['vil']}\n")
        f.write(f"voh {settings['voh']}\n")
        f.write(f"vol {settings['vol']}\n\n")

        current_time = 0
        tp = settings['tp']
        period = settings['period']

        out_x_list = []
        for pin, width in outputs.items():
            out_x_list.append('X' * width)
        out_x_str = ' '.join(out_x_list)

        for in_bits, out_bits in truth_table.items():
            in_val_list = []
            idx = 0
            for pin, width in inputs.items():
                in_val_list.append(in_bits[idx:idx+width])
                idx += width
            in_str = ' '.join(in_val_list)

            out_val_list = []
            idx = 0
            for pin, width in outputs.items():
                out_val_list.append(out_bits[idx:idx+width])
                idx += width
            out_str = ' '.join(out_val_list)

            f.write(f"{current_time} {in_str} {out_x_str}\n")
            f.write(f"{current_time + tp} {in_str} {out_str}\n")
            
            current_time += period

    print(f"File '{OUTPUT_VEC_PATH}' generated successfully!")

if __name__ == "__main__":
    generate_vec()
