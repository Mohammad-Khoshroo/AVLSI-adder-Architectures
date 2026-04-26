#!/bin/bash
cd "$(dirname "$0")"
echo 'Organizing files using Linux Bash...'

# ================= TT =================
mkdir -p "TT"
mkdir -p "TT/Temp10"
# --- File Number: 0 ---
cp "sim.tr0" "TT/Temp10/" 2>/dev/null
cp "sim.sw0" "TT/Temp10/" 2>/dev/null
cp "sim.ac0" "TT/Temp10/" 2>/dev/null
mv "sim.tr0" "TT/" 2>/dev/null
mv "sim.sw0" "TT/" 2>/dev/null
mv "sim.ac0" "TT/" 2>/dev/null
mv "sim.mt0" "TT/Temp10/" 2>/dev/null
mv "sim.st0" "TT/Temp10/" 2>/dev/null
mv "sim.ms0" "TT/Temp10/" 2>/dev/null
mv "sim.ma0" "TT/Temp10/" 2>/dev/null

mkdir -p "TT/Temp25"
# --- File Number: 1 ---
cp "sim.tr1" "TT/Temp25/" 2>/dev/null
cp "sim.sw1" "TT/Temp25/" 2>/dev/null
cp "sim.ac1" "TT/Temp25/" 2>/dev/null
mv "sim.tr1" "TT/" 2>/dev/null
mv "sim.sw1" "TT/" 2>/dev/null
mv "sim.ac1" "TT/" 2>/dev/null
mv "sim.mt1" "TT/Temp25/" 2>/dev/null
mv "sim.st1" "TT/Temp25/" 2>/dev/null
mv "sim.ms1" "TT/Temp25/" 2>/dev/null
mv "sim.ma1" "TT/Temp25/" 2>/dev/null

mkdir -p "TT/Temp40"
# --- File Number: 2 ---
cp "sim.tr2" "TT/Temp40/" 2>/dev/null
cp "sim.sw2" "TT/Temp40/" 2>/dev/null
cp "sim.ac2" "TT/Temp40/" 2>/dev/null
mv "sim.tr2" "TT/" 2>/dev/null
mv "sim.sw2" "TT/" 2>/dev/null
mv "sim.ac2" "TT/" 2>/dev/null
mv "sim.mt2" "TT/Temp40/" 2>/dev/null
mv "sim.st2" "TT/Temp40/" 2>/dev/null
mv "sim.ms2" "TT/Temp40/" 2>/dev/null
mv "sim.ma2" "TT/Temp40/" 2>/dev/null

mkdir -p "TT/Temp55"
# --- File Number: 3 ---
cp "sim.tr3" "TT/Temp55/" 2>/dev/null
cp "sim.sw3" "TT/Temp55/" 2>/dev/null
cp "sim.ac3" "TT/Temp55/" 2>/dev/null
mv "sim.tr3" "TT/" 2>/dev/null
mv "sim.sw3" "TT/" 2>/dev/null
mv "sim.ac3" "TT/" 2>/dev/null
mv "sim.mt3" "TT/Temp55/" 2>/dev/null
mv "sim.st3" "TT/Temp55/" 2>/dev/null
mv "sim.ms3" "TT/Temp55/" 2>/dev/null
mv "sim.ma3" "TT/Temp55/" 2>/dev/null

mkdir -p "TT/Temp70"
# --- File Number: 4 ---
cp "sim.tr4" "TT/Temp70/" 2>/dev/null
cp "sim.sw4" "TT/Temp70/" 2>/dev/null
cp "sim.ac4" "TT/Temp70/" 2>/dev/null
mv "sim.tr4" "TT/" 2>/dev/null
mv "sim.sw4" "TT/" 2>/dev/null
mv "sim.ac4" "TT/" 2>/dev/null
mv "sim.mt4" "TT/Temp70/" 2>/dev/null
mv "sim.st4" "TT/Temp70/" 2>/dev/null
mv "sim.ms4" "TT/Temp70/" 2>/dev/null
mv "sim.ma4" "TT/Temp70/" 2>/dev/null

