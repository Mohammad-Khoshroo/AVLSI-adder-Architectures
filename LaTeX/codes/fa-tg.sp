
********************* Transmission Gate .SUBCKT *********************

.SUBCKT TG in out ctrl ctrl_bar Vdd Vss scale=1

Mn  in  ctrl      out  Vss  nch  L='L'  W='Wn_min * scale'
Mp  in  ctrl_bar  out  Vdd  pch  L='L'  W='Wp_min * scale'

.ENDS TG

***************** Transmission BASED ADDER .SUBCKT *****************

.SUBCKT FA_T A B Cin S Cout Vdd Vss

XinvA A   A_bar Vdd Vss INV
XinvC Cin C_bar Vdd Vss INV

$ Propagate TG
Xtg_p          B     P     A_bar  A     Vdd Vss TG
Xtg_pb         B     P_bar A      A_bar Vdd Vss TG

Mpp      A     B     P      Vdd  pch  L='L'  W='Wp_min'
Mnp      A_bar B     P      Vss  nch  L='L'  W='Wn_min'

Mpp_bar  A_bar B     P_bar  Vdd  pch  L='L'  W='Wp_min'
Mnp_bar  A     B     P_bar  Vss  nch  L='L'  W='Wn_min'

$ Sum TG
Xtg_s1  C_bar   S_bar P_bar  P         Vdd Vss TG
Xtg_s2  Cin     S_bar P      P_bar     Vdd Vss TG

$ Cout TG
Xtg_c1  C_bar   Cout_bar   P     P_bar Vdd Vss TG
Xtg_c2  A_bar   Cout_bar   P_bar P     Vdd Vss TG

XinvS  S_bar    S    Vdd Vss INV
XinvCo Cout_bar Cout Vdd Vss INV

.ENDS FA_T
