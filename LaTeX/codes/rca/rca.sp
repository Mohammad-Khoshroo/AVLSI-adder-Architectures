************************* RCA-2bit .SUBCKT *************************

.SUBCKT RCA2 A1 A0 B1 B0 Cin S1 S0 Cout Vdd Vss 

XFA_L    A0  B0  Cin     S0  Cmid    Vdd Vss FA_T
XFA_H    A1  B1  Cmid    S1  Cout    Vdd Vss FA_T

.ENDS RCA2

************************ RCA-4bit .SUBCKT ************************

.SUBCKT RCA4 A3 A2 A1 A0 B3 B2 B1 B0 Cin S3 S2 S1 S0 Cout Vdd Vss

XRCA_L  A1 A0  B1 B0  Cin   S1 S0  Cmid  Vdd Vss RCA2
XRCA_H  A3 A2  B3 B2  Cmid  S3 S2  Cout  Vdd Vss RCA2

.ENDS RCA4

************************ RCA-8bit .SUBCKT ************************

.SUBCKT RCA8 A7 A6 A5 A4 A3 A2 A1 A0 
+            B7 B6 B5 B4 B3 B2 B1 B0 Cin 
+            S7 S6 S5 S4 S3 S2 S1 S0 Cout Vdd Vss

XRCA_L  A3 A2 A1 A0  B3 B2 B1 B0  Cin   S3 S2 S1 S0  Cmid  Vdd Vss RCA4
XRCA_H  A7 A6 A5 A4  B7 B6 B5 B4  Cmid  S7 S6 S5 S4  Cout  Vdd Vss RCA4

.ENDS RCA8