# --- Alter Files (ic, pa) for TT ---
mv "sim.ic0" "TT/" 2>/dev/null
mv "sim.pa0" "TT/" 2>/dev/null

# ================= SF =================
mkdir -p "SF"
mkdir -p "SF/Temp10"
# --- File Number: 5 ---
cp "sim.tr5" "SF/Temp10/" 2>/dev/null
cp "sim.sw5" "SF/Temp10/" 2>/dev/null
cp "sim.ac5" "SF/Temp10/" 2>/dev/null
mv "sim.tr5" "SF/" 2>/dev/null
mv "sim.sw5" "SF/" 2>/dev/null
mv "sim.ac5" "SF/" 2>/dev/null
mv "sim.mt5" "SF/Temp10/" 2>/dev/null
mv "sim.st5" "SF/Temp10/" 2>/dev/null
mv "sim.ms5" "SF/Temp10/" 2>/dev/null
mv "sim.ma5" "SF/Temp10/" 2>/dev/null

mkdir -p "SF/Temp25"
# --- File Number: 6 ---
cp "sim.tr6" "SF/Temp25/" 2>/dev/null
cp "sim.sw6" "SF/Temp25/" 2>/dev/null
cp "sim.ac6" "SF/Temp25/" 2>/dev/null
mv "sim.tr6" "SF/" 2>/dev/null
mv "sim.sw6" "SF/" 2>/dev/null
mv "sim.ac6" "SF/" 2>/dev/null
mv "sim.mt6" "SF/Temp25/" 2>/dev/null
mv "sim.st6" "SF/Temp25/" 2>/dev/null
mv "sim.ms6" "SF/Temp25/" 2>/dev/null
mv "sim.ma6" "SF/Temp25/" 2>/dev/null

mkdir -p "SF/Temp40"
# --- File Number: 7 ---
cp "sim.tr7" "SF/Temp40/" 2>/dev/null
cp "sim.sw7" "SF/Temp40/" 2>/dev/null
cp "sim.ac7" "SF/Temp40/" 2>/dev/null
mv "sim.tr7" "SF/" 2>/dev/null
mv "sim.sw7" "SF/" 2>/dev/null
mv "sim.ac7" "SF/" 2>/dev/null
mv "sim.mt7" "SF/Temp40/" 2>/dev/null
mv "sim.st7" "SF/Temp40/" 2>/dev/null
mv "sim.ms7" "SF/Temp40/" 2>/dev/null
mv "sim.ma7" "SF/Temp40/" 2>/dev/null

mkdir -p "SF/Temp55"
# --- File Number: 8 ---
cp "sim.tr8" "SF/Temp55/" 2>/dev/null
cp "sim.sw8" "SF/Temp55/" 2>/dev/null
cp "sim.ac8" "SF/Temp55/" 2>/dev/null
mv "sim.tr8" "SF/" 2>/dev/null
mv "sim.sw8" "SF/" 2>/dev/null
mv "sim.ac8" "SF/" 2>/dev/null
mv "sim.mt8" "SF/Temp55/" 2>/dev/null
mv "sim.st8" "SF/Temp55/" 2>/dev/null
mv "sim.ms8" "SF/Temp55/" 2>/dev/null
mv "sim.ma8" "SF/Temp55/" 2>/dev/null

mkdir -p "SF/Temp70"
# --- File Number: 9 ---
cp "sim.tr9" "SF/Temp70/" 2>/dev/null
cp "sim.sw9" "SF/Temp70/" 2>/dev/null
cp "sim.ac9" "SF/Temp70/" 2>/dev/null
mv "sim.tr9" "SF/" 2>/dev/null
mv "sim.sw9" "SF/" 2>/dev/null
mv "sim.ac9" "SF/" 2>/dev/null
mv "sim.mt9" "SF/Temp70/" 2>/dev/null
mv "sim.st9" "SF/Temp70/" 2>/dev/null
mv "sim.ms9" "SF/Temp70/" 2>/dev/null
mv "sim.ma9" "SF/Temp70/" 2>/dev/null

