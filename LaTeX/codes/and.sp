**************************** AND .SUBCKT ****************************

.SUBCKT AND2 in1 in2 out Vdd Vss $ out = in1 & in2

Xinv    out_bar  out      Vdd   Vss  INV     $ INVERTER     instantiate 
Xnand   in1 in2  out_bar  Vdd   Vss  NAND2   $ 2-input NAND instantiate

.ENDS AND2
