******************** HSPICE FULL ADDER MODELING *********************
*
*   Mohammad Khoshroo - 810102441 
*   Spring 2026
*   AVLSI Course - by Dr. Vahdat
*   Standard MOSFET Model Name : nch , pch
*
*
.INC "../basic-gates/custom_gates.inc"
*
****************** FULL ADDER Gate-Level .SUBCKT ********************

.SUBCKT FA A B Cin S Cout Vdd Vss 

Xxor1   A       B       xorAB   Vdd Vss XOR2_SYM
Xxor2   Cin     xorAB   S       Vdd Vss XOR2_SYM
Xnand1  Cin     xorAB   nandCin Vdd Vss NAND2
Xnand2  A       B       nandAB  Vdd Vss NAND2
Xnand3  nandAB  nandCin Cout    Vdd Vss NAND2

.ENDS FA

********************** NAND-Based XOR .SUBCKT ***********************

.SUBCKT XNAND in1 in2 out_xor out_nand Vdd Vss

$ out_nand (out1) = ~(in1 & in2)
$ out_xor  (out4) =   in1 ^ in2

Xnand1  in1     in2      out_nand  Vdd Vss NAND2
Xnand2  in1     out_nand out2      Vdd Vss NAND2
Xnand3  in2     out_nand out3      Vdd Vss NAND2
Xnand4  out2    out3     out_xor   Vdd Vss NAND2

.ENDS XNAND

******************** FULL ADDER NAND BASED .SUBCKT ********************

.SUBCKT FA_N A B Cin S Cout Vdd Vss

Xxor1   A       B               xorAB   nandAB      Vdd Vss XNAND
Xxor2   xorAB   Cin             S       nandmid     Vdd Vss XNAND
Xcout   nandAB  nandmid         Cout                Vdd Vss NAND2

.ENDS FA_N