# --- Alter Files (ic, pa) for SF ---
mv "sim.ic1" "SF/" 2>/dev/null
mv "sim.pa1" "SF/" 2>/dev/null

# ================= FS =================
mkdir -p "FS"
mkdir -p "FS/Temp10"
# --- File Number: 10 ---
cp "sim.tr10" "FS/Temp10/" 2>/dev/null
cp "sim.sw10" "FS/Temp10/" 2>/dev/null
cp "sim.ac10" "FS/Temp10/" 2>/dev/null
mv "sim.tr10" "FS/" 2>/dev/null
mv "sim.sw10" "FS/" 2>/dev/null
mv "sim.ac10" "FS/" 2>/dev/null
mv "sim.mt10" "FS/Temp10/" 2>/dev/null
mv "sim.st10" "FS/Temp10/" 2>/dev/null
mv "sim.ms10" "FS/Temp10/" 2>/dev/null
mv "sim.ma10" "FS/Temp10/" 2>/dev/null

mkdir -p "FS/Temp25"
# --- File Number: 11 ---
cp "sim.tr11" "FS/Temp25/" 2>/dev/null
cp "sim.sw11" "FS/Temp25/" 2>/dev/null
cp "sim.ac11" "FS/Temp25/" 2>/dev/null
mv "sim.tr11" "FS/" 2>/dev/null
mv "sim.sw11" "FS/" 2>/dev/null
mv "sim.ac11" "FS/" 2>/dev/null
mv "sim.mt11" "FS/Temp25/" 2>/dev/null
mv "sim.st11" "FS/Temp25/" 2>/dev/null
mv "sim.ms11" "FS/Temp25/" 2>/dev/null
mv "sim.ma11" "FS/Temp25/" 2>/dev/null

mkdir -p "FS/Temp40"
# --- File Number: 12 ---
cp "sim.tr12" "FS/Temp40/" 2>/dev/null
cp "sim.sw12" "FS/Temp40/" 2>/dev/null
cp "sim.ac12" "FS/Temp40/" 2>/dev/null
mv "sim.tr12" "FS/" 2>/dev/null
mv "sim.sw12" "FS/" 2>/dev/null
mv "sim.ac12" "FS/" 2>/dev/null
mv "sim.mt12" "FS/Temp40/" 2>/dev/null
mv "sim.st12" "FS/Temp40/" 2>/dev/null
mv "sim.ms12" "FS/Temp40/" 2>/dev/null
mv "sim.ma12" "FS/Temp40/" 2>/dev/null

mkdir -p "FS/Temp55"
# --- File Number: 13 ---
cp "sim.tr13" "FS/Temp55/" 2>/dev/null
cp "sim.sw13" "FS/Temp55/" 2>/dev/null
cp "sim.ac13" "FS/Temp55/" 2>/dev/null
mv "sim.tr13" "FS/" 2>/dev/null
mv "sim.sw13" "FS/" 2>/dev/null
mv "sim.ac13" "FS/" 2>/dev/null
mv "sim.mt13" "FS/Temp55/" 2>/dev/null
mv "sim.st13" "FS/Temp55/" 2>/dev/null
mv "sim.ms13" "FS/Temp55/" 2>/dev/null
mv "sim.ma13" "FS/Temp55/" 2>/dev/null

mkdir -p "FS/Temp70"
# --- File Number: 14 ---
cp "sim.tr14" "FS/Temp70/" 2>/dev/null
cp "sim.sw14" "FS/Temp70/" 2>/dev/null
cp "sim.ac14" "FS/Temp70/" 2>/dev/null
mv "sim.tr14" "FS/" 2>/dev/null
mv "sim.sw14" "FS/" 2>/dev/null
mv "sim.ac14" "FS/" 2>/dev/null
mv "sim.mt14" "FS/Temp70/" 2>/dev/null
mv "sim.st14" "FS/Temp70/" 2>/dev/null
mv "sim.ms14" "FS/Temp70/" 2>/dev/null
mv "sim.ma14" "FS/Temp70/" 2>/dev/null

# --- Alter Files (ic, pa) for FS ---
mv "sim.ic2" "FS/" 2>/dev/null
mv "sim.pa2" "FS/" 2>/dev/null

