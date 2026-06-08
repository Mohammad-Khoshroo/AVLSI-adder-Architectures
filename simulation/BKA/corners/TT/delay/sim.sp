************************* HSPICE RCA MODELING ***********************
*
*   Mohammad Khoshroo - 810102441 
*   Spring 2026
*   AVLSI Course - by Dr. Vahdat
*   Technology - crn90g_2d5_lk_v1d2p1.l (90nm)
*   Standard MOSFET Model Name : nch , pch
*   Ripple Carry Adder 8-bit SIMULATION - WORST CASE DELAY
*   CORNER TT
*
**************************** PARAMETERS *****************************

.OPTION NOMOD
.LIB "../../../include/crn90g_2d5_lk_v1d2p1.lib" TT
.INC "../../../include/RCA.inc"
.VEC "input.vec"

.PARAM Vdd_val = 1                  $ supply-1 voltage
.PARAM Vss_val = 0                  $ supply-0 voltage
.PARAM beta = 2                     $ un/up
.PARAM L = 180n                     $ Channel length
.PARAM Wn_min = 1u                  $ Minimum Transistor width for n-types
.PARAM Wp_min = 'beta * Wn_min'     $ Minimum Transistor width for p-types
.PARAM tr = 50p

****************************** CIRCUIT ******************************

Xrca A7 A6 A5 A4 A3 A2 A1 A0 
+    B7 B6 B5 B4 B3 B2 B1 B0 Cin 
+    S7 S6 S5 S4 S3 S2 S1 S0 Cout Vdd Vss RCA8 

************************* SIMULATION SETTING ************************

* Supplies Voltage Node
Vdd  Vdd 0 DC 'Vdd_val'
Vss  Vss 0 DC 'Vss_val'
VCin Cin 0 DC 'Vss_val'

.TRAN 0.1p 8.5n
.TEMP 25

* ===================================================================
* Timing & Delay

.MEASURE TRAN tp_S7_fall 
+ TRIG V(B0) VAL=0.5 RISE=1 TD=1.4n 
+ TARG V(S7) VAL=0.5 FALL=1 TD=1.4n

.MEASURE TRAN tp_Cout_rise 
+ TRIG V(B0) VAL=0.5 RISE=1 TD=1.4n 
+ TARG V(Cout) VAL=0.5 RISE=1 TD=1.4n

.MEASURE TRAN tp_S7_rise
+ TRIG V(B0) VAL=0.5 FALL=1 TD=2.9n 
+ TARG V(S7) VAL=0.5 RISE=1 TD=2.9n

.MEASURE TRAN tp_Cout_fall
+ TRIG V(B0) VAL=0.5 FALL=1 TD=2.9n 
+ TARG V(Cout) VAL=0.5 FALL=1 TD=2.9n

* Maximum delay calculation
.MEASURE TRAN tp_max PARAM='MAX(MAX(tp_S7_fall, tp_Cout_rise), MAX(tp_S7_rise, tp_Cout_fall))'

* ===================================================================
* Power (P)

.MEASURE TRAN P_avg AVG POWER               $ Average Power
.MEASURE TRAN P_max MAX POWER               $ Maximum (Peak) Power
.MEASURE TRAN PDP PARAM='P_avg * tp_max'    $ Worst-Case Power-Delay Product (PDP)

* ===================================================================
* Current (I)

.MEASURE TRAN I_avg AVG  I(Vdd)
.MEASURE TRAN I_peak MIN I(Vdd)


*************************** OUTPUT SETTING **************************

.OPTION POST=2 PROBE RUNLVL=6
.PROBE V(Cout) V(Cin)
+      V(A0) V(A1) V(A2) V(A3) V(A4) V(A5) V(A6) V(A7)
+      V(B0) V(B1) V(B2) V(B3) V(B4) V(B5) V(B6) V(B7)
+      V(S0) V(S1) V(S2) V(S3) V(S4) V(S5) V(S6) V(S7)

.END
