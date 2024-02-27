clc
clear
mode(-1)

// Declarando variáveis
d = 0.4
umax = 0.53
km = 0.12
sf = 4
y = 0.4




// FUNÇÕES
function f = ee(x)
    x1 = x(1)
    x2 = x(2)
    
    u = umax*x2/(km+x2)
    
    f(1) = (u-d)*x1
    f(2) = (sf-x2)*d - u*x1/y
endfunction

// PRIMEIRA ITERAÇÃO
xi = [2; 1] 
[xf, yf, info] = fsolve(xi, ee)
matriz = [0.08954970425491326, 0.009498345855807437; 1.2238742606372832, -0.42374586463951863]
[autovetores, autovalores] = spec(matriz)
disp(autovalores)
disp(autovetores)
// Resultados
disp(xf)