# ================= SS =================
mkdir -p "SS"
mkdir -p "SS/Temp10"
# --- File Number: 15 ---
cp "sim.tr15" "SS/Temp10/" 2>/dev/null
cp "sim.sw15" "SS/Temp10/" 2>/dev/null
cp "sim.ac15" "SS/Temp10/" 2>/dev/null
mv "sim.tr15" "SS/" 2>/dev/null
mv "sim.sw15" "SS/" 2>/dev/null
mv "sim.ac15" "SS/" 2>/dev/null
mv "sim.mt15" "SS/Temp10/" 2>/dev/null
mv "sim.st15" "SS/Temp10/" 2>/dev/null
mv "sim.ms15" "SS/Temp10/" 2>/dev/null
mv "sim.ma15" "SS/Temp10/" 2>/dev/null

mkdir -p "SS/Temp25"
# --- File Number: 16 ---
cp "sim.tr16" "SS/Temp25/" 2>/dev/null
cp "sim.sw16" "SS/Temp25/" 2>/dev/null
cp "sim.ac16" "SS/Temp25/" 2>/dev/null
mv "sim.tr16" "SS/" 2>/dev/null
mv "sim.sw16" "SS/" 2>/dev/null
mv "sim.ac16" "SS/" 2>/dev/null
mv "sim.mt16" "SS/Temp25/" 2>/dev/null
mv "sim.st16" "SS/Temp25/" 2>/dev/null
mv "sim.ms16" "SS/Temp25/" 2>/dev/null
mv "sim.ma16" "SS/Temp25/" 2>/dev/null

mkdir -p "SS/Temp40"
# --- File Number: 17 ---
cp "sim.tr17" "SS/Temp40/" 2>/dev/null
cp "sim.sw17" "SS/Temp40/" 2>/dev/null
cp "sim.ac17" "SS/Temp40/" 2>/dev/null
mv "sim.tr17" "SS/" 2>/dev/null
mv "sim.sw17" "SS/" 2>/dev/null
mv "sim.ac17" "SS/" 2>/dev/null
mv "sim.mt17" "SS/Temp40/" 2>/dev/null
mv "sim.st17" "SS/Temp40/" 2>/dev/null
mv "sim.ms17" "SS/Temp40/" 2>/dev/null
mv "sim.ma17" "SS/Temp40/" 2>/dev/null

mkdir -p "SS/Temp55"
# --- File Number: 18 ---
cp "sim.tr18" "SS/Temp55/" 2>/dev/null
cp "sim.sw18" "SS/Temp55/" 2>/dev/null
cp "sim.ac18" "SS/Temp55/" 2>/dev/null
mv "sim.tr18" "SS/" 2>/dev/null
mv "sim.sw18" "SS/" 2>/dev/null
mv "sim.ac18" "SS/" 2>/dev/null
mv "sim.mt18" "SS/Temp55/" 2>/dev/null
mv "sim.st18" "SS/Temp55/" 2>/dev/null
mv "sim.ms18" "SS/Temp55/" 2>/dev/null
mv "sim.ma18" "SS/Temp55/" 2>/dev/null

mkdir -p "SS/Temp70"
# --- File Number: 19 ---
cp "sim.tr19" "SS/Temp70/" 2>/dev/null
cp "sim.sw19" "SS/Temp70/" 2>/dev/null
cp "sim.ac19" "SS/Temp70/" 2>/dev/null
mv "sim.tr19" "SS/" 2>/dev/null
mv "sim.sw19" "SS/" 2>/dev/null
mv "sim.ac19" "SS/" 2>/dev/null
mv "sim.mt19" "SS/Temp70/" 2>/dev/null
mv "sim.st19" "SS/Temp70/" 2>/dev/null
mv "sim.ms19" "SS/Temp70/" 2>/dev/null
mv "sim.ma19" "SS/Temp70/" 2>/dev/null

# --- Alter Files (ic, pa) for SS ---
mv "sim.ic3" "SS/" 2>/dev/null
mv "sim.pa3" "SS/" 2>/dev/null

