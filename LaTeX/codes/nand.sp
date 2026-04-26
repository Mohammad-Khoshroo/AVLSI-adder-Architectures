**************************** NAND .SUBCKT ***************************

.SUBCKT NAND2 in1 in2 out Vdd Vss $ out = ~(in1 & in2) 

* Pull-Down Structure
Mn_T    out    in1  X     Vss  nch     L= 'L'    W= '2 * Wn_min'
Mn_B    X      in2  Vss   Vss  nch     L= 'L'    W= '2 * Wn_min'
* Pull-Up Structure
Mp_L    out    in1  Vdd   Vdd  pch     L= 'L'    W= 'Wp_min'
Mp_R    out    in2  Vdd   Vdd  pch     L= 'L'    W= 'Wp_min'

.ENDS NAND2
