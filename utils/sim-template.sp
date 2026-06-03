******************** TITLE ********************
*
*   Mohammad Khoshroo - 810102441 
*   Spring 2026
*   AVLSI Course - by Dr. Vahdat
*   Thechnolegy - XXX (XXnm)
*   Standard MOSFET Model Name : XX , XX
*   X SIMULATION
*   TEMP(℃) XX
*   CORNER XX
*
**************************** PARAMETERS *****************************

.OPTION NOMOD
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" TT
.INC "../basic_gates.inc"

.PARAM Vdd_val = 1                  $ supply-1 voltage
.PARAM Vss_val = 0                  $ supply-0 voltage
.PARAM beta = 2                     $ un/up
.PARAM L = 180n                     $ Channel length
.PARAM Wn_min = 1u                  $ Minimum Transistor width for n-types
.PARAM Wp_min = 'beta * Wn_min'     $ Minimum Transistor width for p-types


****************************** CIRCUIT ******************************

* Xmux inA inB sel out Vdd Vss MUX2     $ X GATE Under TEST/SIMULATION

************************* SIMULATION SETTING ************************

* Supplys Voltage Node
Vdd Vdd 0 DC 'Vdd_val'
Vss Vss 0 DC 'Vss_val'

.TRAN 0.01p 13n SWEEP DATA=beta_sweep
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

VinA inA 0 PWL(0p 0  250p 0  300p 'Vdd_val'  650p 'Vdd_val'  700p 0  1250p 0  1300p 'Vdd_val'  1650p 'Vdd_val'  1700p 0  2250p 0  2300p 'Vdd_val'  2650p 'Vdd_val'  2700p 0  3250p 0  3300p 'Vdd_val'  3650p 'Vdd_val'  3700p 0  5000p 0  5050p 'Vdd_val'  6000p 'Vdd_val'  6050p 0  7000p 0  7050p 'Vdd_val'  8000p 'Vdd_val'  8050p 0  9000p 0  9050p 'Vdd_val'  10000p 'Vdd_val'  10050p 0  11000p 0  11050p 'Vdd_val'  12000p 'Vdd_val')
VinB inB 0 PWL(0p 0  1000p 0  1050p 'Vdd_val'  2000p 'Vdd_val'  2050p 0  3000p 0  3050p 'Vdd_val'  4000p 'Vdd_val'  4050p 0  4250p 0  4300p 'Vdd_val'  4650p 'Vdd_val'  4700p 0  5250p 0  5300p 'Vdd_val'  5650p 'Vdd_val'  5700p 0  6250p 0  6300p 'Vdd_val'  6650p 'Vdd_val'  6700p 0  7250p 0  7300p 'Vdd_val'  7650p 'Vdd_val'  7700p 0  10000p 0  10050p 'Vdd_val'  12000p 'Vdd_val')
Vsel sel 0 PWL(0p 0  2000p 0  2050p 'Vdd_val'  4000p 'Vdd_val'  4050p 0  6000p 0  6050p 'Vdd_val'  8000p 'Vdd_val'  8050p 0  8250p 0  8300p 'Vdd_val'  8650p 'Vdd_val'  8700p 0  9250p 0  9300p 'Vdd_val'  9650p 'Vdd_val'  9700p 0  10250p 0  10300p 'Vdd_val'  10650p 'Vdd_val'  10700p 0  11250p 0  11300p 'Vdd_val'  11650p 'Vdd_val'  11700p 0  12000p 0)