# ================= FF =================
mkdir -p "FF"
mkdir -p "FF/Temp10"
# --- File Number: 20 ---
cp "sim.tr20" "FF/Temp10/" 2>/dev/null
cp "sim.sw20" "FF/Temp10/" 2>/dev/null
cp "sim.ac20" "FF/Temp10/" 2>/dev/null
mv "sim.tr20" "FF/" 2>/dev/null
mv "sim.sw20" "FF/" 2>/dev/null
mv "sim.ac20" "FF/" 2>/dev/null
mv "sim.mt20" "FF/Temp10/" 2>/dev/null
mv "sim.st20" "FF/Temp10/" 2>/dev/null
mv "sim.ms20" "FF/Temp10/" 2>/dev/null
mv "sim.ma20" "FF/Temp10/" 2>/dev/null

mkdir -p "FF/Temp25"
# --- File Number: 21 ---
cp "sim.tr21" "FF/Temp25/" 2>/dev/null
cp "sim.sw21" "FF/Temp25/" 2>/dev/null
cp "sim.ac21" "FF/Temp25/" 2>/dev/null
mv "sim.tr21" "FF/" 2>/dev/null
mv "sim.sw21" "FF/" 2>/dev/null
mv "sim.ac21" "FF/" 2>/dev/null
mv "sim.mt21" "FF/Temp25/" 2>/dev/null
mv "sim.st21" "FF/Temp25/" 2>/dev/null
mv "sim.ms21" "FF/Temp25/" 2>/dev/null
mv "sim.ma21" "FF/Temp25/" 2>/dev/null

mkdir -p "FF/Temp40"
# --- File Number: 22 ---
cp "sim.tr22" "FF/Temp40/" 2>/dev/null
cp "sim.sw22" "FF/Temp40/" 2>/dev/null
cp "sim.ac22" "FF/Temp40/" 2>/dev/null
mv "sim.tr22" "FF/" 2>/dev/null
mv "sim.sw22" "FF/" 2>/dev/null
mv "sim.ac22" "FF/" 2>/dev/null
mv "sim.mt22" "FF/Temp40/" 2>/dev/null
mv "sim.st22" "FF/Temp40/" 2>/dev/null
mv "sim.ms22" "FF/Temp40/" 2>/dev/null
mv "sim.ma22" "FF/Temp40/" 2>/dev/null

mkdir -p "FF/Temp55"
# --- File Number: 23 ---
cp "sim.tr23" "FF/Temp55/" 2>/dev/null
cp "sim.sw23" "FF/Temp55/" 2>/dev/null
cp "sim.ac23" "FF/Temp55/" 2>/dev/null
mv "sim.tr23" "FF/" 2>/dev/null
mv "sim.sw23" "FF/" 2>/dev/null
mv "sim.ac23" "FF/" 2>/dev/null
mv "sim.mt23" "FF/Temp55/" 2>/dev/null
mv "sim.st23" "FF/Temp55/" 2>/dev/null
mv "sim.ms23" "FF/Temp55/" 2>/dev/null
mv "sim.ma23" "FF/Temp55/" 2>/dev/null

mkdir -p "FF/Temp70"
# --- File Number: 24 ---
cp "sim.tr24" "FF/Temp70/" 2>/dev/null
cp "sim.sw24" "FF/Temp70/" 2>/dev/null
cp "sim.ac24" "FF/Temp70/" 2>/dev/null
mv "sim.tr24" "FF/" 2>/dev/null
mv "sim.sw24" "FF/" 2>/dev/null
mv "sim.ac24" "FF/" 2>/dev/null
mv "sim.mt24" "FF/Temp70/" 2>/dev/null
mv "sim.st24" "FF/Temp70/" 2>/dev/null
mv "sim.ms24" "FF/Temp70/" 2>/dev/null
mv "sim.ma24" "FF/Temp70/" 2>/dev/null

# --- Alter Files (ic, pa) for FF ---
mv "sim.ic4" "FF/" 2>/dev/null
mv "sim.pa4" "FF/" 2>/dev/null

echo 'JOB DONE!'
