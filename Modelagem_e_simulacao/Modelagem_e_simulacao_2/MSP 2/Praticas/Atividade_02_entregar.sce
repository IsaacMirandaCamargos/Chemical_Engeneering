
//------------------------------------------------------------------------------
//                                DESCRIÇÃO
//------------------------------------------------------------------------------
//Autor:Nicole Maia Argondizzi
//------------------------------------------------------------------------------
//                             PRÉ-PROCESSAMENTO
//------------------------------------------------------------------------------
clc
clear
mode(-1)

//----------->Entrada de dados
//Parâmetros
Tin = 22 + 273.15 //K
Tjin = 22 + 273.15//K
Ta = 26 + 273.15//K
Cain= 1 //mol/L
UA=4.68 //kJ.K/min
UAra=0.6 //kJ.K/min
UAja=0.13 //kJ.K/min
Pemax=180 //kJ/min
ko=5e8 //1/min
E_R = 8800 //K
deltaH=580 //kJ/mol
V=8.74 //L
Vj=2.06 //L
Cp = 4.2 //kJ.kg/K
rho=1//kg/L
F = 0.3//L/min
Fj=1 //L/min

// Condições iniciais
To=350 //K
Tjo=283 //K
Cao = 2 //mol/L

//------------------------------------------------------------------------------
//                             FUNÇÕES
//------------------------------------------------------------------------------
function f=ee(xi)
     Ca = xi(1)
    T = xi(2)   
    Tj = xi(3)
    
    //Pe
    Pe = deltaH*ko*exp(-E_R/T)*Ca*V
    
    //Ca
    f(1)= (F/V)*(Cain-Ca)-(Pe/(deltaH*V))
   
    //T
    f(2)= (F/V) * (Tin-T) - (UA/(Cp*rho*V))*(T-Tj) - (UAra/(Cp*rho*V))*(T-Ta) + (Pe/(Cp*rho*V))
    
    //Tj
    f(3)= (Fj/Vj) * (Tjin-Tj) + (UA/(Cp*rho*Vj))*(T-Tj) - (UAja/(Cp*rho*Vj))*(Tj-Ta)
    
endfunction

function f=din(t,xi)
     Ca = xi(1)
    T = xi(2)   
    Tj = xi(3)
    
    //Pe
    Pe = deltaH*ko*exp(-E_R/T)*Ca*V
    
    //Ca
    f(1)= (F/V)*(Cain-Ca)-(Pe/(deltaH*V))
   
    //T
    f(2)= (F/V) * (Tin-T) - (UA/(Cp*rho*V))*(T-Tj) - (UAra/(Cp*rho*V))*(T-Ta) + (Pe/(Cp*rho*V))
    
    //Tj
    f(3)= (Fj/Vj) * (Tjin-Tj) + (UA/(Cp*rho*Vj))*(T-Tj) - (UAja/(Cp*rho*Vj))*(Tj-Ta)
endfunction

function f=din_lin(t,xbar,A)
    f=A*xbar
endfunction
//------------------------------------------------------------------------------
//                              PROGRAMA PRINCIPAL
//------------------------------------------------------------------------------

//----------->Processamento
//Estado estacionário
xestima=[1;200;200]
[sol,fsol,info]=fsolve(xestima,ee)
if  info==1 then
    disp('Solução')
    disp(sol)
end

//Estado Dinâmico
//Não linear
t=0:0.001:120
xinicial=[Cao;To;Tjo]
x=ode(xinicial,t(1),t,din)


//Estado Dinâmico
//Linear
J=numderivative(ee,sol)
xinicial_bar=xinicial-sol
lista2=list(din_lin,J)
xbar=ode(xinicial_bar,t(1),t,lista2)

//----------->Saída de dados


//Gráfico da concentração pelo tempo: Este comportamento exponencial de queda é uma característica dos sistemas de reação em CSTR, especialmente se a reação é de primeira ordem. No entanto, este comportamento exponencial é difícil de controlar e prever ao longo do tempo. Ao linearizar a equação de taxa de reação, obtemos uma aproximação linear que facilita o controle do sistema e a previsão de comportamentos futuros. Esta é uma simplificação e não é exata, mas permite um controle mais eficiente.

scf(0)
clf()
subplot(3,1,1),plot(t,x(1,:),'r')
subplot(3,1,1),plot(t,xbar(1,:)+sol(1),'r-.')
xtitle('Concentração vs Tempo','t[min]','Ci[mol/L]')
legend(['Não Linear', 'Linearizado'])
xgrid(0)

//Gráfico da temperatura pelo tempo: Novamente, o comportamento exponencial indica que o sistema é bem controlado e que o controle de temperatura está funcionando corretamente. A linearização neste caso pode ajudar a entender como pequenas mudanças na entrada (como a taxa de fluxo ou a temperatura inicial) afetam a temperatura final.

subplot(3,1,2),plot(t,x(2,:),'b')
subplot(3,1,2),plot(t,xbar(2,:)+sol(2),'b-.')
xtitle('Temperatura do reator vs Tempo','t[min]','T [K]')
legend(['Não Linear', 'Linearizado'])
xgrid(0)

//Gráfico da temperatura pelo tempo na jaqueta de resfriamento: O pico inicial e a queda subsequente é um comportamento típico em sistemas CSTR, indicando que o calor da reação é inicialmente absorvido e então dissipado. Ao linearizar a equação de balanço de energia, podemos obter uma compreensão melhor de como as variáveis de entrada, como a taxa de resfriamento, afetam a taxa de dissipação de calor.

subplot(3,1,3),plot(t,x(3,:),'m')
subplot(3,1,3),plot(t,xbar(3,:)+sol(2),'m-.')
xtitle('Temperatura da jaqueta vs Tempo','t[min]','T [K]')
legend(['Não Linear', 'Linearizado'])
xgrid(0)

//----------->Fim do programa
disp('***FIM***')
