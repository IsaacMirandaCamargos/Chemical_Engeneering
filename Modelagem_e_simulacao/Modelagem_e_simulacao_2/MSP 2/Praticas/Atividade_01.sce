// Nome: Nicole Maia Argondizzi
clc
clear
mode(-1)

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


//----------------Função Estado Estacionário

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

xchute = [1;200;200] 
[sol,v,info]=fsolve(xchute,ee)

//[1].Calcule o estado estacionário.

if info==1 then
    mprintf(' Solução estado estacionário: \n\n')
    // Ca
    mprintf(' Ca : %f\n', sol(1))
    //T
    mprintf(' T : %f\n', sol(2))
    //Tj
    mprintf(' Tj : %f\n', sol(3))
    
else 
    disp("Tente novamente!")
end

//----------------Função Dinâmico
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


t=0:0.001:60
xinicial= [Cao;To;Tjo] 
xi=ode(xinicial,t(1),t,din)





//[1] O comportamento da concentração de A e da temperatura do reator e da jaqueta com o tempo.


//-------- Gráfico da concentração pelo tempo
//A concentração de moléculas diminui exponencialmente com o tempo, indicativo de um processo reativo em que os reagentes são consumidos continuamente.

scf()
clf()

subplot(3,1,1),plot(t,xi(1,:),"m")
xtitle('Concentração vs Tempo','t[min]','Ci[mol/L]')
legend(["Ca [mol/L]"])
xgrid(0)


//---------Gráfico da temperatura pelo tempo
//A temperatura do reator experimenta uma queda exponencial, estabilizando-se em 298 K, o que sugere um eficiente processo de resfriamento.

subplot(3,1,2),plot(t,xi(2,:),"b")
xtitle('Temperatura do reator vs Tempo','t[min]','T [K]')
legend(["T [K]"])
xgrid(0)


//---------Gráfico da temperatura pelo tempo
//Observa-se na jaqueta um pico de temperatura seguido de uma queda até um estado estacionário, implicando que o calor da reação é inicialmente absorvido e, posteriormente, dissipado.

subplot(3,1,3),plot(t,xi(3,:),"r")
xtitle('Temperatura da jaqueta vs Tempo','t[min]','T [K]')
legend(["Tj [K]"])
xgrid(0)


// [2]. Avaliando a influência do Fluxo do Reator

F1 = 0.01
F2 = 0.3
F3 = 1

//----------------Função Dinâmico
function f=din_F(ti,x)
    
    Ca1 = x(1)
    T1 = x(2)   
    Tj1 = x(3)
    
    Ca2 = x(4)
    T2 = x(5)   
    Tj2 = x(6)
    
    Ca3 = x(7)
    T3 = x(8)   
    Tj3 = x(9)
    
    //Fluxo 01
    
    Pe1 = deltaH*ko*exp(-E_R/T1)*Ca1*V

    f(1)= (F1/V)*(Cain-Ca1)-(Pe1/(deltaH*V))
    f(2)= (F1/V) * (Tin-T1) - (UA/(Cp*rho*V))*(T1-Tj1) - (UAra/(Cp*rho*V))*(T1-Ta) + (Pe1/(Cp*rho*V))
    f(3)= (Fj/Vj) * (Tjin-Tj1) + (UA/(Cp*rho*Vj))*(T1-Tj1) - (UAja/(Cp*rho*Vj))*(Tj1-Ta)
    
    //Fluxo 02
    
    Pe2 = deltaH*ko*exp(-E_R/T2)*Ca2*V

    f(4)= (F2/V)*(Cain-Ca2)-(Pe2/(deltaH*V))
    f(5)= (F2/V) * (Tin-T2) - (UA/(Cp*rho*V))*(T2-Tj2) - (UAra/(Cp*rho*V))*(T2-Ta) + (Pe2/(Cp*rho*V))
    f(6)= (Fj/Vj) * (Tjin-Tj2) + (UA/(Cp*rho*Vj))*(T2-Tj2) - (UAja/(Cp*rho*Vj))*(Tj2-Ta)

    //Fluxo 03
    
    Pe3 = deltaH*ko*exp(-E_R/T3)*Ca3*V

    f(7)= (F3/V)*(Cain-Ca3)-(Pe3/(deltaH*V))
    f(8)= (F3/V) * (Tin-T3) - (UA/(Cp*rho*V))*(T3-Tj3) - (UAra/(Cp*rho*V))*(T3-Ta) + (Pe3/(Cp*rho*V))
    f(9)= (Fj/Vj) * (Tjin-Tj2) + (UA/(Cp*rho*Vj))*(T3-Tj3) - (UAja/(Cp*rho*Vj))*(Tj3-Ta)

