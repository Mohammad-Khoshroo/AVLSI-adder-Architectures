
*********************** MIRROR ADDER .SUBCKT ***********************

.SUBCKT FA_M A B Cin S Cout Vdd Vss

$ MINORITY GATE (Cout_bar)

MpA_propagate   x         A       Vdd      Vdd   pch   L='L'   W='2 * Wp_min'
MpB_propagate   x         B       Vdd      Vdd   pch   L='L'   W='2 * Wp_min'
MpC_propagate   Cout_bar  Cin     x        Vdd   pch   L='L'   W='2 * Wp_min'

MpA_kill        k         A       Vdd      Vdd   pch   L='L'   W='2 * Wp_min'
MpB_kill        Cout_bar  B       k        Vdd   pch   L='L'   W='2 * Wp_min'

MnA_propagate   y         A       Vss      Vss   nch   L='L'   W='2 * Wn_min'
MnB_propagate   y         B       Vss      Vss   nch   L='L'   W='2 * Wn_min'
MnC_propagate   Cout_bar  Cin     y        Vss   nch   L='L'   W='2 * Wn_min'

MnA_generate    g         A       Vss      Vss   nch   L='L'   W='2 * Wn_min'
MnB_generate    Cout_bar  B       g        Vss   nch   L='L'   W='2 * Wn_min'


$ SUM (S_bar)

MpA_and         and_u1    A       Vdd      Vdd   pch   L='L'   W='3 * Wp_min'
MpB_and         and_u2    B       and_u1   Vdd   pch   L='L'   W='3 * Wp_min'
MpC_and         S_bar     Cin     and_u2   Vdd   pch   L='L'   W='3 * Wp_min'

MpA_or          or_up     A       Vdd      Vdd   pch   L='L'   W='2 * Wp_min'
MpB_or          or_up     B       Vdd      Vdd   pch   L='L'   W='2 * Wp_min'
MpC_or          or_up     Cin     Vdd      Vdd   pch   L='L'   W='2 * Wp_min'
Mpco_or         S_bar     Cout_bar or_up   Vdd   pch   L='L'   W='2 * Wp_min'

MnA_and         and_d1    A       Vss      Vss   nch   L='L'   W='3 * Wn_min'
MnB_and         and_d2    B       and_d1   Vss   nch   L='L'   W='3 * Wn_min'
MnC_and         S_bar     Cin     and_d2   Vss   nch   L='L'   W='3 * Wn_min'

MnA_or          or_down   A       Vss      Vss   nch   L='L'   W='2 * Wn_min'
MnB_or          or_down   B       Vss      Vss   nch   L='L'   W='2 * Wn_min'
MnC_or          or_down   Cin     Vss      Vss   nch   L='L'   W='2 * Wn_min'
Mnco_or         S_bar     Cout_bar or_down Vss   nch   L='L'   W='2 * Wn_min'


$ INVS

Xinvc            Cout_bar  Cout   Vdd   Vss   INV
Xinvs            S_bar     S      Vdd   Vss   INV

.ENDS FA_M

