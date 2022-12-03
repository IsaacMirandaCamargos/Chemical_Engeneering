//------------------------------------------------------------------------------
//                                DESCRIÇÃO
//------------------------------------------------------------------------------
//Estudo de funções do Scilab
//Exemplo 1: Modelos Adimensionais
//Autor:ISAAC
//Data: 26/09/2022
//------------------------------------------------------------------------------
//                             PRÉ-PROCESSAMENTO
//------------------------------------------------------------------------------
clc
clear
mode(-1)
//------------------------------------------------------------------------------
//                             FUNÇÕES
//------------------------------------------------------------------------------
//Modelo dimensional
function f=ee(x)
    h1=x(1)
    h2=x(2)
    f(1)=F/A1-(B1*sqrt(h1-h2))/A1
    f(2)=(B1*sqrt(h1-h2))/A2-(B2*sqrt(h2))/A2
endfunction

function dxdt=din(t,x)
    h1=x(1)
    h2=x(2)
    dxdt(1)=F/A1-(B1*sqrt(h1-h2))/A1
    dxdt(2)=(B1*sqrt(h1-h2))/A2-(B2*sqrt(h2))/A2
endfunction


//Adimensional
function f = ee_adimensional(x)
    h1_ad = x(1)
    h2_ad = x(2)
    f(1) = 1 - (B1*sqrt(sol(1))*sqrt(h1_ad-h2_ad))/F
    f(2) = (B1*A1*sqrt(sol(1))*sqrt(h1_ad-h2_ad))/(F*A2) -(B2*A1*sqrt(sol(1))*sqrt(h2_ad))/(F*A2) 
endfunction


function dxdt = din_adimensional(t, x)
    h1_ad = x(1)
    h2_ad = x(2)
    dxdt(1) = 1 - B1*sqrt(sol(1))*sqrt(h1_ad-h2_ad)/F
    dxdt(2) = (B1*A1*sqrt(sol(1))*sqrt(h1_ad-h2_ad))/(F*A2) -(B2*A1*sqrt(sol(1))*sqrt(h2_ad))/(F*A2)
    
endfunction

//------------------------------------------------------------------------------
//                              PROGRAMA PRINCIPAL
//------------------------------------------------------------------------------

//----------->Entrada de dados
F=5;
A1=5;
A2=10;
B1=2.5;
B2=5/sqrt(6);
h1o = 8 // m
h2o = 5 // m

//----------->Processamento

//Modelo dimensional
xi=[h1o; h2o]
[sol,v,info]=fsolve(xi, ee)

if info==1 then
    disp('Solução dimensional (h1, h2):')
    disp(sol)
else
    disp('Tente novamente!')
end


xi=[h1o; h2o]
t=[0:0.1:300]
xf = ode(xi, t(1), t, din)

//Modelo adimensional

xi=[h1o; h2o]/sol(1)
[sol2,v,info]=fsolve(xi, ee_adimensional)

if info==1 then
    disp('Solução adimensional (h1,h2):')
    disp(sol2)
else
    disp('Tente novamente!')
end


xi=[h1o; h2o]/sol(1)
t=[0:0.1:300]
tau = t*F/(A1*sol(1))
xf2 = ode(xi, tau(1), tau, din_adimensional)


//----------->Saída de dados
scf(0)
clf()
// Dimensionais
subplot(2,2,1),plot(t,xf(1,:),'r')
xtitle('','$t[min]$','$h1[ft]$')
subplot(2,2,2),plot(t,xf(2,:),'b')
xtitle('','$t[min]$','$h2[ft]$')

// Adimensionais
subplot(2,2,3),plot(tau,xf2(1,:),'r')
xtitle('','$tau[adimensional]$','$h1[adimensional]$')
subplot(2,2,4),plot(tau,xf2(2,:),'b')
xtitle('','$tau[adimensional]$','$h2[adimensional]$')

//----------->Fim do programa
disp('***FIM***')



