******************** HSPICE BASIC GATES MODELING ********************
*
*   Mohammad Khoshroo - 810102441 
*   Spring 2026
*   AVLSI Course - by Dr. Vahdat
*   Thechnolegy - crn90g_2d5_lk_v1d2p1.l (90nm)
*   Standard MOSFET Model Name : nch , pch
*   Brent-Kung Adder 8-bit SIMULATION - POWER 
*   CORNER FS
*
**************************** PARAMETERS *****************************

.OPTION NOMOD
.LIB "../../../../../../include/crn90g_2d5_lk_v1d2p1.lib" FS
.INC "../../../../../../include/BKA.inc"
.VEC "input.vec"

.PARAM Vdd_val = 1                  $ supply-1 voltage
.PARAM Vss_val = 0                  $ supply-0 voltage
.PARAM beta = 2                     $ un/up
.PARAM L = 180n                     $ Channel length
.PARAM Wn_min = 1u                  $ Minimum Transistor width for n-types
.PARAM Wp_min = 'beta * Wn_min'     $ Minimum Transistor width for p-types
.PARAM tr = 50p

****************************** CIRCUIT ******************************

XBKA A8 A7 A6 A5 A4 A3 A2 A1 
+    B8 B7 B6 B5 B4 B3 B2 B1 Cin 
+    S8 S7 S6 S5 S4 S3 S2 S1 Cout Vdd Vss BKA8 $ Brent-Kung Adder 8-bit Under TEST/SIMULATION

************************* SIMULATION SETTING ************************

* Supplys Voltage Node
Vdd  Vdd 0 DC 'Vdd_val'
Vss  Vss 0 DC 'Vss_val'

.TRAN 1p 130000p

* ===================================================================
* Power (P)

.MEASURE TRAN P_avg AVG POWER               $ Average Power
.MEASURE TRAN P_max MAX POWER               $ Maximum (Peak) Power

* ===================================================================
* Current (I)

.MEASURE TRAN I_avg AVG  I(Vdd)
.MEASURE TRAN I_peak MIN I(Vdd)

*************************** OUTPUT SETTING **************************

.OPTION POST= 2 PROBE
.PROBE V(Cout) V(Cin)
+      V(A0) V(A1) V(A2) V(A3) V(A4) V(A5) V(A6) V(A7)
+      V(B0) V(B1) V(B2) V(B3) V(B4) V(B5) V(B6) V(B7)
+      V(S0) V(S1) V(S2) V(S3) V(S4) V(S5) V(S6) V(S7)

.END