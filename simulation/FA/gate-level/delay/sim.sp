********************* HSPICE FA GATES MODELING **********************
*
*   Mohammad Khoshroo - 810102441 
*   Spring 2026
*   AVLSI Course - by Dr. Vahdat
*   Thechnolegy - crn90g_2d5_lk_v1d2p1.lib (90nm)
*   Standard MOSFET Model Name : nch , pch
*   FA SIMULATION
*   TEMP(℃) 25
*   CORNER TT
*
**************************** PARAMETERS *****************************

.OPTION NOMOD
.LIB "../../../../include/crn90g_2d5_lk_v1d2p1.lib" TT
.INC "../../../../include/FA.inc"

.PARAM Vdd_val = 1                  $ supply-1 voltage
.PARAM Vss_val = 0                  $ supply-0 voltage
.PARAM beta = 2                     $ un/up
.PARAM L = 180n                     $ Channel length
.PARAM Wn_min = 1u                  $ Minimum Transistor width for n-types
.PARAM Wp_min = 'beta * Wn_min'     $ Minimum Transistor width for p-types


****************************** CIRCUIT ******************************

Xfull_adder A B Cin S Cout Vdd Vss FA     $ FA Under TEST/SIMULATION

************************* SIMULATION SETTING ************************

* Supplys Voltage Node
Vdd Vdd 0 DC 'Vdd_val'
Vss Vss 0 DC 'Vss_val'

.TRAN 0.01p 500.0p SWEEP DATA=FA_TRANSISSION
.TEMP 25

.TRAN 0.01p 500.0p SWEEP DATA=FA_TRANSISSION
.TEMP 25

VA A 0 PWL(0p 'a_init*Vdd_val' 75.0p 'a_init*Vdd_val' 125.0p 'a_final*Vdd_val' 500.0p 'a_final*Vdd_val')
VB B 0 PWL(0p 'b_init*Vdd_val' 75.0p 'b_init*Vdd_val' 125.0p 'b_final*Vdd_val' 500.0p 'b_final*Vdd_val')
VCin Cin 0 PWL(0p 'cin_init*Vdd_val' 75.0p 'cin_init*Vdd_val' 125.0p 'cin_final*Vdd_val' 500.0p 'cin_final*Vdd_val')

.DATA FA_TRANSISSION
+ a_init a_final b_init b_final cin_init cin_final is_fall_transition
+ 0        1        0        0        0        0        0        $ SWITCH=A
+ 1        0        0        0        0        0        1        $ SWITCH=A
+ 0        1        1        1        0        0        0        $ SWITCH=A
+ 1        0        1        1        0        0        1        $ SWITCH=A
+ 0        1        0        0        1        1        0        $ SWITCH=A
+ 1        0        0        0        1        1        1        $ SWITCH=A
+ 0        1        1        1        1        1        0        $ SWITCH=A
+ 1        0        1        1        1        1        1        $ SWITCH=A
+ 0        0        0        1        0        0        0        $ SWITCH=B
+ 0        0        1        0        0        0        1        $ SWITCH=B
+ 1        1        0        1        0        0        0        $ SWITCH=B
+ 1        1        1        0        0        0        1        $ SWITCH=B
+ 0        0        0        1        1        1        0        $ SWITCH=B
+ 0        0        1        0        1        1        1        $ SWITCH=B
+ 1        1        0        1        1        1        0        $ SWITCH=B
+ 1        1        1        0        1        1        1        $ SWITCH=B
+ 0        0        0        0        0        1        0        $ SWITCH=Cin
+ 0        0        0        0        1        0        1        $ SWITCH=Cin
+ 1        1        0        0        0        1        0        $ SWITCH=Cin
+ 1        1        0        0        1        0        1        $ SWITCH=Cin
+ 0        0        1        1        0        1        0        $ SWITCH=Cin
+ 0        0        1        1        1        0        1        $ SWITCH=Cin
+ 1        1        1        1        0        1        0        $ SWITCH=Cin
+ 1        1        1        1        1        0        1        $ SWITCH=Cin
.ENDDATA

.MEASURE TRAN tpLH_S_A TRIG V(A) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_S_A TRIG V(A) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' FALL=1
.MEASURE TRAN tpLH_Cout_A TRIG V(A) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_Cout_A TRIG V(A) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' FALL=1
.MEASURE TRAN tpLH_S_B TRIG V(B) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_S_B TRIG V(B) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' FALL=1
.MEASURE TRAN tpLH_Cout_B TRIG V(B) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_Cout_B TRIG V(B) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' FALL=1
.MEASURE TRAN tpLH_S_Cin TRIG V(Cin) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_S_Cin TRIG V(Cin) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' FALL=1
.MEASURE TRAN tpLH_Cout_Cin TRIG V(Cin) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_Cout_Cin TRIG V(Cin) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' FALL=1



* ===================================================================
* Output Voltage Level (Vo)

.MEASURE TRAN VOH_val_cout MAX V(Cout)
.MEASURE TRAN VOL_val_cout MIN V(Cout)
.MEASURE TRAN VOH_val_s    MAX V(S)
.MEASURE TRAN VOL_val_s    MIN V(S)

* ===================================================================
* Power (P)

.MEASURE TRAN P_avg AVG POWER                       $ Average Power
.MEASURE TRAN P_max MAX POWER                       $ Maximum (Peak) Power

* ===================================================================
* Current (I)

.MEASURE TRAN I_avg AVG  I(Vdd)
.MEASURE TRAN I_peak MIN I(Vdd)

*************************** OUTPUT SETTING **************************

.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(A) V(B) V(Cin) V(S) V(Cout)

* .ALTER  Run_SF_Corner
* .DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" TT   $ Delete previous Corner Models
* .LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" SF       $ Add new Corner Models
* .OPTION POST= 2 PROBE RUNLVL=6
* .PROBE V(in) V(out)

* .ALTER  Run_FS_Corner
* .DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" TT
* .LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" FS
* .OPTION POST= 2 PROBE RUNLVL=6
* .PROBE V(in) V(out)

* .ALTER  Run_SS_Corner
* .DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" TT
* .LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" SS
* .OPTION POST= 2 PROBE RUNLVL=6
* .PROBE V(in) V(out)

* .ALTER  Run_FF_Corner
* .DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" TT
* .LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" FF
* .OPTION POST= 2 PROBE RUNLVL=6
* .PROBE V(in) V(out)


* Each output file includes data for a fixed TEMP+Corner with beta parameter sweep

.END