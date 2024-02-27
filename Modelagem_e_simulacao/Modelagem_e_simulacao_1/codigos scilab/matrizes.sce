clc
clear
mode(-1)

// VARIAVEIS 

dados = [12.5, 0.65; 15.0, 0.65; 22.45, 0.95]
Q = dados(: , 1) // VETOR
X = dados(:, 2) // VETOR
Cao = 0.45 // mol/L
Fao = Q*Cao // VETOR
K = 0.21 // 1/min

// VOLUME

_Ra = K*(Cao*(1-X))
V = Fao.*X./_Ra


disp(V, "O volume em litros dos reatores em cada uma das condições é: ")



