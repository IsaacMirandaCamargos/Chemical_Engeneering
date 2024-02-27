clc
clear
mode(-1)

//------------------------------------------------------------------------------
//                                DESCRIÇÃO
//------------------------------------------------------------------------------
//Iremos aplicar o métodos das linhas para determinação da temperatura em uma haste,
// em função do tempo e posição
//Autor:ISAAC
//Data: 26/09/2022
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//                             FUNÇÕES                                          
function y = din(t, Ca)
    Ca1 = Cao
    y(1) = Dab*(Ca(2) - 2*Ca(1) + Cao)/dy**2
    for i = 2:1:N-1
        y(i) = Dab*(Ca(i+1) - 2*Ca(i) + Ca(i-1))/dy**2
    end
    Can = Ca(N-1)
    y(N) = Dab*(Can - 2*Ca(N-1) + Ca(N-2))/dy**2
endfunction
//------------------------------------------------------------------------------ 

//------------------------------------------------------------------------------
//                                    CONSTANTES                                 
N = 50
Cao = 0.01 // mol/m³
yi = 0 // m
yf = 0.1 // m
Dab = 2*10**-6 // m²/s
dy = (yf - yi)/N

//------------------------------------------------------------------------------ 

//------------------------------------------------------------------------------
//                                    APLICANDO                                 
Cainicial = [Cao;ones(N-1,1)*0]
t = [0: 0.1:600]
Ca_t = ode(Cainicial, t(1), t, din)
//disp(Ca_t)
//------------------------------------------------------------------------------ 

//------------------------------------------------------------------------------
//                                    PLOTANDO                                 
yy = yi:dy:yf
//scf(0)
//clf(0)
//plot(t, Ca_t(1,:), "r")
//plot(t, Ca_t(N/2,:),"b")
//plot(t, Ca_t(N, :), "m")
//xtitle("Concentração de A no fluido", "$Tempo[s]$", "$ConcentraçãoA[mol/m³]$")
//legend(["Superficie (y=0)", "Meio (y=0.05 m)", "Fundo (y=0.1 m)"])
//for i = 1:1:N
//    plot(t, Ca_t(i,:), "r")
//end
//xtitle("Concentração de A no fluido em função da posição", "$Tempo[s]$", "$ConcentraçãoA[mol/m³]$")


Ca_t = [Ca_t;Ca_t(N, :)]
scf(1)
clf(1)
plot(yy', Ca_t(:,600), "r")
plot(yy', Ca_t(:,3000), "b")
plot(yy', Ca_t(:,6000), "m")
xtitle("Concentração de A no fluido em função da tempo", "$Posição[m]$", "$ConcentraçãoA[mol/m³]$")
legend(["t=1 min", "t=5 min", "t= 10 min"])

//for i = 1:1:length(t)
//    plot(yy', Ca_t(:,i), "m")
//end
//xtitle("Concentração de A no fluido em função da tempo", "$Posição[m]$", "$ConcentraçãoA[mol/m³]$")
//------------------------------------------------------------------------------ 









