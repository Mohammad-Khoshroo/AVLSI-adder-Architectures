@echo off
echo Organizing files using EXACT names (Bug-Free Windows Version)...

REM ================= Sim_Results =================
if not exist "Sim_Results" mkdir "Sim_Results"
if not exist "Sim_Results\Temp15" mkdir "Sim_Results\Temp15"
REM --- File Number: 0 ---
copy "sim.tr0" "Sim_Results\Temp15\" >nul 2>&1
move "sim.tr0" "Sim_Results\" >nul 2>&1
copy "sim.sw0" "Sim_Results\Temp15\" >nul 2>&1
move "sim.sw0" "Sim_Results\" >nul 2>&1
copy "sim.ac0" "Sim_Results\Temp15\" >nul 2>&1
move "sim.ac0" "Sim_Results\" >nul 2>&1
move "sim.mt0" "Sim_Results\Temp15\" >nul 2>&1
move "sim.st0" "Sim_Results\Temp15\" >nul 2>&1
move "sim.ms0" "Sim_Results\Temp15\" >nul 2>&1
move "sim.ma0" "Sim_Results\Temp15\" >nul 2>&1

if not exist "Sim_Results\Temp20" mkdir "Sim_Results\Temp20"
REM --- File Number: 1 ---
copy "sim.tr1" "Sim_Results\Temp20\" >nul 2>&1
move "sim.tr1" "Sim_Results\" >nul 2>&1
copy "sim.sw1" "Sim_Results\Temp20\" >nul 2>&1
move "sim.sw1" "Sim_Results\" >nul 2>&1
copy "sim.ac1" "Sim_Results\Temp20\" >nul 2>&1
move "sim.ac1" "Sim_Results\" >nul 2>&1
move "sim.mt1" "Sim_Results\Temp20\" >nul 2>&1
move "sim.st1" "Sim_Results\Temp20\" >nul 2>&1
move "sim.ms1" "Sim_Results\Temp20\" >nul 2>&1
move "sim.ma1" "Sim_Results\Temp20\" >nul 2>&1

if not exist "Sim_Results\Temp25" mkdir "Sim_Results\Temp25"
REM --- File Number: 2 ---
copy "sim.tr2" "Sim_Results\Temp25\" >nul 2>&1
move "sim.tr2" "Sim_Results\" >nul 2>&1
copy "sim.sw2" "Sim_Results\Temp25\" >nul 2>&1
move "sim.sw2" "Sim_Results\" >nul 2>&1
copy "sim.ac2" "Sim_Results\Temp25\" >nul 2>&1
move "sim.ac2" "Sim_Results\" >nul 2>&1
move "sim.mt2" "Sim_Results\Temp25\" >nul 2>&1
move "sim.st2" "Sim_Results\Temp25\" >nul 2>&1
move "sim.ms2" "Sim_Results\Temp25\" >nul 2>&1
move "sim.ma2" "Sim_Results\Temp25\" >nul 2>&1

if not exist "Sim_Results\Temp30" mkdir "Sim_Results\Temp30"
REM --- File Number: 3 ---
copy "sim.tr3" "Sim_Results\Temp30\" >nul 2>&1
move "sim.tr3" "Sim_Results\" >nul 2>&1
copy "sim.sw3" "Sim_Results\Temp30\" >nul 2>&1
move "sim.sw3" "Sim_Results\" >nul 2>&1
copy "sim.ac3" "Sim_Results\Temp30\" >nul 2>&1
move "sim.ac3" "Sim_Results\" >nul 2>&1
move "sim.mt3" "Sim_Results\Temp30\" >nul 2>&1
move "sim.st3" "Sim_Results\Temp30\" >nul 2>&1
move "sim.ms3" "Sim_Results\Temp30\" >nul 2>&1
move "sim.ma3" "Sim_Results\Temp30\" >nul 2>&1

if not exist "Sim_Results\Temp35" mkdir "Sim_Results\Temp35"
REM --- File Number: 4 ---
copy "sim.tr4" "Sim_Results\Temp35\" >nul 2>&1
move "sim.tr4" "Sim_Results\" >nul 2>&1
copy "sim.sw4" "Sim_Results\Temp35\" >nul 2>&1
move "sim.sw4" "Sim_Results\" >nul 2>&1
copy "sim.ac4" "Sim_Results\Temp35\" >nul 2>&1
move "sim.ac4" "Sim_Results\" >nul 2>&1
move "sim.mt4" "Sim_Results\Temp35\" >nul 2>&1
move "sim.st4" "Sim_Results\Temp35\" >nul 2>&1
move "sim.ms4" "Sim_Results\Temp35\" >nul 2>&1
move "sim.ma4" "Sim_Results\Temp35\" >nul 2>&1

