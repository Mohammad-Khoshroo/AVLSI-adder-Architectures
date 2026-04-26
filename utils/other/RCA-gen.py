def generate_hierarchical_rca(n):
        
    prev_n = n // 2
    
    title = f"RCA-{n}bit .SUBCKT"
    stars_count = int((67 - len(title) - 2) / 2)
    header = ("*" * stars_count) + " " + title + " " + ("*" * stars_count)
    
    a_ports = " ".join([f"A{i}" for i in range(n-1, -1, -1)])
    b_ports = " ".join([f"B{i}" for i in range(n-1, -1, -1)])
    s_ports = " ".join([f"S{i}" for i in range(n-1, -1, -1)])
    
    subckt_line = f".SUBCKT RCA{n} {a_ports} {b_ports} Cin {s_ports} Cout Vdd Vss"
    
    a_ports_L = " ".join([f"A{i}" for i in range(prev_n-1, -1, -1)])
    b_ports_L = " ".join([f"B{i}" for i in range(prev_n-1, -1, -1)])
    s_ports_L = " ".join([f"S{i}" for i in range(prev_n-1, -1, -1)])
    
    a_ports_H = " ".join([f"A{i}" for i in range(n-1, prev_n-1, -1)])
    b_ports_H = " ".join([f"B{i}" for i in range(n-1, prev_n-1, -1)])
    s_ports_H = " ".join([f"S{i}" for i in range(n-1, prev_n-1, -1)])
    
    inst_L = f"XRCA_L  {a_ports_L}  {b_ports_L}  Cin   {s_ports_L}  Cmid  Vdd Vss RCA{prev_n}"
    inst_H = f"XRCA_H  {a_ports_H}  {b_ports_H}  Cmid  {s_ports_H}  Cout  Vdd Vss RCA{prev_n}"
    
    result = f"{header}\n\n{subckt_line}\n\n"
    result += f"{inst_L}\n{inst_H}"
    result += f"\n\n.ENDS RCA{n}\n"
    
    return result

n_values = [4, 8, 16, 32, 64]

for n in n_values:
    print(generate_hierarchical_rca(n))
    print("\n" + "="*70 + "\n")
