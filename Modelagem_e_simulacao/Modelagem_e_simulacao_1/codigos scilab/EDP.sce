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
function y = din(t, T)
    T1 = T(2) + q*dx/k
    y(1) = alfa*(T(2) -2*T(1) + T1)/dx**2
    for i = 2:1:N-1
        y(i) = alfa*(T(i+1) -2*T(i) + T(i-1))/dx**2
    end
    Tn = Ti
    y(N) = alfa*(Tn -2*T(N-1) + T(N-2))/dx**2
endfunction
//------------------------------------------------------------------------------ 

//------------------------------------------------------------------------------
//                                    CONSTANTES                                 
N = 50
Ti = 70 // °F
q = 300 // Btu/h ft²
k = 1 // Btu/h ft°F
alfa = 0.04 // ft²/h
xi = 0 // ft
xf = 5 // ft
dx = (xf-xi)/N
//------------------------------------------------------------------------------ 

//------------------------------------------------------------------------------
//                                    APLICANDO                                 
Tinicial = Ti*ones(N,1)
t = [0: 0.1:20]
TT = ode(Tinicial, t(1), t, din)

//------------------------------------------------------------------------------ 

//------------------------------------------------------------------------------
//                                    PLOTANDO                                 
xx = xi:dx:xf
scf(0)
clf(0)
plot(t, TT(1,:), "r")
plot(t, TT(N/2,:),"b")
plot(t, TT(N, :), "m")
xtitle("Temperatura em função do tempo para cada posição", "$Tempo[h]$", "$Temperatura[F]$")
legend(["x=0", "x=N/2", "x=N"])

TT = [TT;ones(1, length(t))*Ti]
scf(1)
clf(1)
plot(xx', TT(:,11), "r")
plot(xx', TT(:,length(t)/2), "b")
plot(xx', TT(:, length(t)), "m")
xtitle("Temperatura em função da posição para cada tempo", "$Posição[ft]$", "$Temperatura[F]$")
legend(["t=0", "t=t/2", "t=t"])
//------------------------------------------------------------------------------ 