endfunction

ti=0:0.01:60
xinicial= [Cao;To;Tjo;Cao;To;Tjo;Cao;To;Tjo]
x=ode(xinicial,ti(1),ti,din_F)


//-------- Gráfico da concentração pelo tempo
//O fluxo F1 mostra uma diminuição gradual na concentração, indo de 2 para 1.84 mol/L em um período de 60 minutos.
//O fluxo F2 exibe uma diminuição mais aguda na concentração, caindo para 1.15 mol/L ao final de 60 minutos.
//O fluxo F3 apresenta uma queda exponencial mais acentuada na concentração, atingindo 1 mol/L aproximadamente aos 43 minutos.
scf()
clf()

subplot(3,1,1),plot(ti,x(1,:),"m")
subplot(3,1,1),plot(ti,x(4,:),"r")
subplot(3,1,1),plot(ti,x(7,:),"b")
xtitle('Concentração vs Tempo','t[min]','Ca[mol/L]')
legend(["F1: 0.01 [L/min]","F2: 0.3 [L/min]", "F3: 1 [L/min]"])
xgrid(0)

//---------Gráfico da temperatura pelo tempo
//Para todos os fluxos (F1, F2 e F3), a temperatura do reator diminui exponencialmente com o tempo.
//F1 apresenta a queda mais lenta, seguida por F2, enquanto F3 é o fluxo com a queda mais rápida de temperatura.
//O estado estacionário da temperatura é atingido em cerca de 49 minutos para o fluxo F3.

subplot(3,1,2),plot(ti,x(2,:),"m")
subplot(3,1,2),plot(ti,x(5,:),"r")
subplot(3,1,2),plot(ti,x(8,:),"b")
xtitle('Temperatura do reator vs Tempo','t[min]','T [K]')
legend(["F1: 0.01 [L/min]","F2: 0.3 [L/min]", "F3: 1 [L/min]"])
xgrid(0)


//---------Gráfico da temperatura pelo tempo
//Em todos os fluxos (F1, F2 e F3), observa-se um rápido aumento na temperatura da jaqueta, atingindo picos de temperatura em diferentes momentos.
//O pico de temperatura para F1 é atingido aos 2 minutos a 311 K, enquanto para F2 é atingido aos 3 minutos a 315 K, e para F3 aos 4 minutos a 317 K.

subplot(3,1,3),plot(ti,x(3,:),"m")
subplot(3,1,3),plot(ti,x(6,:),"r")
subplot(3,1,3),plot(ti,x(9,:),"b")
xtitle('Temperatura da jaqueta vs Tempo','t[min]','T [K]')
legend(["F1: 0.01 [L/min]","F2: 0.3 [L/min]", "F3: 1 [L/min]"])
xgrid(0)


// [2]. Avaliando a influência do Fluxo da Jaqueta

Fj1 = 0.1
Fj2 = 1
Fj3 = 3

