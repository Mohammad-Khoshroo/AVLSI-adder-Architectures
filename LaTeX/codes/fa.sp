****************** FULL ADDER Gate-Level .SUBCKT ********************

.SUBCKT FA A B Cin S Cout Vdd Vss 

Xxor1   A       B       xorAB   Vdd Vss XOR2_SYM
Xxor2   Cin     xorAB   S       Vdd Vss XOR2_SYM
Xnand1  Cin     xorAB   nandCin Vdd Vss NAND2
Xnand2  A       B       nandAB  Vdd Vss NAND2
Xnand3  nandAB  nandCin Cout    Vdd Vss NAND2

.ENDS FA