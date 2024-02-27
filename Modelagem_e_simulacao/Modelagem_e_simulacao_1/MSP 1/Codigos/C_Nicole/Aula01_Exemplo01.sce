// Aula 01
// Nicole Maia Argondizzi
//13/01/2023

clc
clear
mode(-1)

//Constantes
vo = 10 // L/min
Cao = 0.45 //mol/L
k = 0.21 //1/min
X = 0.8 

//Fluxo inicial
Fao = vo*Cao

//Taxa -Ra
_ra = k*(Cao*(1-X))

//Volume
V = (Fao * X)/_ra

disp('O valor do volume é em L:')
disp(V)