//----------------Função Dinâmico
function f=din_Fj(ti,y)
    
    Ca1 =y(1)
    T1 = y(2)   
    Tj1 = y(3)
    
    Ca2 = y(4)
    T2 = y(5)   
    Tj2 = y(6)
    
    Ca3 = y(7)
    T3 = y(8)   
    Tj3 = y(9)
    
    //Fluxo 01
    
    Pe1 = deltaH*ko*exp(-E_R/T1)*Ca1*V

    f(1)= (F/V)*(Cain-Ca1)-(Pe1/(deltaH*V))
    f(2)= (F/V) * (Tin-T1) - (UA/(Cp*rho*V))*(T1-Tj1) - (UAra/(Cp*rho*V))*(T1-Ta) + (Pe1/(Cp*rho*V))
    f(3)= (Fj1/Vj) * (Tjin-Tj1) + (UA/(Cp*rho*Vj))*(T1-Tj1) - (UAja/(Cp*rho*Vj))*(Tj1-Ta)
    
    //Fluxo 02
    
    Pe2 = deltaH*ko*exp(-E_R/T2)*Ca2*V

    f(4)= (F/V)*(Cain-Ca2)-(Pe2/(deltaH*V))
    f(5)= (F/V) * (Tin-T2) - (UA/(Cp*rho*V))*(T2-Tj2) - (UAra/(Cp*rho*V))*(T2-Ta) + (Pe2/(Cp*rho*V))
    f(6)= (Fj2/Vj) * (Tjin-Tj2) + (UA/(Cp*rho*Vj))*(T2-Tj2) - (UAja/(Cp*rho*Vj))*(Tj2-Ta)

    //Fluxo 03
    
    Pe3 = deltaH*ko*exp(-E_R/T3)*Ca3*V

    f(7)= (F/V)*(Cain-Ca3)-(Pe3/(deltaH*V))
    f(8)= (F/V) * (Tin-T3) - (UA/(Cp*rho*V))*(T3-Tj3) - (UAra/(Cp*rho*V))*(T3-Ta) + (Pe3/(Cp*rho*V))
    f(9)= (Fj3/Vj) * (Tjin-Tj2) + (UA/(Cp*rho*Vj))*(T3-Tj3) - (UAja/(Cp*rho*Vj))*(Tj3-Ta)

endfunction

y=ode(xinicial,ti(1),ti,din_Fj)


//-------- Gráfico da concentração pelo tempo
// Todos os fluxos da jaqueta (Fj1, Fj2, Fj3) não apresentam variação na concentração ao longo do tempo. Isso sugere que a concentração de moléculas no reator não é afetada pela taxa de fluxo da jaqueta.

scf()
clf()

subplot(3,1,1),plot(ti,y(1,:),"m")
subplot(3,1,1),plot(ti,y(4,:),"r")
subplot(3,1,1),plot(ti,y(7,:),"b")
xtitle('Concentração vs Tempo','t[min]','Ca[mol/L]')
legend(["Fj1: 0.1 [L/min]","Fj2: 1 [L/min]", "Fj3: 3 [L/min]"])
xgrid(0)

//---------Gráfico da temperatura pelo tempo
//Para todos os fluxos da jaqueta (Fj1, Fj2 e Fj3), a temperatura do reator cai exponencialmente com o tempo.
//Fj1 apresenta a queda mais lenta na temperatura, seguida por Fj2, enquanto Fj3 mostra a queda mais rápida, atingindo um estado estacionário em cerca de 56 minutos.
//No caso dos fluxos Fj1 e Fj2, o estado estacionário é atingido mais rapidamente, aos 45 e 35 minutos, respectivamente.


subplot(3,1,2),plot(ti,y(2,:),"m")
subplot(3,1,2),plot(ti,y(5,:),"r")
subplot(3,1,2),plot(ti,y(8,:),"b")
xtitle('Temperatura do reator vs Tempo','t[min]','T [K]')
legend(["Fj1: 0.1 [L/min]","Fj2: 1 [L/min]", "Fj3: 3 [L/min]"])
xgrid(0)


//---------Gráfico da temperatura pelo tempo
//Para todos os fluxos da jaqueta (Fj1, Fj2 e Fj3), há um rápido aumento na temperatura da jaqueta, alcançando picos em diferentes momentos.
//Para Fj1, o pico de temperatura é atingido em cerca de 2 minutos a 311 K, para Fj2 em 3 minutos a 316 K, e para Fj3 em 4 minutos a 318 K.

subplot(3,1,3),plot(ti,x(3,:),"m")
subplot(3,1,3),plot(ti,x(6,:),"r")
subplot(3,1,3),plot(ti,x(9,:),"b")
xtitle('Temperatura da jaqueta vs Tempo','t[min]','T [K]')
legend(["Fj1: 0.1 [L/min]","Fj2: 1 [L/min]", "Fj3: 3 [L/min]"])
xgrid(0)








