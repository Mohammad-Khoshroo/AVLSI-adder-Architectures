.TRAN 0.01p 500.0p SWEEP DATA=FA_TRANSISSION
.TEMP 25

VA A 0 PWL(0p 'a_init*Vdd_val' 75.0p 'a_init*Vdd_val' 125.0p 'a_final*Vdd_val' 500.0p 'a_final*Vdd_val')
VB B 0 PWL(0p 'b_init*Vdd_val' 75.0p 'b_init*Vdd_val' 125.0p 'b_final*Vdd_val' 500.0p 'b_final*Vdd_val')
VCin Cin 0 PWL(0p 'cin_init*Vdd_val' 75.0p 'cin_init*Vdd_val' 125.0p 'cin_final*Vdd_val' 500.0p 'cin_final*Vdd_val')

.DATA FA_TRANSISSION
+ a_init a_final b_init b_final cin_init cin_final is_fall_transition
+ 0        1        0        0        0        0        0        $ SWITCH=A
+ 1        0        0        0        0        0        1        $ SWITCH=A
+ 0        1        1        1        0        0        0        $ SWITCH=A
+ 1        0        1        1        0        0        1        $ SWITCH=A
+ 0        1        0        0        1        1        0        $ SWITCH=A
+ 1        0        0        0        1        1        1        $ SWITCH=A
+ 0        1        1        1        1        1        0        $ SWITCH=A
+ 1        0        1        1        1        1        1        $ SWITCH=A
+ 0        0        0        1        0        0        0        $ SWITCH=B
+ 0        0        1        0        0        0        1        $ SWITCH=B
+ 1        1        0        1        0        0        0        $ SWITCH=B
+ 1        1        1        0        0        0        1        $ SWITCH=B
+ 0        0        0        1        1        1        0        $ SWITCH=B
+ 0        0        1        0        1        1        1        $ SWITCH=B
+ 1        1        0        1        1        1        0        $ SWITCH=B
+ 1        1        1        0        1        1        1        $ SWITCH=B
+ 0        0        0        0        0        1        0        $ SWITCH=Cin
+ 0        0        0        0        1        0        1        $ SWITCH=Cin
+ 1        1        0        0        0        1        0        $ SWITCH=Cin
+ 1        1        0        0        1        0        1        $ SWITCH=Cin
+ 0        0        1        1        0        1        0        $ SWITCH=Cin
+ 0        0        1        1        1        0        1        $ SWITCH=Cin
+ 1        1        1        1        0        1        0        $ SWITCH=Cin
+ 1        1        1        1        1        0        1        $ SWITCH=Cin
.ENDDATA

.MEASURE TRAN tpLH_S_A TRIG V(A) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_S_A TRIG V(A) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' FALL=1
.MEASURE TRAN tpLH_Cout_A TRIG V(A) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_Cout_A TRIG V(A) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' FALL=1
.MEASURE TRAN tpLH_S_B TRIG V(B) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_S_B TRIG V(B) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' FALL=1
.MEASURE TRAN tpLH_Cout_B TRIG V(B) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_Cout_B TRIG V(B) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' FALL=1
.MEASURE TRAN tpLH_S_Cin TRIG V(Cin) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_S_Cin TRIG V(Cin) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(S) VAL='0.5*Vdd_val' FALL=1
.MEASURE TRAN tpLH_Cout_Cin TRIG V(Cin) VAL='0.5*Vdd_val' RISE=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' RISE=1
.MEASURE TRAN tpHL_Cout_Cin TRIG V(Cin) VAL='0.5*Vdd_val' FALL=1 TD=65.0p TARG V(Cout) VAL='0.5*Vdd_val' FALL=1

