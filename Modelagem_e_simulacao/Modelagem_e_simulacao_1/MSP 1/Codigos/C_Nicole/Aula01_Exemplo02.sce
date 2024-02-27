// Projeto de Reator
// Nicole Maia Argondizzi
//13/01/2023


clc
clear
mode(-1)

dados = [12.5,0.65;15,0.65;22.45,0.95]

vet_vo = dados(:,1)
vet_X = dados(:,$)
Cao = 0.45 //mol/L
k = 0.21 //1/min

vet_Fao = vet_vo*Cao
vet_ra = k * (Cao*(1-vet_X))
V = (vet_Fao .* vet_X)./vet_ra

disp('O volume do CSTR é em L:')
disp(V)

