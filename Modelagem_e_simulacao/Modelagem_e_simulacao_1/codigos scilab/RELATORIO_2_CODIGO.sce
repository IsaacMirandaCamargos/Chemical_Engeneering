clc
clear
mode(-1)

//---------------------------------------------------------------------
//                                Questão                               
//
// O sistema é composto por 1 trocador de calor e 1 tanque de destilação
// onde há aquecimento do fluido.

//---------------------------------------------------------------------


//---------------------------------------------------------------------
//                                Aluno                               
//
// Isaac Miranda Camargos RA: 2018.1048-4
//
//---------------------------------------------------------------------


//---------------------------------------------------------------------
//                                Constantes                            
Aa = 0.24; Ac = 33.3; Ah = 2; At = 4 // m²
ps = 1099.5; pc = 1000 // kg/m³
Vc = 0.027; Vt = 2; Vh = 0.005 // m³
Ch = 464.8; Cc = 3623; Cs = 4015.2 // J / kg.°C
no = 0.74; n = 1/3
Fc = 0.000272; Fs = 0.000175 // m³/s
mh = 37 // kg
g = 9.8 // m²/s
Ekh = 2461.5; kt = 1; ka = 5; kw = 2 // W/m².°C
Ts = 25; Tsa = 25; Tca = 25; Tca = 25; Tha = 25 // °C
C = 0.15
Pr = 0.707
L = 2 // m
v = 0.00001573 // m²/s
kc = 9000
TauI = 11000
Q = 26151 // J/s
//                         Condições iniciais                           
Tti = 90; Thhi = 70; Thci = 25 // °C
//---------------------------------------------------------------------





//---------------------------------------------------------------------
//                                 Funções                              
function dTt_dt = destilador(xi)
    Tt = xi(1)
    Thh = xi(2)
    Thc = xi(3)
    termo1 = (Fc*(Thh - Tt))/Vt
    termo2 = Q/(pc*Cc*Vt)
    termo3 = (At*kt*(Tha-Tt))/(pc*Cc*Vt)
    dTt_dt = termo1 + termo2 + termo3
endfunction

function dThh_dt = trocador_quente(xi)
    Tt = xi(1)
    Thh = xi(2)
    Thc = xi(3)
    denominador = (Ch*mh + pc*Cc*Vh)/2
    termo1 = pc*Cc*Fc*(Tt - Thh)
    termo2 = Ekh*Ah*(Thc - Thh)
    termo3 = (Aa*ka*(Tha - Thh))/2
    dThh_dt = (termo1 + termo2 + termo3)/denominador
endfunction

function dThc_dt = trocador_frio(xi)
    Tt = xi(1)
    Thh = xi(2)
    Thc = xi(3)
    denominador = (Ch*mh + ps*Cs*Vh)/2
    termo1 = ps*Cs*Fs*(Ts - Thc)
    termo2 = Ekh*Ah*(Thh - Thc)
    termo3 = (Aa*ka*(Tha - Thc))/2
    dThc_dt = (termo1 + termo2 + termo3)/denominador
endfunction

//---------------------------------------------------------------------




//---------------------------------------------------------------------
//                                 Soluções                             

function y = estacionario(xi)

    y(1) = destilador(xi)
    y(2) = trocador_quente(xi)
    y(3) = trocador_frio(xi)

endfunction

function y = transiente(t, xi)
    
    y(1) = destilador(xi)
    y(2) = trocador_quente(xi)
    y(3) = trocador_frio(xi)

endfunction

function printar(t, xf)
    scf(0)
    clf
    Tt_t = xf(1,:)
    Thh_t = xf(2,:)
    Thc_t = xf(3,:)
    
    subplot(3,1,1)
    plot(t, Tt_t, "r")
    xtitle("Temperatura do fluido na coluna de destilação", "Tempo (s)", "Temperatura (°C)")
    subplot(3,1,2)
    plot(t, Thh_t, "c")
    xtitle("Temperatura do fluido quente no trocador", "Tempo (s)", "Temperatura (°C)")
    subplot(3,1,3)
    plot(t, Thc_t, "g")
    xtitle("Temperatura do fluido frio no trocador", "Tempo (s)", "Temperatura (°C)")

endfunction

function y = t_estacionario(t, xf, erro)

    Tt_t = xf(1,:)
    Thh_t = xf(2,:)
    Thc_t = xf(3,:)
    
    for i = 1:1:length(t)-1
        condicao_1 = abs(Tt_t(i) - Tt_t(i+1)) < erro
        condicao_2 = abs(Thh_t(i) - Thh_t(i+1)) < erro
        condicao_3 = abs(Thc_t(i) - Thc_t(i+1)) < erro
        if condicao_1 & condicao_2 & condicao_3 then
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

xi = [Tti; Thhi; Thci]
[xf, yf, info] = fsolve(xi, estacionario)

if info < 10 then
    mprintf("                           Resposta 1\n\n")
    mprintf("As temperaturas em estado estacionario são:\n")
    mprintf("Destilador: %f\nFluido quente trocador: %f\nFluido frio trocador: %f\n", ...
    xf(1), xf(2), xf(3))
end

//                         Resposta número 2                           


xi = [Tti; Thhi; Thci]
t = [0: 0.1: 200]
erro = 10**(-5)
xf = ode(xi, t(1), t, transiente)
printar(t, xf)

tempo = t_estacionario(t, xf, erro)
mprintf("                           Resposta 2\n\n")
mprintf("O tempo que leva até o estado estacionario é %f s", tempo)

//---------------------------------------------------------------------














