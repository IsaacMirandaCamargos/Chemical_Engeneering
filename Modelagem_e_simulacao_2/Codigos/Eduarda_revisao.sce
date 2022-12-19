//---------------------------------------------------------------------------------
//------------------------------------------Descrição------------------------------
//16/12/2022
//Estudo de funções do scilab
//Aula 01 - MSP II
//Autor: Eduarda Maia Guimarães

clc
clear
mode(-1)

//------------------FUNCTIONS-------------------------------------------------------
function f=din(t,x,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
    M=x(1)//[M em Kg]
    Tr=x(2)
    if M>10000 then
        W=0
    end
    Q=U*A*(Tr-Tc)
    f(1)=W
    f(2)=W*(Ti-Tr)/M+W*x0*mdeltaH/(M*Cp)-Q/(M*Cp)
endfunction

//---------------------------MAIN PROGRAM---------------------------------------

//dados
 
A=2// [m^2]
Cp=1//[Kcal/kgºC]
Tc=25//[ºC]
Ti=25//[ºC]
U=415//[kcal/m^2*min*ºC]
W=140//[kg/min]
x0=0.25//[Adimensional]
mdeltaH=1100//[Kcal/kg]

//Janela de Gráfico 0 

/*

Analisando os resultados:


    A massa dentro do reator aumenta de forma constante devido a um fluxo constante de material. No entanto, a reação eventualmente atinge um ponto em que o limite de massa do reator é atingido e o aumento de massa para bruscamente. A temperatura no reator também aumenta rapidamente à medida que a reação exotérmica libera energia. 
    No entanto, a temperatura eventualmente diminui à medida que a energia liberada pela reação se equilibra com a energia perdida para a jaqueta. Também é observado que a transferência de energia do reator para a jaqueta é proporcional à temperatura do reator. Uma vez que o sistema atinge o equilíbrio, a transferência de energia e a temperatura permanecem constantes até que o fluxo de massa pare. 
    Eventualmente, à medida que a transferência de energia diminui, a temperatura do reator se aproxima da temperatura da jaqueta.


*/
t=0:0.1:140
xinicial=[1000;25]
lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)    //Lista que contém a função e as constantes 
x=ode(xinicial,t(1),t,lista)
Q=U*A*(x(2,:)-Tc)
scf(0)
clf(0)
subplot(3,1,1);plot(t,x(1,:),'r')
xtitle('Correlação da massa e o tempo','$t[min]$','$M[kg]$')
subplot(3,1,2);plot(t,x(2,:),'b')
xtitle('Correlação da temperatura e o tempo','$t[min]$','$T_R[^oC]$')
subplot(3,1,3);plot(t,Q,'m'),
xtitle('Correlação da Vazão e o tempo','$t[min]$','$Q[kcal/min]$')

//Analisando a área

/*

Analisando os resultados:


    O tamanho da área não afetou a quantidade de massa que entrou no reator, pois a taxa de entrada foi constante. Verificou-se também que quanto menor a área do reator, maior seria a temperatura máxima atingida pelo mesmo. 
    Isso se deve à maior superfície de troca de energia com a jaqueta, o que diminui a temperatura máxima do reator e aumenta a velocidade de transferência de calor. Por fim, observou-se que a quantidade de energia transferida aumenta à medida que o tamanho da área do reator aumenta, como esperado, pois uma área maior implica em uma maior superfície de troca.


*/

t=0:2.5:140
A=1; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x1=ode(xinicial,t(1),t,lista); QA1=U*A*(x1(2,:)-Tc)
A=2; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x2=ode(xinicial,t(1),t,lista); QA2=U*A*(x2(2,:)-Tc)
A=3; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x3=ode(xinicial,t(1),t,lista); QA3=U*A*(x3(2,:)-Tc)
A=2

