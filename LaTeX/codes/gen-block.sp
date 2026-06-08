************************** BUFFER .SUBCKT *************************

.SUBCKT BUF in out Vdd Vss scale=1 $ out = in

Xinv1  in   mid  Vdd Vss  INV  scale=scale   
Xinv2  mid  out  Vdd Vss  INV  scale=scale 

.ENDS BUF

****************************** GEN .SUBCKT *****************************

.SUBCKT GEN_BLOCK G_ik P_ik G_kj G_ij Vdd Vss scale=1 $ Gray Block (generates G_ij)

$ P_ik & G_kj
Xand  P_ik  G_kj  mid   Vdd  Vss  AND2  scale=scale

$ G_ij = G_ik | (P_ik & G_kj)
Xor   G_ik  mid      G_ij  Vdd  Vss  OR2   scale=scale

.ENDS GEN_BLOCK

**************************** GENPRO .SUBCKT ****************************

.SUBCKT GENPRO_BLOCK G_ik P_ik G_kj P_kj G_ij P_ij Vdd Vss scale=1 $ Black Block (generates both G_ij and P_ij)

$ G_ij = G_ik | (P_ik & G_kj)
Xgen G_ik P_ik G_kj G_ij Vdd Vss GEN_BLOCK scale=scale 

$ P_ij = P_ik & P_kj
Xand  P_ik  P_kj  P_ij  Vdd  Vss  AND2  scale=scale

.ENDS GENPRO_BLOCK