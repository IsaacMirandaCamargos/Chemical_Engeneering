// Ajuste de pontos experimentais
//Nicole
//27/03/23

clc
clear
mode(-1)


function P = pressao_vapor(T,A,B)
    P = 10^(A+B./T)
endfunction

function e=erro(x)
    A=x(1)
    B=x(2)
    //e=Pcalc-Pexp
    e = pressao_vapor(Texp,A,B)-Pexp
endfunction

// Programa Principal

Pexp = [1;5;10;20;40;60;100;200;400;760]
Texp = [-36.7;-19.6;-11.5;-2.6;7.6;15.4;26.1;42.2;60.6;80.1]
Texp = Texp+273.15

Xchute = [10;-2000]
[fopt,xopt] = leastsq(erro,Xchute)

A = xopt(1)
B = xopt(2)

//Calculando P utilizando a equação de Clayperon

T = [-30:0.1:90]
T = T+273.15
Pcalc = 10^(A+B./T)

//Saída de dados

mprintf('O valor do parâmetro A: A=%.2f \n',A)
mprintf('O valor do parâmetro B: B=%.2f',B)

scf(0)
clf()
plot(Texp,Pexp,'ro')
plot(T,Pcalc,'b')
xtitle('', 'T[K]','P[mmHg]')
legend(['Pexp','Pcalc'])

//Equação de Clayperon
//P = 10^(7.75-1719.81/T)