if not exist "Sim_Results\Temp40" mkdir "Sim_Results\Temp40"
REM --- File Number: 5 ---
copy "sim.tr5" "Sim_Results\Temp40\" >nul 2>&1
move "sim.tr5" "Sim_Results\" >nul 2>&1
copy "sim.sw5" "Sim_Results\Temp40\" >nul 2>&1
move "sim.sw5" "Sim_Results\" >nul 2>&1
copy "sim.ac5" "Sim_Results\Temp40\" >nul 2>&1
move "sim.ac5" "Sim_Results\" >nul 2>&1
move "sim.mt5" "Sim_Results\Temp40\" >nul 2>&1
move "sim.st5" "Sim_Results\Temp40\" >nul 2>&1
move "sim.ms5" "Sim_Results\Temp40\" >nul 2>&1
move "sim.ma5" "Sim_Results\Temp40\" >nul 2>&1

if not exist "Sim_Results\Temp45" mkdir "Sim_Results\Temp45"
REM --- File Number: 6 ---
copy "sim.tr6" "Sim_Results\Temp45\" >nul 2>&1
move "sim.tr6" "Sim_Results\" >nul 2>&1
copy "sim.sw6" "Sim_Results\Temp45\" >nul 2>&1
move "sim.sw6" "Sim_Results\" >nul 2>&1
copy "sim.ac6" "Sim_Results\Temp45\" >nul 2>&1
move "sim.ac6" "Sim_Results\" >nul 2>&1
move "sim.mt6" "Sim_Results\Temp45\" >nul 2>&1
move "sim.st6" "Sim_Results\Temp45\" >nul 2>&1
move "sim.ms6" "Sim_Results\Temp45\" >nul 2>&1
move "sim.ma6" "Sim_Results\Temp45\" >nul 2>&1

if not exist "Sim_Results\Temp50" mkdir "Sim_Results\Temp50"
REM --- File Number: 7 ---
copy "sim.tr7" "Sim_Results\Temp50\" >nul 2>&1
move "sim.tr7" "Sim_Results\" >nul 2>&1
copy "sim.sw7" "Sim_Results\Temp50\" >nul 2>&1
move "sim.sw7" "Sim_Results\" >nul 2>&1
copy "sim.ac7" "Sim_Results\Temp50\" >nul 2>&1
move "sim.ac7" "Sim_Results\" >nul 2>&1
move "sim.mt7" "Sim_Results\Temp50\" >nul 2>&1
move "sim.st7" "Sim_Results\Temp50\" >nul 2>&1
move "sim.ms7" "Sim_Results\Temp50\" >nul 2>&1
move "sim.ma7" "Sim_Results\Temp50\" >nul 2>&1

if not exist "Sim_Results\Temp55" mkdir "Sim_Results\Temp55"
REM --- File Number: 8 ---
copy "sim.tr8" "Sim_Results\Temp55\" >nul 2>&1
move "sim.tr8" "Sim_Results\" >nul 2>&1
copy "sim.sw8" "Sim_Results\Temp55\" >nul 2>&1
move "sim.sw8" "Sim_Results\" >nul 2>&1
copy "sim.ac8" "Sim_Results\Temp55\" >nul 2>&1
move "sim.ac8" "Sim_Results\" >nul 2>&1
move "sim.mt8" "Sim_Results\Temp55\" >nul 2>&1
move "sim.st8" "Sim_Results\Temp55\" >nul 2>&1
move "sim.ms8" "Sim_Results\Temp55\" >nul 2>&1
move "sim.ma8" "Sim_Results\Temp55\" >nul 2>&1

if not exist "Sim_Results\Temp60" mkdir "Sim_Results\Temp60"
REM --- File Number: 9 ---
copy "sim.tr9" "Sim_Results\Temp60\" >nul 2>&1
move "sim.tr9" "Sim_Results\" >nul 2>&1
copy "sim.sw9" "Sim_Results\Temp60\" >nul 2>&1
move "sim.sw9" "Sim_Results\" >nul 2>&1
copy "sim.ac9" "Sim_Results\Temp60\" >nul 2>&1
move "sim.ac9" "Sim_Results\" >nul 2>&1
move "sim.mt9" "Sim_Results\Temp60\" >nul 2>&1
move "sim.st9" "Sim_Results\Temp60\" >nul 2>&1
move "sim.ms9" "Sim_Results\Temp60\" >nul 2>&1
move "sim.ma9" "Sim_Results\Temp60\" >nul 2>&1

if not exist "Sim_Results\Temp65" mkdir "Sim_Results\Temp65"
REM --- File Number: 10 ---
copy "sim.tr10" "Sim_Results\Temp65\" >nul 2>&1
move "sim.tr10" "Sim_Results\" >nul 2>&1
copy "sim.sw10" "Sim_Results\Temp65\" >nul 2>&1
move "sim.sw10" "Sim_Results\" >nul 2>&1
copy "sim.ac10" "Sim_Results\Temp65\" >nul 2>&1
move "sim.ac10" "Sim_Results\" >nul 2>&1
move "sim.mt10" "Sim_Results\Temp65\" >nul 2>&1
move "sim.st10" "Sim_Results\Temp65\" >nul 2>&1
move "sim.ms10" "Sim_Results\Temp65\" >nul 2>&1
move "sim.ma10" "Sim_Results\Temp65\" >nul 2>&1

