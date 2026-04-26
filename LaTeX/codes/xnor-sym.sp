************************** SYM-XNOR .SUBCKT **************************

.SUBCKT XNOR2_SYM in1 in2 out Vdd Vss $ out = ~(in1 ^ in2)

* Generate inverted inputs
Xinv1   in1  in1_bar  Vdd  Vss   INV
Xinv2   in2  in2_bar  Vdd  Vss   INV

* Pull-Down Structure
Mn_R1 X1     in2_bar  Vss   Vss   nch     L= 'L'    W= '2 * Wn_min'
Mn_R2 out    in1      X1    Vss   nch     L= 'L'    W= '2 * Wn_min'

Mn_L1 X2     in2      Vss   Vss   nch     L= 'L'    W= '2 * Wn_min'
Mn_L2 out    in1_bar  X2    Vss   nch     L= 'L'    W= '2 * Wn_min'

* Pull-Up Structure
Mp_L1 Y1     in1      Vdd   Vdd   pch     L= 'L'    W= '2 * Wp_min'
Mp_L2 out    in2      Y1    Vdd   pch     L= 'L'    W= '2 * Wp_min'

Mp_R1 Y2     in1_bar  Vdd   Vdd   pch     L= 'L'    W= '2 * Wp_min'
Mp_R2 out    in2_bar  Y2    Vdd   pch     L= 'L'    W= '2 * Wp_min'

.ENDS XNOR2_SYM