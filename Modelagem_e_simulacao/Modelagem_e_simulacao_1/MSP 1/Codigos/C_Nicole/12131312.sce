// Dados iniciais
Cp = 1;
Lambda0 = 1000;
Lambda1 = 1000;
Lambda2 = 1000;
U1 = 500;
U2 = 300;
F = 50000;
L1 = 10000;
Tf = 100;
T0 = 250;
T2 = 125;
A = 592;
V0 = 3703;

// Funções de energia
function f1 = eq1(T2, T1, V0, T0, A)
    f1 = L1 * Cp * (T2 - T1) + V0 * lambda0 - L1 - L2 * lambda1;
endfunction

function f2 = eq2(T2, T1, V0, T0, A)
    f2 = U1 * A * (T0 - T1) - V0 * lambda0;
endfunction

function f3 = eq3(T2, T1, V0, T0, A)
    f3 = F * Cp * (Tf - T2) + L2 - L1 * lambda1 - F - L2 * lambda2;
endfunction

function f4 = eq4(T2, T1, V0, T0, A)
    f4 = U2 * A * (T1 - T2) - L1 - L2 * lambda1;
endfunction

// Resolução do sistema de equações
err = 1e-5;
while (abs(f1) > err || abs(f2) > err || abs(f3) > err || abs(f4) > err)
    T1 = (L1 * Cp * T2 + V0 * lambda0 - L2 * lambda1) / (L1 * Cp + U1 * A);
    L2 = (F * Cp * (Tf - T2) + L1 * lambda1 + F + U2 * A * (T1 - T2)) / (Cp * Tf + U2 * A);
    T2 = (L2 * lambda2 + U2 * A * T1 + L1 * lambda1 - F) / (F * Cp + L2);
    V0 = (U1 * A * (T0 - T1) + L2 * lambda2) / lambda0;
    f1 = eq1(T2, T1, V0, T0, A);
    f2 = eq2(T2, T1, V0, T0, A);
    f3 = eq3(T2, T1, V0, T0, A);
    f4 = eq4(T2, T1, V0, T0, A);
end

disp("Temperatura T2: " + T2 + " oF");
disp("Vazão mássica de vapor V0: " + V0 + " lb/h");
disp("Vazão mássica de líquido L2: " + L2 + " lb/h");
disp("Número de iterações necessárias: " + ceil(log(err) / log(abs(f1))) + ce
