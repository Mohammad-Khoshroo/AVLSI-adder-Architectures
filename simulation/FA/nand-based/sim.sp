********************* HSPICE FA GATES MODELING **********************
*
*   Mohammad Khoshroo - 810102441 
*   Spring 2026
*   AVLSI Course - by Dr. Vahdat
*   Thechnolegy - crn90g_2d5_lk_v1d2p1.l (90nm)
*   Standard MOSFET Model Name : nch , pch
*   FA NAND BASED SIMULATION
*   TEMP(℃) 25
*   CORNER TT
*
**************************** PARAMETERS *****************************

.OPTION NOMOD
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" TT
.INC "../full_adder.inc"

.PARAM Vdd_val = 1                  $ supply-1 voltage
.PARAM Vss_val = 0                  $ supply-0 voltage
.PARAM beta = 2                     $ un/up
.PARAM L = 180n                     $ Channel length
.PARAM Wn_min = 1u                  $ Minimum Transistor width for n-types
.PARAM Wp_min = 'beta * Wn_min'     $ Minimum Transistor width for p-types


****************************** CIRCUIT ******************************

Xfull_adder A B Cin S Cout Vdd Vss FA_N     $ FA Under TEST/SIMULATION

************************* SIMULATION SETTING ************************

* Supplys Voltage Node
Vdd Vdd 0 DC 'Vdd_val'
Vss Vss 0 DC 'Vss_val'

.TRAN 0.01p 14.41n
.TEMP 25

* ===================================================================
* Timing & Delay

VA A 0 PWL(0p 0  300p 0  360p 'Vdd_val'  780p 'Vdd_val'  840p 0  1500p 0  1560p 'Vdd_val'  1980p 'Vdd_val'  2040p 0  2700p 0  2760p 'Vdd_val'  3180p 'Vdd_val'  3240p 0  3900p 0  3960p 'Vdd_val'  4380p 'Vdd_val'  4440p 0  6000p 0  6060p 'Vdd_val'  7200p 'Vdd_val'  7260p 0  8400p 0  8460p 'Vdd_val'  9600p 'Vdd_val'  9660p 0  10800p 0  10860p 'Vdd_val'  12000p 'Vdd_val'  12060p 0  13200p 0  13260p 'Vdd_val'  14400p 'Vdd_val')
VB B 0 PWL(0p 0  1200p 0  1260p 'Vdd_val'  2400p 'Vdd_val'  2460p 0  3600p 0  3660p 'Vdd_val'  4800p 'Vdd_val'  4860p 0  5100p 0  5160p 'Vdd_val'  5580p 'Vdd_val'  5640p 0  6300p 0  6360p 'Vdd_val'  6780p 'Vdd_val'  6840p 0  7500p 0  7560p 'Vdd_val'  7980p 'Vdd_val'  8040p 0  8700p 0  8760p 'Vdd_val'  9180p 'Vdd_val'  9240p 0  12000p 0  12060p 'Vdd_val'  14400p 'Vdd_val')
VCin Cin 0 PWL(0p 0  2400p 0  2460p 'Vdd_val'  4800p 'Vdd_val'  4860p 0  7200p 0  7260p 'Vdd_val'  9600p 'Vdd_val'  9660p 0  9900p 0  9960p 'Vdd_val'  10380p 'Vdd_val'  10440p 0  11100p 0  11160p 'Vdd_val'  11580p 'Vdd_val'  11640p 0  12300p 0  12360p 'Vdd_val'  12780p 'Vdd_val'  12840p 0  13500p 0  13560p 'Vdd_val'  13980p 'Vdd_val'  14040p 0  14400p 0)

