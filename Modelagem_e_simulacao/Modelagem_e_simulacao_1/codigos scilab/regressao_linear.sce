clc
clear
mode(-1)

// FUNCAO A AJUSTAR
function P = clayperon(T, A, B)
    P = 10^(A + B./T)
endfunction

// FUNÇÃO PARA MINIMIZAR O ERRO
function e = erro(x)
    global Texp, Pexp
    A = x(1)
    B = x(2)
    e = clayperon(Texp, A, B) - Pexp
endfunction


// DADOS
dados = [
        -36.7,1;
        -19.6,5;
        -11.5,10;
        -2.6,20;
        7.6,40;
        15.4,60;
        26.1,100;
        42.2,200;
        60.6,400;
        80.1,760]

Texp = dados(:,1) + 275.15
Pexp = dados(:,2)

// AJUSTE DA FUNÇÃO
x0 = [10;-2000]
[fopt, xopt] = leastsq(erro, x0)
disp(xopt)

// PLOTANDO O RESULTADO DO AJUSTE
A = xopt(1)
B = xopt(2)
Tteo = -36.7:0.1:80.1
Tteo = Tteo + 275.15
Pteo = clayperon(Tteo, A, B)

scf(0)
clf()
plot(Texp, Pexp, "ro")
plot(Tteo, Pteo, "b")
xtitle("Ajuste de curva", "T[K]", "P[mmHg]")
legend(["Experimental", "Teorico"],4)
xgrid(0)



















