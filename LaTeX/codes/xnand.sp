********************** NAND-Based XOR .SUBCKT ***********************

.SUBCKT XOR2N in1 in2 out_xor out_nand Vdd Vss

$ out_nand (out1) = ~(in1 & in2)
$ out_xor  (out4) =   in1 ^ in2

Xnand1  in1     in2      out_nand  Vdd Vss NAND2
Xnand2  in1     out_nand out2      Vdd Vss NAND2
Xnand3  in2     out_nand out3      Vdd Vss NAND2
Xnand4  out2    out3     out_xor   Vdd Vss NAND2

.ENDS XOR2N
