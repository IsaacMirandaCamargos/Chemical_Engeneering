clc
clear
mode(-1)

//---------------------------------------------------------------------
//                                Questão                               
//
// O sistema é composto por quatro tanques, os quais estão ligados entre
// si por tubulações e dispostos em dois ramos de dois tanques, como
// mostrado a seguir. Pede-se:
//
// 1. Encontre o valor do estado estacionário. Utilize a função fsolve.
//
// 2. Obtenha o comportamento dos níveis com o tempo, usando a função 
// ode. Discuta os resultados.
//---------------------------------------------------------------------





//---------------------------------------------------------------------
//                                Constantes                            
A1 = 28;    A2 = 32;    A3 = 28;    A4 = 32 // cm²
a1 = 0.071; a2 = 0.057; a3 = 0.071; a4 = 0.057 // cm²
kc = 0.5 // V/cm
g = 981 // cm/s²

//                         Constantes variaveis                         
v1 = 3.15;   v2 = 3.15; // V  (V = cm/s)
k1 = 3.14;   k2 = 3.29 // cm³/V.s
y1 = 0.43;   y2 = 0.34

//                         Condições iniciais                           
h1_i = 12.6; h2_i = 13.0; h3_i = 4.8; h4_i = 4.9; // cm 
//---------------------------------------------------------------------





//---------------------------------------------------------------------
//                                 Funções                              
function y = estacionario(hi)
    // global A1, A2, A3, A4, a1, a2, a3, a4, kc, g, v1, v2, k1, k2, y1, y2
    
    h1 = hi(1)
    h2 = hi(2)
    h3 = hi(3)
    h4 = hi(4)

    y(1) = (-a1*sqrt(2*g*h1)/A1) + (a3*sqrt(2*g*h3)/A1) + (y1*k1*v1/A1)
    y(2) = (-a2*sqrt(2*g*h2)/A2) + (a4*sqrt(2*g*h4)/A2) + (y2*k2*v2/A2)
    y(3) = (-a3*sqrt(2*g*h3)/A3) + ((1-y2)*k2*v2/A3)
    y(4) = (-a4*sqrt(2*g*h4)/A4) + ((1-y1)*k1*v1/A4)

endfunction

function y = transiente(t, hi)
    // global A1, A2, A3, A4, a1, a2, a3, a4, kc, g, v1, v2, k1, k2, y1, y2
    
    h1 = hi(1)
    h2 = hi(2)
    h3 = hi(3)
    h4 = hi(4)

    y(1) = (-a1*sqrt(2*g*h1)/A1) + (a3*sqrt(2*g*h3)/A1) + (y1*k1*v1/A1)
    y(2) = (-a2*sqrt(2*g*h2)/A2) + (a4*sqrt(2*g*h4)/A2) + (y2*k2*v2/A2)
    y(3) = (-a3*sqrt(2*g*h3)/A3) + ((1-y2)*k2*v2/A3)
    y(4) = (-a4*sqrt(2*g*h4)/A4) + ((1-y1)*k1*v1/A4)

endfunction

function printar(t, hf)
    scf(0)
    clf
    h1_t = hf(1,:)
    h2_t = hf(2,:)
    h3_t = hf(3,:)
    h4_t = hf(4,:)
    
    subplot(2,2,1)
    plot(t, h1_t, "r")
    xtitle("Altura do tanque 1", "Tempo (s)", "Altura (cm)")
    subplot(2,2,2)
    plot(t, h2_t, "c")
    xtitle("Altura do tanque 2", "Tempo (s)", "Altura (cm)")
    subplot(2,2,3)
    plot(t, h3_t, "g")
    xtitle("Altura do tanque 3", "Tempo (s)", "Altura (cm)")
    subplot(2,2,4)
    plot(t, h4_t, "m")
    xtitle("Altura do tanque 4", "Tempo (s)", "Altura (cm)")

endfunction

function y = t_estacionario(t, hf, erro)

    h1_t = hf(1,:)
    h2_t = hf(2,:)
    h3_t = hf(3,:)
    h4_t = hf(4,:)
    
    for i = 1:1:length(t)-1
        condicao_1 = abs(h1_t(i) - h1_t(i+1)) < erro
        condicao_2 = abs(h2_t(i) - h2_t(i+1)) < erro
        condicao_3 = abs(h3_t(i) - h3_t(i+1)) < erro
        condicao_4 = abs(h4_t(i) - h4_t(i+1)) < erro
        if condicao_1 & condicao_2 & condicao_3 & condicao_4
            y = t(i)
            break 
        end
    end

endfunction

//---------------------------------------------------------------------





//---------------------------------------------------------------------
//                         PROGRAMA PRINCIPAL                           
//---------------------------------------------------------------------





//---------------------------------------------------------------------
//                         Resposta número 1                           

xi = [h1_i; h2_i; h3_i; h4_i]
[hf, yf, info] = fsolve(xi, estacionario)

if info == 1 then
    mprintf("                           Resposta 1\n\n")
    mprintf("As alturas dos tanques em estado estacionario são respectivamente:\n")
    mprintf("Tanque 1: %f\nTanque 2: %f\nTanque 3: %f\nTanque 4: %f\n", ...
    hf(1), hf(2), hf(3), hf(4))
end

//                         Resposta número 2                           


xi = [h1_i; h2_i; h3_i; h4_i]
t = [0: 1: 1000]
erro = 10**(-5)

hf = ode(xi, t(1), t, transiente)
printar(t, hf)
tempo = t_estacionario(t, hf, erro)
mprintf("                           Resposta 2\n\n")
mprintf("O tempo que leva até o estado estacionario é %f s", tempo)

//---------------------------------------------------------------------