scf(1)
clf(1)
subplot(3,1,1);plot(t,x1(1,:),'r')
subplot(3,1,1);plot(t,x2(1,:),'b')
subplot(3,1,1);plot(t,x3(1,:),'m')
xtitle("Massa do reator", "$tempo (min)$", "$Massa (kg)$")
subplot(3,1,1); legend(["A=1", "A=2", "A=3"])


subplot(3,1,2);plot(t,x1(2,:),'r')
subplot(3,1,2);plot(t,x2(2,:),'b')
subplot(3,1,2);plot(t,x3(2,:),'m')
xtitle("Temperatura do reator", "$tempo (min)$", "$Temperatura (°C)$")
subplot(3,1,2); legend(["A=1", "A=2", "A=3"])


subplot(3,1,3);plot(t,QA1,'r')
subplot(3,1,3);plot(t,QA2,'b')
subplot(3,1,3);plot(t,QA3,'m')
xtitle("Transferência de energia", "$tempo (min)$", "$Energia (kcal/min)$")
subplot(3,1,3); legend(["A=1", "A=2", "A=3"])


//Analisando a temperatura de alimentação

/*

Analisando os resultados:


    A temperatura de alimentação não afetou a taxa de entrada de massa no reator, como esperado devido à taxa ser constante. Quanto à temperatura do reator, pode-se observar que quanto maior a temperatura de alimentação, maior é a taxa inicial de aumento da temperatura e maior é a temperatura de equilíbrio do reator. 
    Além disso, em relação à transferência de energia do reator, observa-se que a quantidade de energia transferida aumenta à medida que a temperatura de alimentação aumenta. Isso se deve ao deslocamento da temperatura de equilíbrio do reator para valores maiores conforme a temperatura de alimentação aumenta.


*/

t=0:0.1:140
Ti=0; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x1=ode(xinicial,t(1),t,lista); QA1=U*A*(x1(2,:)-Tc)
Ti=25; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x2=ode(xinicial,t(1),t,lista); QA2=U*A*(x2(2,:)-Tc)
Ti=50; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x3=ode(xinicial,t(1),t,lista); QA3=U*A*(x3(2,:)-Tc)
Ti=25

scf(2)
clf(2)
subplot(3,1,1);plot(t,x1(1,:),'r')
subplot(3,1,1);plot(t,x2(1,:),'b')
subplot(3,1,1);plot(t,x3(1,:),'m')
xtitle("Massa do reator", "$tempo (min)$", "$Massa (kg)$")
subplot(3,1,1); legend(["Ti=25", "Ti=50", "Ti=75"])


subplot(3,1,2);plot(t,x1(2,:),'r')
subplot(3,1,2);plot(t,x2(2,:),'b')
subplot(3,1,2);plot(t,x3(2,:),'m')
xtitle("Temperatura do reator", "$tempo (min)$", "$Temperatura (°C)$")
subplot(3,1,2); legend(["Ti=25", "Ti=50", "Ti=75"])


subplot(3,1,3);plot(t,QA1,'r')
subplot(3,1,3);plot(t,QA2,'b')
subplot(3,1,3);plot(t,QA3,'m')
xtitle("Transferência de energia", "$tempo (min)$", "$Energia (kcal/min)$")
subplot(3,1,3); legend(["Ti=25", "Ti=50", "Ti=75"])


//Composição de amonia na alimentação

/*

Analisando os resultados:


    A concentração de amônia na alimentação não teve efeito na taxa de entrada de massa, como esperado devido à taxa ser constante. 
    Quanto à temperatura do reator, pode-se ver que quanto maior a concentração de amônia na alimentação, maior será a temperatura máxima do reator. Isso ocorre porque a energia liberada aumentada na conversão de amônia na reação exotérmica faz com que o equilíbrio de energia liberada seja deslocado pela energia cedida na jaqueta. 
    Ademais, há um aumento na transferência de energia do reator para a jaqueta, como esperado devido ao equilíbrio ser deslocado pela maior energia liberada na reação


*/

