clc
clear
mode(-1)

// PROBLEMA

// Dois tanques em seríe estão em estado estacionario,
// determine a altura dos dois tanques


// DADOS
Fo = 3 // m³/h
A1 = 2 // m²
A2 = 1 // m²
B1 = 3 // m²/h
B2 = 2 // m²/h

// EQUAÇÕES

function y = funcao(xi)
    global Fo, A1, A2, B1, B2
    h1 = xi(1)
    h2 = xi(2)
    y(1) = (Fo/A1) - (B1*h1)/A1
    y(2) = (B1*h1)/A2 - (B2*h2)/A2
endfunction

// ENCONTRANDO A SOLUÇÃO DO SISTEMA DE EQUAÇÕES ACIMA (h1, h2) desconhecidos


xi = [2; 3] 
[xf, yf, info] = fsolve(xi, funcao)

if info == 1 then
    disp("Solucao")
    disp(xf)
    disp(yf)
end

