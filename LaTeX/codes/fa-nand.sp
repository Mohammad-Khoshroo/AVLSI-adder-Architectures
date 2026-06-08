******************** FULL ADDER NAND BASED .SUBCKT ********************

.SUBCKT FA_N A B Cin S Cout Vdd Vss

Xxor1   A       B               xorAB   nandAB      Vdd Vss XNAND
Xxor2   xorAB   Cin             S       nandmid     Vdd Vss XNAND
Xcout   nandAB  nandmid         Cout                Vdd Vss NAND2

.ENDS FA_N
