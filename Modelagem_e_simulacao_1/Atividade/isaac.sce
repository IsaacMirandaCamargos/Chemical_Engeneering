clear
clc
mode(-1)


// ANALISANDO OS DADOS

P1 = 0 // psi
P3 = 0 // psi
D = 1.049 // ft
L = 50 // ft
p = 51.4 // lb/ft^3
fm = 0.032
A = 16.7 // psi
B = 0.052 // psi/(ft^3min^-1}^1.5)
const = 2.16*10^(-4)
erro = 10^(-5)

// DEFININDO AS FUNÇÕES

function P2 = f1(A, B, Q, P1)
    P2 = P1 + A - B*Q^(1.5)
endfunction

function P2 = f2(const, fm, p, L, Q, D, P3)
    P2 = P3 + const*fm*p*L*Q^(2)/(D^5)
endfunction

function y = f_newton_raphson(Q)
    global A, B, P1, const, fm, p, L, D, P3
    y = abs(P1 + A - B*Q^(1.5) - (P3 + const*fm*p*L*Q^(2)/(D^5)))
endfunction

// DEFININDO CHUTE INICIAL
Qi = 10 // ft^3/min
m = (f_newton_raphson(Qi+erro)-f_newton_raphson(Qi))/erro
Qf = Qi - f_newton_raphson(Qi)/m
contador = 1

while abs(Qi-Qf) > erro do
    contador = contador + 1
    Qi = Qf
    m = (f_newton_raphson(Qi+erro)-f_newton_raphson(Qi))/erro
    Qf = Qi - f_newton_raphson(Qi)/m
end


P2_real = f1(A, B, Qf, P1)
P2_real2 = f2(const, fm, p, L, Qf, D, P3)
mprintf("A vazão que satisfaz as equações é %.3f ft³/min\n", Qf)
mprintf("A pressão que satisfaz as equações é %.3f psi\n", P2_real)
mprintf("O número de iterações foi %i", contador)


