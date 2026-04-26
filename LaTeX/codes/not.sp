************************** INVERTER .SUBCKT *************************

.SUBCKT INV in out Vdd Vss $ out = ~in

Mn      out     in   Vss  Vss  nch   L= 'L'    W= 'Wn_min' $ NMOS transistor
Mp      out     in   Vdd  Vdd  pch   L= 'L'    W= 'Wp_min' $ PMOS transistor

.ENDS INV