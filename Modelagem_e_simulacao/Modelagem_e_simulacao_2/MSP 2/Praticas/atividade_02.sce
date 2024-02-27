//------------------------------------------------------------------------------
//                                DESCRIÇÃO
//------------------------------------------------------------------------------
//Estudo de funções do Scilab
//Exemplo 1 - CSTR
//Autor:Nádia Guimarães Sousa
//Data: 12/06/2023
//------------------------------------------------------------------------------
//                             PRÉ-PROCESSAMENTO
//------------------------------------------------------------------------------
clc
clear
mode(-1)
//------------------------------------------------------------------------------
//                             FUNÇÕES
//------------------------------------------------------------------------------
function f=ee(x)
    Ca=x(1);
    T=x(2);
    
    f(1)=F_V*(Caf-Ca)-k0*exp(-deltaE/(R*T))*Ca;
    f(2)=F_V*(Tf-T)+(-deltaH)/(roCp)*k0*exp(-deltaE/(R*T))*Ca-UA_V/(roCp)*(T-Tj);
    
endfunction

function f=din(t,x)
    Ca=x(1);
    T=x(2);
    
    f(1)=F_V*(Caf-Ca)-k0*exp(-deltaE/(R*T))*Ca;
    f(2)=F_V*(Tf-T)+(-deltaH)/(roCp)*k0*exp(-deltaE/(R*T))*Ca-UA_V/(roCp)*(T-Tj);   
endfunction

function A = matA(sol,k0,deltaE,R,F_V,roCp,UA_V)
    Cas=sol(1)
    Ts=sol(2)
    ks=k0*exp(-deltaE/(R*Ts))
    Dks=ks*deltaE/(R*Ts^2)
    
    A(1,1)= -F_V-ks
    A(1,2)= -Cas*Dks
    A(2,1)= -deltaH/roCp*ks
    A(2,2)= -F_V-UA_V/roCp+(-deltaH)/roCp*Cas*Dks
    
endfunction

function f=din_lin(t,xbar,A)
    f=A*xbar
endfunction

//------------------------------------------------------------------------------
//                              PROGRAMA PRINCIPAL
//------------------------------------------------------------------------------

//----------->Entrada de dados
F_V=1;
Caf=10;
k0=9703*3600;
deltaE=11843;
R=1.987;
deltaH=5960;
roCp=500;
Tf=25+273.15;
UA_V=150;
Tj=20+273.15;
//----------->Processamento
//Estado estacionário
xestima=[5;35+273];
[sol,fsol,info]=fsolve(xestima,ee);
if  info==1 then
    disp('Solução')
    disp(sol)
end

//Dinâmico
//Não linear
t=[0:0.1:10];
xinicial=[10;300];
x=ode(xinicial,t(1),t,din)

//Linearizado
//1 forma - utilizando matA
A=matA(sol,k0,deltaE,R,F_V,roCp,UA_V)

xinicial_bar=xinicial-sol

lista=list(din_lin,A)

xbar=ode(xinicial_bar,t(1),t,lista)

//2 forma - utilizando função numderivative
J=numderivative(ee,sol)
xinicial_bar=xinicial-sol
lista=list(din_lin,J)
xbar2=ode(xinicial_bar,t(1),t,lista2)

//----------->Saída de dados
scf(0)
clf()
subplot(2,1,1),plot(t,x(1,:),'r')
subplot(2,1,1),plot(t,xbar(1,:)+sol(1),'r-.')
xtitle('','$t[h]$','$C_A [kgmol/m^3]$')
legend(['Não Linear', 'Linearizado'])

subplot(2,1,2),plot(t,x(2,:),'b')
subplot(2,1,2),plot(t,xbar(2,:)+sol(2),'b-.')
xtitle('','$t[h]$','$T [K]$')
legend(['Não Linear', 'Linearizado'])

//----------->Fim do programa
disp('***FIM***')
