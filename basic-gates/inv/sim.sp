******************** HSPICE BASIC GATES MODELING ********************
*
*   Mohammad Khoshroo - 810102441 
*   Spring 2026
*   AVLSI Course - by Dr. Vahdat
*   Thechnolegy - crn90g_2d5_lk_v1d2p1.l (90nm)
*   Standard MOSFET Model Name : nch , pch
*   INV SIMULATION
*   TEMP(℃) 10/25/40/55/70
*   CORNER TT/SS/FF/SF/FS
*
**************************** PARAMETERS *****************************

.OPTION NOMOD
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" TT
.INC "../custom_gates.inc"

.PARAM Vdd_val = 1                  $ supply-1 voltage
.PARAM Vss_val = 0                  $ supply-0 voltage
.PARAM beta = 2                     $ un/up
.PARAM L = 180n                     $ Channel length
.PARAM Wn_min = 1u                  $ Minimum Transistor width for n-types
.PARAM Wp_min = 'beta * Wn_min'     $ Minimum Transistor width for p-types


****************************** CIRCUIT ******************************

Xinv in out Vdd Vss INV     $ INVERTER GATE Under TEST/SIMULATION

************************* SIMULATION SETTING ************************

* Supplys Voltage Node
Vdd Vdd 0 DC 'Vdd_val'
Vss Vss 0 DC 'Vss_val'

* input generation ( delay , V_on , V_off , tR , tF , high-width , width )
Vin1 in 0 PULSE (0 'Vdd_val' 10p 20p 20p 200p 400p)

.TRAN 0.01p 1.2n SWEEP DATA=beta_sweep
.TEMP 10 25 40 55 70
.DATA beta_sweep
beta  
1        
2     
3
4
5
.ENDDATA


* ===================================================================
* Timing & Delay 

.MEASURE TRAN tR   TRIG V(out) VAL= '0.1 * Vdd_val' RISE= 1 TARG V(out) VAL= '0.9 * Vdd_val' RISE= 1
.MEASURE TRAN tF   TRIG V(out) VAL= '0.9 * Vdd_val' FALL= 1 TARG V(out) VAL= '0.1 * Vdd_val' FALL= 1

.MEASURE TRAN tpHL TRIG V(in)  VAL= '0.5 * Vdd_val' RISE= 1 TARG V(out) VAL= '0.5 * Vdd_val' FALL= 1
.MEASURE TRAN tpLH TRIG V(in)  VAL= '0.5 * Vdd_val' FALL= 1 TARG V(out) VAL= '0.5 * Vdd_val' RISE= 1
.MEASURE TRAN tp   PARAM= '(tpHL + tpLH)/2'

* ===================================================================
* Output Voltage Level (Vo)

.MEASURE TRAN VOH_val MAX V(out)
.MEASURE TRAN VOL_val MIN V(out)

* ===================================================================
* Power (P)

.MEASURE TRAN P_avg AVG POWER           $ Average Power
.MEASURE TRAN P_max MAX POWER           $ Maximum (Peak) Power
.MEASURE TRAN PDP PARAM = 'P_avg * tp'  $ Power-Delay Product (PDP)

* ===================================================================
* Current (I)

.MEASURE TRAN I_avg AVG  I(Vdd)
.MEASURE TRAN I_peak MIN I(Vdd)

*************************** OUTPUT SETTING **************************

.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(in) V(out)

.ALTER  Run_SF_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" TT   $ Delete previous Corner Models
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" SF       $ Add new Corner Models
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(in) V(out)

.ALTER  Run_FS_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" TT
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" FS
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(in) V(out)

.ALTER  Run_SS_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" TT
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" SS
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(in) V(out)

.ALTER  Run_FF_Corner
.DEL LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" TT
.LIB "../../utils/crn90g_2d5_lk_v1d2p1.l" FF
.OPTION POST= 2 PROBE RUNLVL=6
.PROBE V(in) V(out)


* Each output file includes data for a fixed TEMP+Corner with beta parameter sweep

.END