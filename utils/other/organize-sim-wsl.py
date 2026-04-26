import os
import itertools

def create_linux_bash_script():
    print("=== HSPICE Bash Script Generator (LINUX / WSL) ===")
    
    target_dir = input("Enter the full path of the HSPICE output directory \n(Press Enter to use current directory): ").strip()
    if not target_dir:
        target_dir = os.getcwd()
    else:
        if not os.path.exists(target_dir):
            print(f"\nError: The directory '{target_dir}' does not exist!")
            input("Press Enter to exit...")
            return

    design_name = input("Enter your HSPICE output base name (e.g., 'sim')\n[Press Enter for default 'sim']: ").strip()
    if not design_name:
        design_name = "sim"

    has_alter = input("\nDo you have .ALTER blocks? (y/n): ").strip().lower()
    if has_alter == 'y':
        folders_input = input("Enter ALTER names separated by space (Default: TT SF FS SS FF): ").strip()
        main_folders = folders_input.split() if folders_input else ['TT', 'SF', 'FS', 'SS', 'FF']
    else:
        root_input = input("Enter main folder name (Default: 'Sim_Results'): ").strip()
        main_folders = [root_input] if root_input else ['Sim_Results']

    try:
        num_sweeps = int(input("\nHow many nested sweeps do you have? (e.g., 1 for Temp): "))
    except ValueError:
        print("Error: Please enter a valid number!")
        input("Press Enter to exit...")
        return

    sweep_names = []
    sweep_values = []
    
    if num_sweeps > 0:
        names_input = input("\nEnter the names of the sweeps separated by space (e.g., Temp): ").strip()
        sweep_names = names_input.split()
        for name in sweep_names:
            capitalized_name = name.capitalize() 
            vals_input = input(f"Enter values for '{capitalized_name}' (e.g., 10 25 40 55 70): ").strip()
            sweep_values.append(vals_input.split())
    else:
        sweep_values = [['']]
        sweep_names = ['']

    subfolder_combinations = list(itertools.product(*sweep_values)) if num_sweeps > 0 else [('',)]

    wave_extensions = ['tr', 'sw', 'ac']       
    data_extensions = ['mt', 'st', 'ms', 'ma'] 

    sh_filepath = os.path.join(target_dir, "organize.sh")
    
    with open(sh_filepath, "w", encoding="utf-8", newline='\n') as f:
        f.write("#!/bin/bash\n")
        f.write('cd "$(dirname "$0")"\n')
        f.write("echo 'Organizing files using Linux Bash...'\n\n")
        
        file_number = 0
        alter_index = 0
        
        for main_folder in main_folders:
            f.write(f"# ================= {main_folder} =================\n")
            f.write(f"mkdir -p \"{main_folder}\"\n")
            
            for combo in subfolder_combinations:
                current_folder_name = ""
                if num_sweeps > 0:
                    parts = []
                    for i in range(num_sweeps):
                        parts.append(f"{sweep_names[i].capitalize()}{combo[i]}")
                    current_folder_name = "_".join(parts)
                
                full_folder_path = f"{main_folder}/{current_folder_name}" if current_folder_name else main_folder
                
                if current_folder_name:
                    f.write(f"mkdir -p \"{full_folder_path}\"\n")
                
                f.write(f"# --- File Number: {file_number} ---\n")
                
                for ext in wave_extensions:
                    f.write(f"cp \"{design_name}.{ext}{file_number}\" \"{full_folder_path}/\" 2>/dev/null\n")
                
                for ext in wave_extensions:
                    f.write(f"mv \"{design_name}.{ext}{file_number}\" \"{main_folder}/\" 2>/dev/null\n")
                
                for ext in data_extensions:
                    f.write(f"mv \"{design_name}.{ext}{file_number}\" \"{full_folder_path}/\" 2>/dev/null\n")
                
                file_number += 1
                f.write("\n")
                
            f.write(f"# --- Alter Files (ic, pa) for {main_folder} ---\n")
            f.write(f"mv \"{design_name}.ic{alter_index}\" \"{main_folder}/\" 2>/dev/null\n")
            f.write(f"mv \"{design_name}.pa{alter_index}\" \"{main_folder}/\" 2>/dev/null\n")
            f.write("\n")
            
            alter_index += 1
            
        f.write("echo 'JOB DONE!'\n")

    print(f"\nSuccess! 'organize.sh' generated.")
    print("Now open WSL, navigate to this folder, and run: bash organize.sh")

if __name__ == "__main__":
    create_linux_bash_script()
