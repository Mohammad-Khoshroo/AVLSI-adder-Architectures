******************** HSPICE BASIC GATES MODELING ********************
*
*   Mohammad Khoshroo - 810102441 
*   Spring 2026
*   AVLSI Course - by Dr. Vahdat
*   Thechnolegy - crn90g_2d5_lk_v1d2p1.l (90nm)
*   Standard MOSFET Model Name : nch , pch
*   NOR2 SIMULATION
*   TEMP(℃) 10/25/40/55/70
*   CORNER TT/SS/FF/SF/FS
*
**************************** PARAMETERS *****************************

.OPTION NOMOD
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" TT
.INC "../custom_gates.inc"

.PARAM Vdd_val = 1                  $ supply-1 voltage
.PARAM Vss_val = 0                  $ supply-0 voltage
.PARAM beta = 2                     $ un/up
.PARAM L = 180n                     $ Channel length
.PARAM Wn_min = 1u                  $ Minimum Transistor width for n-types
.PARAM Wp_min = 'beta * Wn_min'     $ Minimum Transistor width for p-types


****************************** CIRCUIT ******************************

Xnor inA inB out Vdd Vss NOR2     $ NOR2 GATE Under TEST/SIMULATION

************************* SIMULATION SETTING ************************

* Supplys Voltage Node
Vdd Vdd 0 DC 'Vdd_val'
Vss Vss 0 DC 'Vss_val'

.TRAN 0.01p 2.1n SWEEP DATA=beta_sweep
.TEMP 10 25 40 55 70
.DATA beta_sweep
beta  
1        
2     
3
4
5
.ENDDATA

* ===================================================================
* Timing & Delay
VinA inA 0 PWL(0p 0  125p 0  150p 'Vdd_val'  325p 'Vdd_val'  350p 0  625p 0  650p 'Vdd_val'  825p 'Vdd_val'  850p 0  1500p 0  1525p 'Vdd_val'  2000p 'Vdd_val')
VinB inB 0 PWL(0p 0  500p 0  525p 'Vdd_val'  1000p 'Vdd_val'  1025p 0  1125p 0  1150p 'Vdd_val'  1325p 'Vdd_val'  1350p 0  1625p 0  1650p 'Vdd_val'  1825p 'Vdd_val'  1850p 0  2000p 0)

