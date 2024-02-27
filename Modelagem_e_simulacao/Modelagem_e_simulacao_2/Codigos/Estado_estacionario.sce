clc
clear
mode(-1)



// DADOS
Fe = 1 // ft³/min
Fje = 1.5 // ft³/min
Te = 50 // F
Tje = 200 // F
pCp = 61.3 // BTU/F.ft³
pjCpj = 61.3 // BTU/F.ft³
V = 10 // ft³
Vj = 1 // ft³
UA = 183.9 // BTU/F.min
K1 = 5/6 // 1/min
K2 = 5/3 // 1/min
K3 = 1/6 // L/mol.min
Cae = 10 // mol/L


// EQUAÇÕES

function y = funcao(xi)
    global Fe, Fje, Te, Tje, pCp, pjCpj, V, Vj, UA, K1, K2, K3, Cae
    Ca = xi(1)
    Cb = xi(2)
    Cc = xi(3)
    Cd = xi(4)
    T = xi(5)
    Tj = xi(6)
    y(1) = Fe*(Cae - Ca)/(V) - K1*Ca - K3*Ca**2
    y(2) = -Fe*Cb/(V) + K1*Ca - K2*Cb
    y(3) = -Fe*Cc/(V) + K2*Cb
    y(4) = -Fe*Cd/(V) + K3*Ca**2
    y(5) = Fe*(Te - T)/(V) - UA*(T - Tj)/(pCp*V)
    y(6) = Fje*(Tje - Tj)/(Vj) + UA*(T - Tj)/(pjCpj*Vj)
    
endfunction

// ENCONTRANDO A SOLUÇÃO DO SISTEMA DE EQUAÇÕES ACIMA (h1, h2) desconhecidos


xi = [1; 1; 1; 1; 50; 200] 
[xf, yf, info] = fsolve(xi, funcao)

if info == 1 then
    disp("Estado estacionário")
    mprintf("   Ca = %f mol/L\n   Cb = %f mol/L\n   Cc = %f mol/L\n   Cd = %f mol/L\n   T = %f °F\n   Tj = %f °F\n", xf(1), xf(2), xf(3), xf(4), xf(5), xf(6))
    //disp(xf)
    //disp(yf)
end









