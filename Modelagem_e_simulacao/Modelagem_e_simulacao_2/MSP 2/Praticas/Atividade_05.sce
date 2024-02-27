//------------------------------------------------------------------------------
//                                DESCRIÇÃO
//------------------------------------------------------------------------------
//Estudo de funções do Scilab
//Exemplo 1: Plano de fase de sistemas não lineares
//Autor: Nicole Maia Argondizzi
//Data:
//------------------------------------------------------------------------------
//                             PRÉ-PROCESSAMENTO
//------------------------------------------------------------------------------

clc
clear
mode(-1)


//----------->Entrada de dados
Cpa = 30 // cal/mol K
Cpb = 60 
Cpc = 20
CpH2SO4 = 35
deltaHr1A = -6500 // cal/mol
deltaHr2B = 8000
CH2SO4 = 1
V0= 100 // dm³
v0= 240 //dm³/h
FA0 = 240
UA = 35.000//cal/h K 
Ta = 298

// Alimentação
Ca0 = 1 // mol/dm³
Cb0 = 0
Cc0 = 0
T0 = 290 //K 
tf = 1.5 //h



//------------------------------------------------------------------------------
//                             FUNÇÕES
//------------------------------------------------------------------------------
function f=din(t,x)
    Ca=x(1)
    Cb=x(2)
    Cc=x(3)
    T=x(4)
    k1a=1.25*exp((9500/1.987)*(1/320-1/T))
    k2b=0.08*exp((7000/1.987)*(1/290-1/T))
    rA=-k1a*Ca
    rB=k1a*Ca/2-k2b*Cb
    rC=3*k2b*Cb
    r1A=rA
    r2B=-k2b*Cb
    V=V0+v0*t
    NCp=(Ca*Cpa+Cb*Cpb+Cc*Cpc)*V+CH2SO4*CpH2SO4*V0
    f(1)=rA+(Ca0-Ca)*v0/V
    f(2)=rB-Cb*v0/V
    f(3)=rC-Cc*v0/V
    f(4)=(UA*(Ta-T)-FA0*Cpa*(T-T0)+(deltaHr1A*r1A+deltaHr2B*r2B)*V)/NCp
endfunction


//------------------------------------------------------------------------------
//                              PROGRAMA PRINCIPAL
//------------------------------------------------------------------------------


//----------->Processamento
t=0:0.001:1.5
xinicial= [1;0;0;290] 
xi=ode(xinicial,t(1),t,din)

//----------->Saída de dados
scf()
clf()

subplot(2,1,1),plot(t,xi(1,:),"g")
subplot(2,1,1),plot(t,xi(2,:),"r")
subplot(2,1,1),plot(t,xi(3,:),"b")
xtitle('Concentração vs Tempo','tempo [h]','Concentrações [mol/dm³]')
legend(["Ca [mol/dm³]","Cb [mol/dm³]","Cc [mol/dm³]"])
xgrid(0)

subplot(2,1,2),plot(t,xi(4,:),"m")
xtitle('Temperatura vs Tempo','tempo [h]','Temperatura [K]')
legend(["Ti [K]"])
xgrid(0)

//----------->Fim do programa
disp('FIM')
