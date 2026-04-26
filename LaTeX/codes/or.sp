***************************** OR .SUBCKT ****************************

.SUBCKT OR2 in1 in2 out Vdd Vss $ out = in1 | in2

Xinv    out_bar  out      Vdd  Vss  INV     $ INVERTER     instantiate 
Xnor    in1 in2  out_bar  Vdd  Vss  NOR2    $ 2-input NOR  instantiate

.ENDS OR2