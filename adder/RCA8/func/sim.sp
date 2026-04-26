******************** HSPICE BASIC GATES MODELING ********************
*
*   Mohammad Khoshroo - 810102441 
*   Spring 2026
*   AVLSI Course - by Dr. Vahdat
*   Thechnolegy - crn90g_2d5_lk_v1d2p1.l (90nm)
*   Standard MOSFET Model Name : nch , pch
*   Ripple Carry Adder 8-bit SIMULATION
*   CORNER TT
*
**************************** PARAMETERS *****************************

.OPTION NOMOD
.LIB "../../../utils/crn90g_2d5_lk_v1d2p1.l" TT
.INC "../../RCA.inc"

.PARAM Vdd_val = 1                  $ supply-1 voltage
.PARAM Vss_val = 0                  $ supply-0 voltage
.PARAM beta = 2                     $ un/up
.PARAM L = 180n                     $ Channel length
.PARAM Wn_min = 1u                  $ Minimum Transistor width for n-types
.PARAM Wp_min = 'beta * Wn_min'     $ Minimum Transistor width for p-types
.PARAM tr = 20p

****************************** CIRCUIT ******************************

Xrca A7 A6 A5 A4 A3 A2 A1 A0 
+    B7 B6 B5 B4 B3 B2 B1 B0 Cin 
+    S7 S6 S5 S4 S3 S2 S1 S0 Cout Vdd Vss RCA8 $ Ripple Carry Adder 8-bit GATE Under TEST/SIMULATION

************************* SIMULATION SETTING ************************

* Supplys Voltage Node
Vdd  Vdd 0 DC 'Vdd_val'
Vss  Vss 0 DC 'Vss_val'

.VEC "input.vec"

.TRAN 1n 524287n

*************************** OUTPUT SETTING **************************

.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(Cout) V(Cin)
+      V(A0) V(A1) V(A2) V(A3) V(A4) V(A5) V(A6) V(A7)
+      V(B0) V(B1) V(B2) V(B3) V(B4) V(B5) V(B6) V(B7)
+      V(S0) V(S1) V(S2) V(S3) V(S4) V(S5) V(S6) V(S7)

.END