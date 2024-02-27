clc
clear
mode(-1)

// Declarando variáveis
Cp = 1 //Btu/lb°F
Lambda0 = 1000 //Btu/lb
Lambda1 = 1000
Lambda2 = 1000
U1 = 500 // Btu/ h ft^2 °F
U2 = 300
F = 50000 // lb/h
L1 = 10000 //lb/h
Tf = 100 // °F
T0 = 250
T2 = 125

//Chute inicial
A = 592 * 10.764 // ft^2
V0 = 3703 // lb/h

// Questão a - Calcular T2

// FUNÇÕES
function f1 = function_1(V0)
    f1 = L2 * Cp * (T2 - T1) + V0 * Lambda0 - (L2 - L1) * Lambda1
endfunction

function f4 = function_4(A)
    f4 = U2 * A * (T1 - T2) - (L2 - L1) * Lambda1
endfunction



// PRIMEIRA ITERAÇÃO
delta_x = 1e-5
T1 = (V0*Lambda0/(U1*A))
L2 = (L1*Lambda1 + F * Lambda2 - F * Cp *(Tf - T2))/ (Lambda1 + Lambda2)
m = function_4(A+delta_x)/delta_x; Af = A - function_4(A)/m
m = function_1(V0+delta_x)/delta_x; V0f = V0 - function_1(V0)/m
error = max(abs(V0f - V0), abs(Af-A))

// Resultados
mprintf("T1 = %f\n", T1)
mprintf("V0 = %f\n", V0)
mprintf("L2 = %f\n", L2)
mprintf("A = %f\n", A)

while (error > 1e-5) do
    
    A = Af; V0 = V0f
    
    T1 = (V0*Lambda0/(U1*A))
    L2 = (L1*Lambda1 + F * Lambda2 - F * Cp *(Tf - T2))/ (Lambda1 + Lambda2)
    m = function_4(A+delta_x)/delta_x; Af = A - function_4(A)/m
    m = function_1(V0+delta_x)/delta_x; V0f = V0 - function_1(V0)/m
    error = max(abs(V0f - V0), abs(Af-A))
    
end

A = Af; V0 = V0f

// Resultados
mprintf("T1 = %f\n", T1)
mprintf("V0 = %f\n", V0)
mprintf("L2 = %f\n", L2)
mprintf("A = %f\n", A)
