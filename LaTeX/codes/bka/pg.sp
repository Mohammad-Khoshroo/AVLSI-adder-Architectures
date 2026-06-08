********************* 8-bit BITWISE PG .SUBCKT *********************

.SUBCKT PG8 A1 A2 A3 A4 A5 A6 A7 A8 B1 B2 B3 B4 B5 B6 B7 B8 Cin 
+ G1 G2 G3 G4 G5 G6 G7 G8 P1 P2 P3 P4 P5 P6 P7 P8 G0 P0 Vdd Vss scale=1

Xbit1  A1 B1 G1 P1 Vdd Vss PG scale=scale
Xbit2  A2 B2 G2 P2 Vdd Vss PG scale=scale
Xbit3  A3 B3 G3 P3 Vdd Vss PG scale=scale
Xbit4  A4 B4 G4 P4 Vdd Vss PG scale=scale
Xbit5  A5 B5 G5 P5 Vdd Vss PG scale=scale
Xbit6  A6 B6 G6 P6 Vdd Vss PG scale=scale
Xbit7  A7 B7 G7 P7 Vdd Vss PG scale=scale
Xbit8  A8 B8 G8 P8 Vdd Vss PG scale=scale

V_G0   G0 Cin 0
V_P0   P0 Vss 0

.ENDS PG8