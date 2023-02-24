//------------------------------------------------------------------------------
//                                DESCRIÇÃO
//------------------------------------------------------------------------------
//Estudo de funções do Scilab
//Exemplo 1: Plano de fase de sistemas não lineares
//Autor: 
//Data:
//------------------------------------------------------------------------------
//                             PRÉ-PROCESSAMENTO
//------------------------------------------------------------------------------

clc
clear
mode(-1)

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

function plotar(t, x, tela, nome, axis_name, cor)
    subplot(2,2,tela); plot(t, x(tela,:), cor)
    xtitle(nome, "Tempo (h)", axis_name)
    xgrid(1)
endfunction

function plotar2(x, cor)
    plot(x(4,:), x(1,:), cor)
endfunction
//------------------------------------------------------------------------------
//                              VARIAVEIS
//------------------------------------------------------------------------------
V0 = 100
v0 = 240
Ca0 = 4
Cpa = 30
Cpb = 60
Cpc = 20
CH2SO4 = 35
CpH2SO4 = 1
UA = 35000
Ta = 298
FA0 = Ca0*v0
T0 = 305
deltaHr1A = -6500
deltaHr2B = 8000
tf = 1.5

//------------------------------------------------------------------------------
//                              PERGUNTA 1
//------------------------------------------------------------------------------

t = 0:0.01:tf
xinicial = [[1; 0; 0; 290], [3; 0; 0; 290], [3; 0; 0; 273.15]]

scf(1)
nome =["Variação da concentração de A", "Variação da concentração de B", "Variação da concentração de C", "Variação da temperatura do reator"]
axis = ["Concentração de A (mol/dm³)", "Concentração de B (mol/dm³)", "Concentração de C (mol/dm³)", "Temperatura do reator (K)"]
leg = ["(Ca0 = 1 mol/dm³; T0 = 290 K)", "(Ca0 = 3 mol/dm³; T0 = 290 K)", "(Ca0 = 3 mol/dm³; T0 = 273,15 K)"]
cor = ["g", "b", "r", "m"]

for i = 1:1:3
    X = ode(xinicial(:, i), t(1), t, din)
    for j = 1:1:4
        plotar(t, X, j, nome(j), axis(j), cor(i))
    end
end
for i = 1:1:4
    if i == 2  
        subplot(2,2,i); legend([leg(1), leg(2), leg(3)], 4)
    elseif i == 3
        subplot(2,2,i); legend([leg(1), leg(2), leg(3)], 4)
    else
        subplot(2,2,i); legend([leg(1), leg(2), leg(3)])
    end
end
/*
RESPOSTA 1: 

A partir da análise gráfica, é possível determinar que a concentração de A aumenta inicialmente devido à alimentação do mesmo. Observa-se que, por volta de 0.4 horas, é atingida a concentração máxima, uma vez que a temperatura do reator aumenta exponencialmente e a reação é endotérmica, ocasionando uma rápida diminuição na concentração de A.

Inicialmente, a concentração de B é nula e aumenta lentamente à medida que A é consumido, atingindo um pico quando a taxa de consumo de A é máxima e, em seguida, diminui devido ao consumo de B para a geração de C.

A concentração de C é aproximadamente nula até o tempo 0.35, uma vez que a concentração de C é diretamente dependente da concentração de B, que leva certo tempo para aumentar. Além disso, é possível perceber que a concentração de C não atinge um máximo absoluto e nem atingirá, pois nada está consumindo C, e esta aumentará até que a alimentação de A cesse e os reagentes A e B acabem.

Por fim, em relação à temperatura do reator, esta aumenta lentamente no início, sendo diretamente proporcional à taxa de reação de conversão de B para C, já que essa reação é exotérmica e responsável pelo aumento da temperatura do reator.
*/
//------------------------------------------------------------------------------
//                              PERGUNTA 2
//------------------------------------------------------------------------------
t = 0:0.01:tf
leg = ["Condição inicial (Ca0 = 1 mol/dm³; T0 = 290 K)", "Condição inicial (Ca0 = 3 mol/dm³; T0 = 290 K)", "Condição inicial (Ca0 = 3 mol/dm³; T0 = 273,15 K)"]
xinicial = [[1; 0; 0; 290], [3; 0; 0; 290], [3; 0; 0; 273.15]]

scf(2)
for i = 1:1:3
    X = ode(xinicial(:, i), t(1), t, din)
    plotar2(X, cor(i))
end
legend(leg(1), leg(2), leg(3))
xtitle("Plano de fases", "Temperatura (K)", "Concentração de A")
xgrid(1)
/*
RESPOSTA 2: 

A partir dos graficos obtidos tem-se que objetivando uma maior produtividade de C as condições iniciais ideais são Cao = 3 mol/dm³ e To = 290 K, pois a temperatura máxima de operação não ultrapassa 440 K e concentração C final é muito superior.

*/

disp('FIM')