* -------------------------------------------------------------------
* TEST 1: inB=0, inA changes (Window: 0p to 500p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_A_B0_w1_LH TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=50p TO=225p
.MEASURE TRAN t_out_A_B0_w1_HL TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=50p TO=225p
.MEASURE TRAN t_out_A_B0_w2_LH TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=250p TO=450p
.MEASURE TRAN t_out_A_B0_w2_HL TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=250p TO=450p

* -------------------------------------------------------------------
* TEST 2: inB=1, inA changes (Window: 500p to 1000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_A_B1_w1_LH TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=550p TO=725p
.MEASURE TRAN t_out_A_B1_w1_HL TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=550p TO=725p
.MEASURE TRAN t_out_A_B1_w2_LH TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=750p TO=950p
.MEASURE TRAN t_out_A_B1_w2_HL TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=750p TO=950p

* -------------------------------------------------------------------
* TEST 3: inA=0, inB changes (Window: 1000p to 1500p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_B_A0_w1_LH TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=1050p TO=1225p
.MEASURE TRAN t_out_B_A0_w1_HL TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=1050p TO=1225p
.MEASURE TRAN t_out_B_A0_w2_LH TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=1250p TO=1450p
.MEASURE TRAN t_out_B_A0_w2_HL TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=1250p TO=1450p

* -------------------------------------------------------------------
* TEST 4: inA=1, inB changes (Window: 1500p to 2000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_B_A1_w1_LH TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=1550p TO=1725p
.MEASURE TRAN t_out_B_A1_w1_HL TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=1550p TO=1725p
.MEASURE TRAN t_out_B_A1_w2_LH TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=1750p TO=1950p
.MEASURE TRAN t_out_B_A1_w2_HL TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=1750p TO=1950p

* ===================================================================
* Final Delay Calculations (Separated tpLH, tpHL, and Averaged tp)
* ===================================================================
* --- Delays for Output: out ---
* Maximum Low-to-High (tpLH) for out
.MEASURE TRAN tpLH_out_m1 PARAM='MAX(t_out_A_B0_w1_LH, t_out_A_B0_w2_LH)'
.MEASURE TRAN tpLH_out_m2 PARAM='MAX(tpLH_out_m1, t_out_A_B1_w1_LH)'
.MEASURE TRAN tpLH_out_m3 PARAM='MAX(tpLH_out_m2, t_out_A_B1_w2_LH)'
.MEASURE TRAN tpLH_out_m4 PARAM='MAX(tpLH_out_m3, t_out_B_A0_w1_LH)'
.MEASURE TRAN tpLH_out_m5 PARAM='MAX(tpLH_out_m4, t_out_B_A0_w2_LH)'
.MEASURE TRAN tpLH_out_m6 PARAM='MAX(tpLH_out_m5, t_out_B_A1_w1_LH)'
.MEASURE TRAN tpLH_out PARAM='MAX(tpLH_out_m6, t_out_B_A1_w2_LH)'
* Maximum High-to-Low (tpHL) for out
.MEASURE TRAN tpHL_out_m1 PARAM='MAX(t_out_A_B0_w1_HL, t_out_A_B0_w2_HL)'
.MEASURE TRAN tpHL_out_m2 PARAM='MAX(tpHL_out_m1, t_out_A_B1_w1_HL)'
.MEASURE TRAN tpHL_out_m3 PARAM='MAX(tpHL_out_m2, t_out_A_B1_w2_HL)'
.MEASURE TRAN tpHL_out_m4 PARAM='MAX(tpHL_out_m3, t_out_B_A0_w1_HL)'
.MEASURE TRAN tpHL_out_m5 PARAM='MAX(tpHL_out_m4, t_out_B_A0_w2_HL)'
.MEASURE TRAN tpHL_out_m6 PARAM='MAX(tpHL_out_m5, t_out_B_A1_w1_HL)'
.MEASURE TRAN tpHL_out PARAM='MAX(tpHL_out_m6, t_out_B_A1_w2_HL)'
* Average tp for out
.MEASURE TRAN tp_out PARAM='(tpLH_out + tpHL_out) / 2'

* --- GLOBAL Worst Case Delay ---
.MEASURE TRAN tp_global_max PARAM='tp_out'

* ===================================================================
* Output Voltage Level (Vo)

.MEASURE TRAN VOH_val MAX V(out)
.MEASURE TRAN VOL_val MIN V(out)

* ===================================================================
* Power (P)

.MEASURE TRAN P_avg AVG POWER           $ Average Power
.MEASURE TRAN P_max MAX POWER           $ Maximum (Peak) Power
.MEASURE TRAN PDP PARAM = 'P_avg * tp_out'  $ Power-Delay Product (PDP)

* ===================================================================
* Current (I)

.MEASURE TRAN I_avg AVG  I(Vdd)
.MEASURE TRAN I_peak MIN I(Vdd)

*************************** OUTPUT SETTING **************************

.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(inA) V(inB) V(out)

.ALTER  Run_SF_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" TT   $ Delete previous Corner Models
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" SF       $ Add new Corner Models
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(inA) V(inB) V(out)

.ALTER  Run_FS_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" TT
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" FS
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(inA) V(inB) V(out)

.ALTER  Run_SS_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" TT
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" SS
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(inA) V(inB) V(out)

.ALTER  Run_FF_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" TT
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" FF
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(inA) V(inB) V(out)


* Each output file includes data for a fixed TEMP+Corner with beta parameter sweep

.END