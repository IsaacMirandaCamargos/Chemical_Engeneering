//Projeto de CSTR
//Nádia
//01/08/2022
clc
clear
mode(-1)

//Entrada de dados
C=[12.5,0.65;15,0.65;22.45,0.95]
v0=C(:,1)//L/min
X=C(:,$)
Ca0=0.45//mol/L
K=0.21//L/mol.min
Fa0=v0*Ca0
ra=K*(Ca0*(1-X))
V=(Fa0.*X)./ra

disp('O volume do CSTR (L) é:')
disp(V)

V1 = V(1)
V2 = V(2)
V3 = V(3)

// Para R1 

if V1 <= 120 then
    disp('Reator Subdimensionado.')
elseif V1>120 & V1<=150
    disp('Reator dentro das especificações.')
else 
    disp('Reator Superdimensionado')
end

// Para R2

if V2 <= 120 then
    disp('Reator Subdimensionado.')
elseif V2>120 & V2<=150
    disp('Reator dentro das especificações.')
else 
    disp('Reator Superdimensionado')
end


   
// Para R3

if V3 <= 120 then
    disp('Reator Subdimensionado.')
elseif V3>120 & V3<=150
    disp('Reator dentro das especificações.')
else 
    disp('Reator Superdimensionado')
end