t=0:1:140
x0=0.1; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x1=ode(xinicial,t(1),t,lista); QA1=U*A*(x1(2,:)-Tc)
x0=0.25; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x2=ode(xinicial,t(1),t,lista); QA2=U*A*(x2(2,:)-Tc)
x0=0.4; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x3=ode(xinicial,t(1),t,lista); QA3=U*A*(x3(2,:)-Tc)
x0=0.25

scf(3)
clf(3)
subplot(3,1,1);plot(t,x1(1,:),'r')
subplot(3,1,1);plot(t,x2(1,:),'b')
subplot(3,1,1);plot(t,x3(1,:),'m')
xtitle("Massa do reator", "$tempo (min)$", "$Massa (kg)$")
subplot(3,1,1); legend(["xo=0.10", "xo=0.25", "xo=0.40"])


subplot(3,1,2);plot(t,x1(2,:),'r')
subplot(3,1,2);plot(t,x2(2,:),'b')
subplot(3,1,2);plot(t,x3(2,:),'m')
xtitle("Temperatura do reator", "$tempo (min)$", "$Temperatura (°C)$")
subplot(3,1,2); legend(["xo=0.10", "xo=0.25", "xo=0.40"])


subplot(3,1,3);plot(t,QA1,'r')
subplot(3,1,3);plot(t,QA2,'b')
subplot(3,1,3);plot(t,QA3,'m')
xtitle("Transferência de energia", "$tempo (min)$", "$Energia (kcal/min)$")
subplot(3,1,3); legend(["xo=0.10", "xo=0.25", "xo=0.40"])




//Analisando a temperatura do fluido refrigerante

/*

Analisando os resultados:


    A temperatura do fluido refrigerante não teve efeito na taxa de entrada de massa, como esperado devido à taxa ser constante. Quanto à temperatura do reator, pode-se observar que quanto maior a temperatura do fluido refrigerante, maior será a temperatura máxima do reator. Isso se deve à taxa de troca térmica entre o reator e a jaqueta, apesar da energia liberada na conversão de amônia permanecer constante. 
    Como mencionado acima, o gráfico da taxa de transferência de energia do reator para a jaqueta mostra uma transferência de energia menor à medida que a temperatura do fluido refrigerante aumenta.


*/

t=0:0.8:140
Tc=0; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x1=ode(xinicial,t(1),t,lista); QA1=U*A*(x1(2,:)-Tc)
Tc=25; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x2=ode(xinicial,t(1),t,lista); QA2=U*A*(x2(2,:)-Tc)
Tc=50; lista=list(din,U,A,Tc,Ti,x0,mdeltaH,Cp,W)
x3=ode(xinicial,t(1),t,lista); QA3=U*A*(x3(2,:)-Tc)
Tc=25

scf(4)
clf(4)
subplot(3,1,1);plot(t,x1(1,:),'r')
subplot(3,1,1);plot(t,x2(1,:),'b')
subplot(3,1,1);plot(t,x3(1,:),'m')
xtitle("Massa do reator", "$tempo (min)$", "$Massa (kg)$")
subplot(3,1,1); legend(["xo=0.10", "xo=0.25", "xo=0.40"])


subplot(3,1,2);plot(t,x1(2,:),'r')
subplot(3,1,2);plot(t,x2(2,:),'b')
subplot(3,1,2);plot(t,x3(2,:),'m')
xtitle("Temperatura do reator", "$tempo (min)$", "$Temperatura (°C)$")
subplot(3,1,2); legend(["xo=0.10", "xo=0.25", "xo=0.40"])


subplot(3,1,3);plot(t,QA1,'r')
subplot(3,1,3);plot(t,QA2,'b')
subplot(3,1,3);plot(t,QA3,'m')
xtitle("Transferência de energia", "$tempo (min)$", "$Energia (kcal/min)$")
subplot(3,1,3); legend(["xo=0.10", "xo=0.25", "xo=0.40"])

//End of the program

disp('***END***')