* -------------------------------------------------------------------
* TEST 1: inB=0, sel=0, inA changes (Window: 0p to 1000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_A_B0sel0_w1_LH TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=100p TO=450p
.MEASURE TRAN t_out_A_B0sel0_w1_HL TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=100p TO=450p
.MEASURE TRAN t_out_A_B0sel0_w2_LH TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=500p TO=900p
.MEASURE TRAN t_out_A_B0sel0_w2_HL TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=500p TO=900p

* -------------------------------------------------------------------
* TEST 2: inB=1, sel=0, inA changes (Window: 1000p to 2000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_A_B1sel0_w1_LH TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=1100p TO=1450p
.MEASURE TRAN t_out_A_B1sel0_w1_HL TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=1100p TO=1450p
.MEASURE TRAN t_out_A_B1sel0_w2_LH TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=1500p TO=1900p
.MEASURE TRAN t_out_A_B1sel0_w2_HL TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=1500p TO=1900p

* -------------------------------------------------------------------
* TEST 3: inB=0, sel=1, inA changes (Window: 2000p to 3000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_A_B0sel1_w1_LH TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=2100p TO=2450p
.MEASURE TRAN t_out_A_B0sel1_w1_HL TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=2100p TO=2450p
.MEASURE TRAN t_out_A_B0sel1_w2_LH TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=2500p TO=2900p
.MEASURE TRAN t_out_A_B0sel1_w2_HL TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=2500p TO=2900p

* -------------------------------------------------------------------
* TEST 4: inB=1, sel=1, inA changes (Window: 3000p to 4000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_A_B1sel1_w1_LH TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=3100p TO=3450p
.MEASURE TRAN t_out_A_B1sel1_w1_HL TRIG V(inA) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=3100p TO=3450p
.MEASURE TRAN t_out_A_B1sel1_w2_LH TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=3500p TO=3900p
.MEASURE TRAN t_out_A_B1sel1_w2_HL TRIG V(inA) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=3500p TO=3900p

* -------------------------------------------------------------------
* TEST 5: inA=0, sel=0, inB changes (Window: 4000p to 5000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_B_A0sel0_w1_LH TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=4100p TO=4450p
.MEASURE TRAN t_out_B_A0sel0_w1_HL TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=4100p TO=4450p
.MEASURE TRAN t_out_B_A0sel0_w2_LH TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=4500p TO=4900p
.MEASURE TRAN t_out_B_A0sel0_w2_HL TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=4500p TO=4900p

* -------------------------------------------------------------------
* TEST 6: inA=1, sel=0, inB changes (Window: 5000p to 6000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_B_A1sel0_w1_LH TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=5100p TO=5450p
.MEASURE TRAN t_out_B_A1sel0_w1_HL TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=5100p TO=5450p
.MEASURE TRAN t_out_B_A1sel0_w2_LH TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=5500p TO=5900p
.MEASURE TRAN t_out_B_A1sel0_w2_HL TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=5500p TO=5900p

* -------------------------------------------------------------------
* TEST 7: inA=0, sel=1, inB changes (Window: 6000p to 7000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_B_A0sel1_w1_LH TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=6100p TO=6450p
.MEASURE TRAN t_out_B_A0sel1_w1_HL TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=6100p TO=6450p
.MEASURE TRAN t_out_B_A0sel1_w2_LH TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=6500p TO=6900p
.MEASURE TRAN t_out_B_A0sel1_w2_HL TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=6500p TO=6900p

* -------------------------------------------------------------------
* TEST 8: inA=1, sel=1, inB changes (Window: 7000p to 8000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_B_A1sel1_w1_LH TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=7100p TO=7450p
.MEASURE TRAN t_out_B_A1sel1_w1_HL TRIG V(inB) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=7100p TO=7450p
.MEASURE TRAN t_out_B_A1sel1_w2_LH TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=7500p TO=7900p
.MEASURE TRAN t_out_B_A1sel1_w2_HL TRIG V(inB) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=7500p TO=7900p

* -------------------------------------------------------------------
* TEST 9: inA=0, inB=0, sel changes (Window: 8000p to 9000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_sel_A0B0_w1_LH TRIG V(sel) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=8100p TO=8450p
.MEASURE TRAN t_out_sel_A0B0_w1_HL TRIG V(sel) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=8100p TO=8450p
.MEASURE TRAN t_out_sel_A0B0_w2_LH TRIG V(sel) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=8500p TO=8900p
.MEASURE TRAN t_out_sel_A0B0_w2_HL TRIG V(sel) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=8500p TO=8900p

* -------------------------------------------------------------------
* TEST 10: inA=1, inB=0, sel changes (Window: 9000p to 10000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_sel_A1B0_w1_LH TRIG V(sel) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=9100p TO=9450p
.MEASURE TRAN t_out_sel_A1B0_w1_HL TRIG V(sel) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=9100p TO=9450p
.MEASURE TRAN t_out_sel_A1B0_w2_LH TRIG V(sel) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=9500p TO=9900p
.MEASURE TRAN t_out_sel_A1B0_w2_HL TRIG V(sel) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=9500p TO=9900p

* -------------------------------------------------------------------
* TEST 11: inA=0, inB=1, sel changes (Window: 10000p to 11000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_sel_A0B1_w1_LH TRIG V(sel) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=10100p TO=10450p
.MEASURE TRAN t_out_sel_A0B1_w1_HL TRIG V(sel) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=10100p TO=10450p
.MEASURE TRAN t_out_sel_A0B1_w2_LH TRIG V(sel) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=10500p TO=10900p
.MEASURE TRAN t_out_sel_A0B1_w2_HL TRIG V(sel) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=10500p TO=10900p

* -------------------------------------------------------------------
* TEST 12: inA=1, inB=1, sel changes (Window: 11000p to 12000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_out_sel_A1B1_w1_LH TRIG V(sel) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=11100p TO=11450p
.MEASURE TRAN t_out_sel_A1B1_w1_HL TRIG V(sel) VAL='0.5 * Vdd_val' RISE=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=11100p TO=11450p
.MEASURE TRAN t_out_sel_A1B1_w2_LH TRIG V(sel) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' RISE=1 FROM=11500p TO=11900p
.MEASURE TRAN t_out_sel_A1B1_w2_HL TRIG V(sel) VAL='0.5 * Vdd_val' FALL=1 TARG V(out) VAL='0.5 * Vdd_val' FALL=1 FROM=11500p TO=11900p

* ===================================================================
* Final Delay Calculations (Separated tpLH, tpHL, and Averaged tp)
* ===================================================================
* --- Delays for Output: out ---
* Maximum Low-to-High (tpLH) for out
.MEASURE TRAN tpLH_out_m1 PARAM='MAX(t_out_A_B0sel0_w1_LH, t_out_A_B0sel0_w2_LH)'
.MEASURE TRAN tpLH_out_m2 PARAM='MAX(tpLH_out_m1, t_out_A_B1sel0_w1_LH)'
.MEASURE TRAN tpLH_out_m3 PARAM='MAX(tpLH_out_m2, t_out_A_B1sel0_w2_LH)'
.MEASURE TRAN tpLH_out_m4 PARAM='MAX(tpLH_out_m3, t_out_A_B0sel1_w1_LH)'
.MEASURE TRAN tpLH_out_m5 PARAM='MAX(tpLH_out_m4, t_out_A_B0sel1_w2_LH)'
.MEASURE TRAN tpLH_out_m6 PARAM='MAX(tpLH_out_m5, t_out_A_B1sel1_w1_LH)'
.MEASURE TRAN tpLH_out_m7 PARAM='MAX(tpLH_out_m6, t_out_A_B1sel1_w2_LH)'
.MEASURE TRAN tpLH_out_m8 PARAM='MAX(tpLH_out_m7, t_out_B_A0sel0_w1_LH)'
.MEASURE TRAN tpLH_out_m9 PARAM='MAX(tpLH_out_m8, t_out_B_A0sel0_w2_LH)'
.MEASURE TRAN tpLH_out_m10 PARAM='MAX(tpLH_out_m9, t_out_B_A1sel0_w1_LH)'
.MEASURE TRAN tpLH_out_m11 PARAM='MAX(tpLH_out_m10, t_out_B_A1sel0_w2_LH)'
.MEASURE TRAN tpLH_out_m12 PARAM='MAX(tpLH_out_m11, t_out_B_A0sel1_w1_LH)'
.MEASURE TRAN tpLH_out_m13 PARAM='MAX(tpLH_out_m12, t_out_B_A0sel1_w2_LH)'
.MEASURE TRAN tpLH_out_m14 PARAM='MAX(tpLH_out_m13, t_out_B_A1sel1_w1_LH)'
.MEASURE TRAN tpLH_out_m15 PARAM='MAX(tpLH_out_m14, t_out_B_A1sel1_w2_LH)'
.MEASURE TRAN tpLH_out_m16 PARAM='MAX(tpLH_out_m15, t_out_sel_A0B0_w1_LH)'
.MEASURE TRAN tpLH_out_m17 PARAM='MAX(tpLH_out_m16, t_out_sel_A0B0_w2_LH)'
.MEASURE TRAN tpLH_out_m18 PARAM='MAX(tpLH_out_m17, t_out_sel_A1B0_w1_LH)'
.MEASURE TRAN tpLH_out_m19 PARAM='MAX(tpLH_out_m18, t_out_sel_A1B0_w2_LH)'
.MEASURE TRAN tpLH_out_m20 PARAM='MAX(tpLH_out_m19, t_out_sel_A0B1_w1_LH)'
.MEASURE TRAN tpLH_out_m21 PARAM='MAX(tpLH_out_m20, t_out_sel_A0B1_w2_LH)'
.MEASURE TRAN tpLH_out_m22 PARAM='MAX(tpLH_out_m21, t_out_sel_A1B1_w1_LH)'
.MEASURE TRAN tpLH_out PARAM='MAX(tpLH_out_m22, t_out_sel_A1B1_w2_LH)'
* Maximum High-to-Low (tpHL) for out
.MEASURE TRAN tpHL_out_m1 PARAM='MAX(t_out_A_B0sel0_w1_HL, t_out_A_B0sel0_w2_HL)'
.MEASURE TRAN tpHL_out_m2 PARAM='MAX(tpHL_out_m1, t_out_A_B1sel0_w1_HL)'
.MEASURE TRAN tpHL_out_m3 PARAM='MAX(tpHL_out_m2, t_out_A_B1sel0_w2_HL)'
.MEASURE TRAN tpHL_out_m4 PARAM='MAX(tpHL_out_m3, t_out_A_B0sel1_w1_HL)'
.MEASURE TRAN tpHL_out_m5 PARAM='MAX(tpHL_out_m4, t_out_A_B0sel1_w2_HL)'
.MEASURE TRAN tpHL_out_m6 PARAM='MAX(tpHL_out_m5, t_out_A_B1sel1_w1_HL)'
.MEASURE TRAN tpHL_out_m7 PARAM='MAX(tpHL_out_m6, t_out_A_B1sel1_w2_HL)'
.MEASURE TRAN tpHL_out_m8 PARAM='MAX(tpHL_out_m7, t_out_B_A0sel0_w1_HL)'
.MEASURE TRAN tpHL_out_m9 PARAM='MAX(tpHL_out_m8, t_out_B_A0sel0_w2_HL)'
.MEASURE TRAN tpHL_out_m10 PARAM='MAX(tpHL_out_m9, t_out_B_A1sel0_w1_HL)'
.MEASURE TRAN tpHL_out_m11 PARAM='MAX(tpHL_out_m10, t_out_B_A1sel0_w2_HL)'
.MEASURE TRAN tpHL_out_m12 PARAM='MAX(tpHL_out_m11, t_out_B_A0sel1_w1_HL)'
.MEASURE TRAN tpHL_out_m13 PARAM='MAX(tpHL_out_m12, t_out_B_A0sel1_w2_HL)'
.MEASURE TRAN tpHL_out_m14 PARAM='MAX(tpHL_out_m13, t_out_B_A1sel1_w1_HL)'
.MEASURE TRAN tpHL_out_m15 PARAM='MAX(tpHL_out_m14, t_out_B_A1sel1_w2_HL)'
.MEASURE TRAN tpHL_out_m16 PARAM='MAX(tpHL_out_m15, t_out_sel_A0B0_w1_HL)'
.MEASURE TRAN tpHL_out_m17 PARAM='MAX(tpHL_out_m16, t_out_sel_A0B0_w2_HL)'
.MEASURE TRAN tpHL_out_m18 PARAM='MAX(tpHL_out_m17, t_out_sel_A1B0_w1_HL)'
.MEASURE TRAN tpHL_out_m19 PARAM='MAX(tpHL_out_m18, t_out_sel_A1B0_w2_HL)'
.MEASURE TRAN tpHL_out_m20 PARAM='MAX(tpHL_out_m19, t_out_sel_A0B1_w1_HL)'
.MEASURE TRAN tpHL_out_m21 PARAM='MAX(tpHL_out_m20, t_out_sel_A0B1_w2_HL)'
.MEASURE TRAN tpHL_out_m22 PARAM='MAX(tpHL_out_m21, t_out_sel_A1B1_w1_HL)'
.MEASURE TRAN tpHL_out PARAM='MAX(tpHL_out_m22, t_out_sel_A1B1_w2_HL)'
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
.MEASURE TRAN PDP PARAM = 'P_avg * tp_global_max'  $ Power-Delay Product (PDP)

* ===================================================================
* Current (I)

.MEASURE TRAN I_avg AVG  I(Vdd)
.MEASURE TRAN I_peak MIN I(Vdd)

*************************** OUTPUT SETTING **************************

.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(inA) V(inB) V(sel) V(out)

.ALTER  Run_SF_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" TT   $ Delete previous Corner Models
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" SF       $ Add new Corner Models
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(inA) V(inB) V(sel) V(out)

.ALTER  Run_FS_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" TT
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" FS
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(inA) V(inB) V(sel) V(out)

.ALTER  Run_SS_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" TT
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" SS
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(inA) V(inB) V(sel) V(out)

.ALTER  Run_FF_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" TT
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.lib" FF
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(inA) V(inB) V(sel) V(out)


* Each output file includes data for a fixed TEMP+Corner with beta parameter sweep

.END