if not exist "Sim_Results\Temp70" mkdir "Sim_Results\Temp70"
REM --- File Number: 11 ---
copy "sim.tr11" "Sim_Results\Temp70\" >nul 2>&1
move "sim.tr11" "Sim_Results\" >nul 2>&1
copy "sim.sw11" "Sim_Results\Temp70\" >nul 2>&1
move "sim.sw11" "Sim_Results\" >nul 2>&1
copy "sim.ac11" "Sim_Results\Temp70\" >nul 2>&1
move "sim.ac11" "Sim_Results\" >nul 2>&1
move "sim.mt11" "Sim_Results\Temp70\" >nul 2>&1
move "sim.st11" "Sim_Results\Temp70\" >nul 2>&1
move "sim.ms11" "Sim_Results\Temp70\" >nul 2>&1
move "sim.ma11" "Sim_Results\Temp70\" >nul 2>&1

if not exist "Sim_Results\Temp75" mkdir "Sim_Results\Temp75"
REM --- File Number: 12 ---
copy "sim.tr12" "Sim_Results\Temp75\" >nul 2>&1
move "sim.tr12" "Sim_Results\" >nul 2>&1
copy "sim.sw12" "Sim_Results\Temp75\" >nul 2>&1
move "sim.sw12" "Sim_Results\" >nul 2>&1
copy "sim.ac12" "Sim_Results\Temp75\" >nul 2>&1
move "sim.ac12" "Sim_Results\" >nul 2>&1
move "sim.mt12" "Sim_Results\Temp75\" >nul 2>&1
move "sim.st12" "Sim_Results\Temp75\" >nul 2>&1
move "sim.ms12" "Sim_Results\Temp75\" >nul 2>&1
move "sim.ma12" "Sim_Results\Temp75\" >nul 2>&1

if not exist "Sim_Results\Temp80" mkdir "Sim_Results\Temp80"
REM --- File Number: 13 ---
copy "sim.tr13" "Sim_Results\Temp80\" >nul 2>&1
move "sim.tr13" "Sim_Results\" >nul 2>&1
copy "sim.sw13" "Sim_Results\Temp80\" >nul 2>&1
move "sim.sw13" "Sim_Results\" >nul 2>&1
copy "sim.ac13" "Sim_Results\Temp80\" >nul 2>&1
move "sim.ac13" "Sim_Results\" >nul 2>&1
move "sim.mt13" "Sim_Results\Temp80\" >nul 2>&1
move "sim.st13" "Sim_Results\Temp80\" >nul 2>&1
move "sim.ms13" "Sim_Results\Temp80\" >nul 2>&1
move "sim.ma13" "Sim_Results\Temp80\" >nul 2>&1

if not exist "Sim_Results\Temp85" mkdir "Sim_Results\Temp85"
REM --- File Number: 14 ---
copy "sim.tr14" "Sim_Results\Temp85\" >nul 2>&1
move "sim.tr14" "Sim_Results\" >nul 2>&1
copy "sim.sw14" "Sim_Results\Temp85\" >nul 2>&1
move "sim.sw14" "Sim_Results\" >nul 2>&1
copy "sim.ac14" "Sim_Results\Temp85\" >nul 2>&1
move "sim.ac14" "Sim_Results\" >nul 2>&1
move "sim.mt14" "Sim_Results\Temp85\" >nul 2>&1
move "sim.st14" "Sim_Results\Temp85\" >nul 2>&1
move "sim.ms14" "Sim_Results\Temp85\" >nul 2>&1
move "sim.ma14" "Sim_Results\Temp85\" >nul 2>&1

if not exist "Sim_Results\Temp90" mkdir "Sim_Results\Temp90"
REM --- File Number: 15 ---
copy "sim.tr15" "Sim_Results\Temp90\" >nul 2>&1
move "sim.tr15" "Sim_Results\" >nul 2>&1
copy "sim.sw15" "Sim_Results\Temp90\" >nul 2>&1
move "sim.sw15" "Sim_Results\" >nul 2>&1
copy "sim.ac15" "Sim_Results\Temp90\" >nul 2>&1
move "sim.ac15" "Sim_Results\" >nul 2>&1
move "sim.mt15" "Sim_Results\Temp90\" >nul 2>&1
move "sim.st15" "Sim_Results\Temp90\" >nul 2>&1
move "sim.ms15" "Sim_Results\Temp90\" >nul 2>&1
move "sim.ma15" "Sim_Results\Temp90\" >nul 2>&1

REM --- Alter Files (ic, pa) for Sim_Results ---
move "sim.ic0" "Sim_Results\" >nul 2>&1
move "sim.pa0" "Sim_Results\" >nul 2>&1

echo JOB DONE!
pause
