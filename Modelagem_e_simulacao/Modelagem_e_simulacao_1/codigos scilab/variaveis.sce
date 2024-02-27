clc
clear
mode(-1)

// VARIAVEIS 

Cao = 0.45 // mol/L
Q = 10 // L/min
Fao = Q*Cao // mol/min
K = 0.21 // 1/min
X = 0.8

// VOLUME

_Ra = K*(Cao*(1-X))
V = Fao*X/_Ra

disp(V ,"O valor do volume em (L) é: ") // Imprime os valores na ordem oposta

mprintf("O valor do volume em (L) é: %0.3f", V) // Imprime o valor de forma editada,
                                                // podemos limitar o numero de casas
                                                // decimais.