* -------------------------------------------------------------------
* TEST 1: B=0, Cin=0, A changes (Window: 0p to 1200p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_A_B0C0_w1_LH TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=120p TO=540p
.MEASURE TRAN t_S_A_B0C0_w1_HL TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=120p TO=540p
.MEASURE TRAN t_S_A_B0C0_w2_LH TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=600p TO=1080p
.MEASURE TRAN t_S_A_B0C0_w2_HL TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=600p TO=1080p
.MEASURE TRAN t_Cout_A_B0C0_w1_LH TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=120p TO=540p
.MEASURE TRAN t_Cout_A_B0C0_w1_HL TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=120p TO=540p
.MEASURE TRAN t_Cout_A_B0C0_w2_LH TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=600p TO=1080p
.MEASURE TRAN t_Cout_A_B0C0_w2_HL TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=600p TO=1080p

* -------------------------------------------------------------------
* TEST 2: B=1, Cin=0, A changes (Window: 1200p to 2400p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_A_B1C0_w1_LH TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=1320p TO=1740p
.MEASURE TRAN t_S_A_B1C0_w1_HL TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=1320p TO=1740p
.MEASURE TRAN t_S_A_B1C0_w2_LH TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=1800p TO=2280p
.MEASURE TRAN t_S_A_B1C0_w2_HL TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=1800p TO=2280p
.MEASURE TRAN t_Cout_A_B1C0_w1_LH TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=1320p TO=1740p
.MEASURE TRAN t_Cout_A_B1C0_w1_HL TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=1320p TO=1740p
.MEASURE TRAN t_Cout_A_B1C0_w2_LH TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=1800p TO=2280p
.MEASURE TRAN t_Cout_A_B1C0_w2_HL TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=1800p TO=2280p

* -------------------------------------------------------------------
* TEST 3: B=0, Cin=1, A changes (Window: 2400p to 3600p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_A_B0C1_w1_LH TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=2520p TO=2940p
.MEASURE TRAN t_S_A_B0C1_w1_HL TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=2520p TO=2940p
.MEASURE TRAN t_S_A_B0C1_w2_LH TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=3000p TO=3480p
.MEASURE TRAN t_S_A_B0C1_w2_HL TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=3000p TO=3480p
.MEASURE TRAN t_Cout_A_B0C1_w1_LH TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=2520p TO=2940p
.MEASURE TRAN t_Cout_A_B0C1_w1_HL TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=2520p TO=2940p
.MEASURE TRAN t_Cout_A_B0C1_w2_LH TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=3000p TO=3480p
.MEASURE TRAN t_Cout_A_B0C1_w2_HL TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=3000p TO=3480p

* -------------------------------------------------------------------
* TEST 4: B=1, Cin=1, A changes (Window: 3600p to 4800p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_A_B1C1_w1_LH TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=3720p TO=4140p
.MEASURE TRAN t_S_A_B1C1_w1_HL TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=3720p TO=4140p
.MEASURE TRAN t_S_A_B1C1_w2_LH TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=4200p TO=4680p
.MEASURE TRAN t_S_A_B1C1_w2_HL TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=4200p TO=4680p
.MEASURE TRAN t_Cout_A_B1C1_w1_LH TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=3720p TO=4140p
.MEASURE TRAN t_Cout_A_B1C1_w1_HL TRIG V(A) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=3720p TO=4140p
.MEASURE TRAN t_Cout_A_B1C1_w2_LH TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=4200p TO=4680p
.MEASURE TRAN t_Cout_A_B1C1_w2_HL TRIG V(A) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=4200p TO=4680p

* -------------------------------------------------------------------
* TEST 5: A=0, Cin=0, B changes (Window: 4800p to 6000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_B_A0C0_w1_LH TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=4920p TO=5340p
.MEASURE TRAN t_S_B_A0C0_w1_HL TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=4920p TO=5340p
.MEASURE TRAN t_S_B_A0C0_w2_LH TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=5400p TO=5880p
.MEASURE TRAN t_S_B_A0C0_w2_HL TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=5400p TO=5880p
.MEASURE TRAN t_Cout_B_A0C0_w1_LH TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=4920p TO=5340p
.MEASURE TRAN t_Cout_B_A0C0_w1_HL TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=4920p TO=5340p
.MEASURE TRAN t_Cout_B_A0C0_w2_LH TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=5400p TO=5880p
.MEASURE TRAN t_Cout_B_A0C0_w2_HL TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=5400p TO=5880p

* -------------------------------------------------------------------
* TEST 6: A=1, Cin=0, B changes (Window: 6000p to 7200p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_B_A1C0_w1_LH TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=6120p TO=6540p
.MEASURE TRAN t_S_B_A1C0_w1_HL TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=6120p TO=6540p
.MEASURE TRAN t_S_B_A1C0_w2_LH TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=6600p TO=7080p
.MEASURE TRAN t_S_B_A1C0_w2_HL TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=6600p TO=7080p
.MEASURE TRAN t_Cout_B_A1C0_w1_LH TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=6120p TO=6540p
.MEASURE TRAN t_Cout_B_A1C0_w1_HL TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=6120p TO=6540p
.MEASURE TRAN t_Cout_B_A1C0_w2_LH TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=6600p TO=7080p
.MEASURE TRAN t_Cout_B_A1C0_w2_HL TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=6600p TO=7080p

* -------------------------------------------------------------------
* TEST 7: A=0, Cin=1, B changes (Window: 7200p to 8400p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_B_A0C1_w1_LH TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=7320p TO=7740p
.MEASURE TRAN t_S_B_A0C1_w1_HL TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=7320p TO=7740p
.MEASURE TRAN t_S_B_A0C1_w2_LH TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=7800p TO=8280p
.MEASURE TRAN t_S_B_A0C1_w2_HL TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=7800p TO=8280p
.MEASURE TRAN t_Cout_B_A0C1_w1_LH TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=7320p TO=7740p
.MEASURE TRAN t_Cout_B_A0C1_w1_HL TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=7320p TO=7740p
.MEASURE TRAN t_Cout_B_A0C1_w2_LH TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=7800p TO=8280p
.MEASURE TRAN t_Cout_B_A0C1_w2_HL TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=7800p TO=8280p

* -------------------------------------------------------------------
* TEST 8: A=1, Cin=1, B changes (Window: 8400p to 9600p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_B_A1C1_w1_LH TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=8520p TO=8940p
.MEASURE TRAN t_S_B_A1C1_w1_HL TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=8520p TO=8940p
.MEASURE TRAN t_S_B_A1C1_w2_LH TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=9000p TO=9480p
.MEASURE TRAN t_S_B_A1C1_w2_HL TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=9000p TO=9480p
.MEASURE TRAN t_Cout_B_A1C1_w1_LH TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=8520p TO=8940p
.MEASURE TRAN t_Cout_B_A1C1_w1_HL TRIG V(B) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=8520p TO=8940p
.MEASURE TRAN t_Cout_B_A1C1_w2_LH TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=9000p TO=9480p
.MEASURE TRAN t_Cout_B_A1C1_w2_HL TRIG V(B) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=9000p TO=9480p

* -------------------------------------------------------------------
* TEST 9: A=0, B=0, Cin changes (Window: 9600p to 10800p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_C_A0B0_w1_LH TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=9720p TO=10140p
.MEASURE TRAN t_S_C_A0B0_w1_HL TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=9720p TO=10140p
.MEASURE TRAN t_S_C_A0B0_w2_LH TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=10200p TO=10680p
.MEASURE TRAN t_S_C_A0B0_w2_HL TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=10200p TO=10680p
.MEASURE TRAN t_Cout_C_A0B0_w1_LH TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=9720p TO=10140p
.MEASURE TRAN t_Cout_C_A0B0_w1_HL TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=9720p TO=10140p
.MEASURE TRAN t_Cout_C_A0B0_w2_LH TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=10200p TO=10680p
.MEASURE TRAN t_Cout_C_A0B0_w2_HL TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=10200p TO=10680p

* -------------------------------------------------------------------
* TEST 10: A=1, B=0, Cin changes (Window: 10800p to 12000p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_C_A1B0_w1_LH TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=10920p TO=11340p
.MEASURE TRAN t_S_C_A1B0_w1_HL TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=10920p TO=11340p
.MEASURE TRAN t_S_C_A1B0_w2_LH TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=11400p TO=11880p
.MEASURE TRAN t_S_C_A1B0_w2_HL TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=11400p TO=11880p
.MEASURE TRAN t_Cout_C_A1B0_w1_LH TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=10920p TO=11340p
.MEASURE TRAN t_Cout_C_A1B0_w1_HL TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=10920p TO=11340p
.MEASURE TRAN t_Cout_C_A1B0_w2_LH TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=11400p TO=11880p
.MEASURE TRAN t_Cout_C_A1B0_w2_HL TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=11400p TO=11880p

* -------------------------------------------------------------------
* TEST 11: A=0, B=1, Cin changes (Window: 12000p to 13200p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_C_A0B1_w1_LH TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=12120p TO=12540p
.MEASURE TRAN t_S_C_A0B1_w1_HL TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=12120p TO=12540p
.MEASURE TRAN t_S_C_A0B1_w2_LH TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=12600p TO=13080p
.MEASURE TRAN t_S_C_A0B1_w2_HL TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=12600p TO=13080p
.MEASURE TRAN t_Cout_C_A0B1_w1_LH TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=12120p TO=12540p
.MEASURE TRAN t_Cout_C_A0B1_w1_HL TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=12120p TO=12540p
.MEASURE TRAN t_Cout_C_A0B1_w2_LH TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=12600p TO=13080p
.MEASURE TRAN t_Cout_C_A0B1_w2_HL TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=12600p TO=13080p

* -------------------------------------------------------------------
* TEST 12: A=1, B=1, Cin changes (Window: 13200p to 14400p)
* -------------------------------------------------------------------
.MEASURE TRAN t_S_C_A1B1_w1_LH TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=13320p TO=13740p
.MEASURE TRAN t_S_C_A1B1_w1_HL TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=13320p TO=13740p
.MEASURE TRAN t_S_C_A1B1_w2_LH TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' RISE=1 FROM=13800p TO=14280p
.MEASURE TRAN t_S_C_A1B1_w2_HL TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(S) VAL='0.5 * Vdd_val' FALL=1 FROM=13800p TO=14280p
.MEASURE TRAN t_Cout_C_A1B1_w1_LH TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=13320p TO=13740p
.MEASURE TRAN t_Cout_C_A1B1_w1_HL TRIG V(Cin) VAL='0.5 * Vdd_val' RISE=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=13320p TO=13740p
.MEASURE TRAN t_Cout_C_A1B1_w2_LH TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' RISE=1 FROM=13800p TO=14280p
.MEASURE TRAN t_Cout_C_A1B1_w2_HL TRIG V(Cin) VAL='0.5 * Vdd_val' FALL=1 TARG V(Cout) VAL='0.5 * Vdd_val' FALL=1 FROM=13800p TO=14280p

* ===================================================================
* Final Delay Calculations (Separated tpLH, tpHL, and Averaged tp)
* ===================================================================
* --- Delays for Output: S ---
* Maximum Low-to-High (tpLH) for S
.MEASURE TRAN tpLH_S_m1 PARAM='MAX(t_S_A_B0C0_w1_LH, t_S_A_B0C0_w2_LH)'
.MEASURE TRAN tpLH_S_m2 PARAM='MAX(tpLH_S_m1, t_S_A_B1C0_w1_LH)'
.MEASURE TRAN tpLH_S_m3 PARAM='MAX(tpLH_S_m2, t_S_A_B1C0_w2_LH)'
.MEASURE TRAN tpLH_S_m4 PARAM='MAX(tpLH_S_m3, t_S_A_B0C1_w1_LH)'
.MEASURE TRAN tpLH_S_m5 PARAM='MAX(tpLH_S_m4, t_S_A_B0C1_w2_LH)'
.MEASURE TRAN tpLH_S_m6 PARAM='MAX(tpLH_S_m5, t_S_A_B1C1_w1_LH)'
.MEASURE TRAN tpLH_S_m7 PARAM='MAX(tpLH_S_m6, t_S_A_B1C1_w2_LH)'
.MEASURE TRAN tpLH_S_m8 PARAM='MAX(tpLH_S_m7, t_S_B_A0C0_w1_LH)'
.MEASURE TRAN tpLH_S_m9 PARAM='MAX(tpLH_S_m8, t_S_B_A0C0_w2_LH)'
.MEASURE TRAN tpLH_S_m10 PARAM='MAX(tpLH_S_m9, t_S_B_A1C0_w1_LH)'
.MEASURE TRAN tpLH_S_m11 PARAM='MAX(tpLH_S_m10, t_S_B_A1C0_w2_LH)'
.MEASURE TRAN tpLH_S_m12 PARAM='MAX(tpLH_S_m11, t_S_B_A0C1_w1_LH)'
.MEASURE TRAN tpLH_S_m13 PARAM='MAX(tpLH_S_m12, t_S_B_A0C1_w2_LH)'
.MEASURE TRAN tpLH_S_m14 PARAM='MAX(tpLH_S_m13, t_S_B_A1C1_w1_LH)'
.MEASURE TRAN tpLH_S_m15 PARAM='MAX(tpLH_S_m14, t_S_B_A1C1_w2_LH)'
.MEASURE TRAN tpLH_S_m16 PARAM='MAX(tpLH_S_m15, t_S_C_A0B0_w1_LH)'
.MEASURE TRAN tpLH_S_m17 PARAM='MAX(tpLH_S_m16, t_S_C_A0B0_w2_LH)'
.MEASURE TRAN tpLH_S_m18 PARAM='MAX(tpLH_S_m17, t_S_C_A1B0_w1_LH)'
.MEASURE TRAN tpLH_S_m19 PARAM='MAX(tpLH_S_m18, t_S_C_A1B0_w2_LH)'
.MEASURE TRAN tpLH_S_m20 PARAM='MAX(tpLH_S_m19, t_S_C_A0B1_w1_LH)'
.MEASURE TRAN tpLH_S_m21 PARAM='MAX(tpLH_S_m20, t_S_C_A0B1_w2_LH)'
.MEASURE TRAN tpLH_S_m22 PARAM='MAX(tpLH_S_m21, t_S_C_A1B1_w1_LH)'
.MEASURE TRAN tpLH_S PARAM='MAX(tpLH_S_m22, t_S_C_A1B1_w2_LH)'
* Maximum High-to-Low (tpHL) for S
.MEASURE TRAN tpHL_S_m1 PARAM='MAX(t_S_A_B0C0_w1_HL, t_S_A_B0C0_w2_HL)'
.MEASURE TRAN tpHL_S_m2 PARAM='MAX(tpHL_S_m1, t_S_A_B1C0_w1_HL)'
.MEASURE TRAN tpHL_S_m3 PARAM='MAX(tpHL_S_m2, t_S_A_B1C0_w2_HL)'
.MEASURE TRAN tpHL_S_m4 PARAM='MAX(tpHL_S_m3, t_S_A_B0C1_w1_HL)'
.MEASURE TRAN tpHL_S_m5 PARAM='MAX(tpHL_S_m4, t_S_A_B0C1_w2_HL)'
.MEASURE TRAN tpHL_S_m6 PARAM='MAX(tpHL_S_m5, t_S_A_B1C1_w1_HL)'
.MEASURE TRAN tpHL_S_m7 PARAM='MAX(tpHL_S_m6, t_S_A_B1C1_w2_HL)'
.MEASURE TRAN tpHL_S_m8 PARAM='MAX(tpHL_S_m7, t_S_B_A0C0_w1_HL)'
.MEASURE TRAN tpHL_S_m9 PARAM='MAX(tpHL_S_m8, t_S_B_A0C0_w2_HL)'
.MEASURE TRAN tpHL_S_m10 PARAM='MAX(tpHL_S_m9, t_S_B_A1C0_w1_HL)'
.MEASURE TRAN tpHL_S_m11 PARAM='MAX(tpHL_S_m10, t_S_B_A1C0_w2_HL)'
.MEASURE TRAN tpHL_S_m12 PARAM='MAX(tpHL_S_m11, t_S_B_A0C1_w1_HL)'
.MEASURE TRAN tpHL_S_m13 PARAM='MAX(tpHL_S_m12, t_S_B_A0C1_w2_HL)'
.MEASURE TRAN tpHL_S_m14 PARAM='MAX(tpHL_S_m13, t_S_B_A1C1_w1_HL)'
.MEASURE TRAN tpHL_S_m15 PARAM='MAX(tpHL_S_m14, t_S_B_A1C1_w2_HL)'
.MEASURE TRAN tpHL_S_m16 PARAM='MAX(tpHL_S_m15, t_S_C_A0B0_w1_HL)'
.MEASURE TRAN tpHL_S_m17 PARAM='MAX(tpHL_S_m16, t_S_C_A0B0_w2_HL)'
.MEASURE TRAN tpHL_S_m18 PARAM='MAX(tpHL_S_m17, t_S_C_A1B0_w1_HL)'
.MEASURE TRAN tpHL_S_m19 PARAM='MAX(tpHL_S_m18, t_S_C_A1B0_w2_HL)'
.MEASURE TRAN tpHL_S_m20 PARAM='MAX(tpHL_S_m19, t_S_C_A0B1_w1_HL)'
.MEASURE TRAN tpHL_S_m21 PARAM='MAX(tpHL_S_m20, t_S_C_A0B1_w2_HL)'
.MEASURE TRAN tpHL_S_m22 PARAM='MAX(tpHL_S_m21, t_S_C_A1B1_w1_HL)'
.MEASURE TRAN tpHL_S PARAM='MAX(tpHL_S_m22, t_S_C_A1B1_w2_HL)'
* Average tp for S
.MEASURE TRAN tp_S PARAM='(tpLH_S + tpHL_S) / 2'

* --- Delays for Output: Cout ---
* Maximum Low-to-High (tpLH) for Cout
.MEASURE TRAN tpLH_Cout_m1 PARAM='MAX(t_Cout_A_B0C0_w1_LH, t_Cout_A_B0C0_w2_LH)'
.MEASURE TRAN tpLH_Cout_m2 PARAM='MAX(tpLH_Cout_m1, t_Cout_A_B1C0_w1_LH)'
.MEASURE TRAN tpLH_Cout_m3 PARAM='MAX(tpLH_Cout_m2, t_Cout_A_B1C0_w2_LH)'
.MEASURE TRAN tpLH_Cout_m4 PARAM='MAX(tpLH_Cout_m3, t_Cout_A_B0C1_w1_LH)'
.MEASURE TRAN tpLH_Cout_m5 PARAM='MAX(tpLH_Cout_m4, t_Cout_A_B0C1_w2_LH)'
.MEASURE TRAN tpLH_Cout_m6 PARAM='MAX(tpLH_Cout_m5, t_Cout_A_B1C1_w1_LH)'
.MEASURE TRAN tpLH_Cout_m7 PARAM='MAX(tpLH_Cout_m6, t_Cout_A_B1C1_w2_LH)'
.MEASURE TRAN tpLH_Cout_m8 PARAM='MAX(tpLH_Cout_m7, t_Cout_B_A0C0_w1_LH)'
.MEASURE TRAN tpLH_Cout_m9 PARAM='MAX(tpLH_Cout_m8, t_Cout_B_A0C0_w2_LH)'
.MEASURE TRAN tpLH_Cout_m10 PARAM='MAX(tpLH_Cout_m9, t_Cout_B_A1C0_w1_LH)'
.MEASURE TRAN tpLH_Cout_m11 PARAM='MAX(tpLH_Cout_m10, t_Cout_B_A1C0_w2_LH)'
.MEASURE TRAN tpLH_Cout_m12 PARAM='MAX(tpLH_Cout_m11, t_Cout_B_A0C1_w1_LH)'
.MEASURE TRAN tpLH_Cout_m13 PARAM='MAX(tpLH_Cout_m12, t_Cout_B_A0C1_w2_LH)'
.MEASURE TRAN tpLH_Cout_m14 PARAM='MAX(tpLH_Cout_m13, t_Cout_B_A1C1_w1_LH)'
.MEASURE TRAN tpLH_Cout_m15 PARAM='MAX(tpLH_Cout_m14, t_Cout_B_A1C1_w2_LH)'
.MEASURE TRAN tpLH_Cout_m16 PARAM='MAX(tpLH_Cout_m15, t_Cout_C_A0B0_w1_LH)'
.MEASURE TRAN tpLH_Cout_m17 PARAM='MAX(tpLH_Cout_m16, t_Cout_C_A0B0_w2_LH)'
.MEASURE TRAN tpLH_Cout_m18 PARAM='MAX(tpLH_Cout_m17, t_Cout_C_A1B0_w1_LH)'
.MEASURE TRAN tpLH_Cout_m19 PARAM='MAX(tpLH_Cout_m18, t_Cout_C_A1B0_w2_LH)'
.MEASURE TRAN tpLH_Cout_m20 PARAM='MAX(tpLH_Cout_m19, t_Cout_C_A0B1_w1_LH)'
.MEASURE TRAN tpLH_Cout_m21 PARAM='MAX(tpLH_Cout_m20, t_Cout_C_A0B1_w2_LH)'
.MEASURE TRAN tpLH_Cout_m22 PARAM='MAX(tpLH_Cout_m21, t_Cout_C_A1B1_w1_LH)'
.MEASURE TRAN tpLH_Cout PARAM='MAX(tpLH_Cout_m22, t_Cout_C_A1B1_w2_LH)'
* Maximum High-to-Low (tpHL) for Cout
.MEASURE TRAN tpHL_Cout_m1 PARAM='MAX(t_Cout_A_B0C0_w1_HL, t_Cout_A_B0C0_w2_HL)'
.MEASURE TRAN tpHL_Cout_m2 PARAM='MAX(tpHL_Cout_m1, t_Cout_A_B1C0_w1_HL)'
.MEASURE TRAN tpHL_Cout_m3 PARAM='MAX(tpHL_Cout_m2, t_Cout_A_B1C0_w2_HL)'
.MEASURE TRAN tpHL_Cout_m4 PARAM='MAX(tpHL_Cout_m3, t_Cout_A_B0C1_w1_HL)'
.MEASURE TRAN tpHL_Cout_m5 PARAM='MAX(tpHL_Cout_m4, t_Cout_A_B0C1_w2_HL)'
.MEASURE TRAN tpHL_Cout_m6 PARAM='MAX(tpHL_Cout_m5, t_Cout_A_B1C1_w1_HL)'
.MEASURE TRAN tpHL_Cout_m7 PARAM='MAX(tpHL_Cout_m6, t_Cout_A_B1C1_w2_HL)'
.MEASURE TRAN tpHL_Cout_m8 PARAM='MAX(tpHL_Cout_m7, t_Cout_B_A0C0_w1_HL)'
.MEASURE TRAN tpHL_Cout_m9 PARAM='MAX(tpHL_Cout_m8, t_Cout_B_A0C0_w2_HL)'
.MEASURE TRAN tpHL_Cout_m10 PARAM='MAX(tpHL_Cout_m9, t_Cout_B_A1C0_w1_HL)'
.MEASURE TRAN tpHL_Cout_m11 PARAM='MAX(tpHL_Cout_m10, t_Cout_B_A1C0_w2_HL)'
.MEASURE TRAN tpHL_Cout_m12 PARAM='MAX(tpHL_Cout_m11, t_Cout_B_A0C1_w1_HL)'
.MEASURE TRAN tpHL_Cout_m13 PARAM='MAX(tpHL_Cout_m12, t_Cout_B_A0C1_w2_HL)'
.MEASURE TRAN tpHL_Cout_m14 PARAM='MAX(tpHL_Cout_m13, t_Cout_B_A1C1_w1_HL)'
.MEASURE TRAN tpHL_Cout_m15 PARAM='MAX(tpHL_Cout_m14, t_Cout_B_A1C1_w2_HL)'
.MEASURE TRAN tpHL_Cout_m16 PARAM='MAX(tpHL_Cout_m15, t_Cout_C_A0B0_w1_HL)'
.MEASURE TRAN tpHL_Cout_m17 PARAM='MAX(tpHL_Cout_m16, t_Cout_C_A0B0_w2_HL)'
.MEASURE TRAN tpHL_Cout_m18 PARAM='MAX(tpHL_Cout_m17, t_Cout_C_A1B0_w1_HL)'
.MEASURE TRAN tpHL_Cout_m19 PARAM='MAX(tpHL_Cout_m18, t_Cout_C_A1B0_w2_HL)'
.MEASURE TRAN tpHL_Cout_m20 PARAM='MAX(tpHL_Cout_m19, t_Cout_C_A0B1_w1_HL)'
.MEASURE TRAN tpHL_Cout_m21 PARAM='MAX(tpHL_Cout_m20, t_Cout_C_A0B1_w2_HL)'
.MEASURE TRAN tpHL_Cout_m22 PARAM='MAX(tpHL_Cout_m21, t_Cout_C_A1B1_w1_HL)'
.MEASURE TRAN tpHL_Cout PARAM='MAX(tpHL_Cout_m22, t_Cout_C_A1B1_w2_HL)'
* Average tp for Cout
.MEASURE TRAN tp_Cout PARAM='(tpLH_Cout + tpHL_Cout) / 2'

* --- GLOBAL Worst Case Delay ---
.MEASURE TRAN tp_global_max PARAM='MAX(tp_S, tp_Cout)'

* ===================================================================
* Output Voltage Level (Vo)

.MEASURE TRAN VOH_val MAX V(out)
.MEASURE TRAN VOL_val MIN V(out)

* ===================================================================
* Power (P)

.MEASURE TRAN P_avg AVG POWER                       $ Average Power
.MEASURE TRAN P_max MAX POWER                       $ Maximum (Peak) Power
.MEASURE TRAN PDP PARAM = 'P_avg * tp_global_max'   $ Power-Delay Product (PDP)

* ===================================================================
* Current (I)

.MEASURE TRAN I_avg AVG  I(Vdd)
.MEASURE TRAN I_peak MIN I(Vdd)

*************************** OUTPUT SETTING **************************

.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(A) V(B) V(Cin) V(S) V(Cout)

.END