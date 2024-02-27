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

UA = 35000//cal/h K 
Ta = 298

// Alimentação
Ca0 = 4 // mol/dm³
Cb0 = 0
Cc0 = 0
T0 = 305 //K 
tf = 1.5 //h

FA0 = v0* Ca0


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
t=0:0.01:1.5

xinicial= [1;0;0;290] 
xi=ode(xinicial,t(1),t,din)

xinicial1= [1;0;0;290] 
xi1=ode(xinicial1,t(1),t,din)

xinicial2= [3;0;0;290] 
xi2=ode(xinicial2,t(1),t,din)

xinicial3= [3;0;0;273.15] 
xi3=ode(xinicial3,t(1),t,din)

//----------->Saída de dados

// Parte 01 - Gráfico 01 - Podemos observar que a concentração de A tem um leve aumento nas primeiras 0.5 horas e depois disso começa a decair tendendo a 0 em 0.65 horas se mantendo em estado estacionário ao mesmo tempo a concentração de C fica em estado estacionario até 0.5 horas assim que passa deste tempo começa a crescer formando o "Produto da reação", mas a concentração de B começa a crescer regressivamente em 0.15 horas e cresce até um pico em 0.65 horas depois disso começa a ter um decrescimento leve até chegar em um estado estacionario em 1.1 horas.

scf()
clf()

subplot(2,1,1),plot(t,xi(1,:),"g")
subplot(2,1,1),plot(t,xi(2,:),"r")
subplot(2,1,1),plot(t,xi(3,:),"b")
xtitle('Concentração vs Tempo','tempo [h]','Concentrações [mol/dm³]')
legend(["Ca [mol/dm³]","Cb [mol/dm³]","Cc [mol/dm³]"])
xgrid(0)

// Parte 01 - Gráfico 02 - A temperatura aumenta exponencialmente com o tempo até chegar em um pico em 0.65 horas e depois disso vai decrescendo tendendo a ficar em um estado estacionário em 370 K.

subplot(2,1,2),plot(t,xi(4,:),"m")
xtitle('Temperatura vs Tempo','tempo [h]','Temperatura [K]')
legend(["Ti [K]"])
xgrid(0)


// Parte 02 - A melhor possibilidade é com a temperatura inicial igual a 290 K e concentração inicial igual a 1 mol/dm³ pois ela fica longe de ultrapassar o valor de 440 K, pois a terceira opção ultrapassa e a segunda fica muito proxima de 440 K tornando processos perigosos a ser tomados 

scf()
clf()

plot(xi1(4,:),xi1(1,:),"g")
plot(xi2(4,:),xi2(1,:),"r")
plot(xi3(4,:),xi3(1,:),"b")
xtitle('Concentração vs Temperatura','Temperatura [K]','Concentrações [mol/dm³]')
legend(["Ca01 [mol/dm³]","Ca02 [mol/dm³]","Ca03 [mol/dm³]"])
xgrid(0)


//----------->Fim do programa
disp('FIM')
