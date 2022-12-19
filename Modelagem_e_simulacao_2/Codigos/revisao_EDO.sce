clc
clear
mode(-1)

// Isaac Miranda Camargos


// PROBLEMA: Reator batelada alimentado com resfriamento

// Este problema consiste em uma reação exotermica instantânea que ocorre em um reator batelada.
// Dito isso, é necessario considerar:

// - vazão de entrada no reator
// - troca termica com a camisa


// DADOS
A = 2 // m²
Cp = 1 // kcal/kg.°C
Tc = 25 //°C
Ti = 25 //°C
U = 415 // kcal/m².min.°C
W = 140 // kg/min
xo = 0.25
delta_H = -1100 //kcal/kg
Mmax = 10000 // kg (massa maxima que cabe no reator)


// EQUAÇÕES
function y = din(t, xi)
    M = xi(1) // M (massa no reator)
    Tr = xi(2) // Tr (temperatura no reator)
    if M >= Mmax then
        W = 0
    end
    y(1) = W
    y(2) = W*(Ti-Tr)/M + W*xo*(-delta_H)/(M*Cp) - U*A*(Tr-Tc)/(M*Cp)
endfunction


// ---------------------------------------- QUESTÃO 1 ----------------------------------------//

// AVALIANDO O COMPORTAMENTO DA MASSA NO REATOR (M), DA TEMPERATURA DO REATOR (Tr) E O CALOR TRANSFERIDO PARA A JAQUETA (Tc)

/*

REPOSTA: Analisando os resultados obtidos, foi possivel observar: 

    A massa no reator aumenta de forma constante devido ao fluxo mássico de entrada ser constante, em adição é possivel observar uma parada brusca que é devida ao limite mássico do reator.
    A temperatura no reator aumenta rapidamente a médida que a reação, exotermica, libera energia. Além disso, ela desacelera abruptamente assim que a energia liberada na reação se iguala a energia (Q) perdida para jaqueta.
    Ademais, é possivel observar que a transferência de energia do reator para a jaqueta é proporcional a temperatura do reator, além disso assim que atinge o estado de equilibrio ela se mantem constante até a parada de adição de massa. Por fim, ao passo que a transferência tende a zero a temperatura do reator se equipara a temperatura da jaqueta.

*/
xi = [1000; 25]
t = [0: 0.01: 140]
xf = ode(xi, t(1), t, din)
dQ_dt = U*A*(xf(2,:) - Tc)


// PLOTTING
scf(0)
clf()
subplot(3,1,1); plot(t, xf(1, :), "blue")
xtitle("Massa do reator", "$tempo (min)$", "$Massa (kg)$")
subplot(3,1,2); plot(t, xf(2, :), "red")
xtitle("Temperatura do reator", "$tempo (min)$", "$Temperatura (°C)$")
subplot(3,1,3); plot(t, dQ_dt, "m")
xtitle("Transferência de energia", "$tempo (min)$", "$Energia (kcal/min)$")



// ---------------------------------------- QUESTÃO 2 ----------------------------------------//

// PLOTTING

function plotando(t, xf, dQ_dt, cor, text)
    subplot(3,1,1); plot(t, xf(1, :), cor)
    xtitle("Massa do reator " + text, "$tempo (min)$", "$Massa (kg)$")
    subplot(3,1,2); plot(t, xf(2, :), cor)
    xtitle("Temperatura do reator " + text, "$tempo (min)$", "$Temperatura (°C)$")
    subplot(3,1,3); plot(t, dQ_dt, cor)
    xtitle("Transferência de energia " + text, "$tempo (min)$", "$Energia (kcal/min)$")
endfunction


// ANALISANDO A INFLUÊNCIA DA ÁREA

/*

REPOSTA: Analisando os resultados obtidos, foi possivel observar: 

    A área não causou nenhuma interferência na taxa de entrada de massa no reator, como era previsto devido a mesma ser constante.
    Com relação a temperatura do reator é possivel observar que quanto menor a área do reator maior será a temperatura máxima atingida pelo mesmo. Este fato se deve ao fato da maior área de transferência de energia para a jaqueta, o que aumenta a taxa de transferência de calor e consequentemente diminui a temperatura máxima do reator.
    Por ultimo, com relação da transferência de energia do reator, observa-se que a energia transferida aumenta conforme a área do reator aumenta, como era esperado pois uma maior área implica em maior área de transferência.

*/

scf(1); clf(1)
for A = 2:2:6
    cor = ["r", "b", "m"](A/2)
    xi = [1000; 25]
    t = [0: 1: 140]
    xf = ode(xi, t(1), t, din)
    dQ_dt = U*A*(xf(2,:) - Tc)
    plotando(t, xf, dQ_dt, cor, "(Analise da Área)")
end
subplot(3,1,1); legend(["A=2", "A=4", "A=6"])
subplot(3,1,2); legend(["A=2", "A=4", "A=6"])
subplot(3,1,3); legend(["A=2", "A=4", "A=6"])
A = 2
// ANALISANDO A INFLUÊNCIA DA TEMPERATURA DE ALIMENTAÇÃO

/*

REPOSTA: Analisando os resultados obtidos, foi possivel observar: 

    A temperatura de alimentação não causou nenhuma interferência na taxa de entrada de massa no reator, como era previsto devido a mesma ser constante.
    Com relação a temperatura do reator é possivel observar que quanto maior a temperatura de alimentação, maior a taxa de aumento de temperatura inicial e maior a temperatura de equilibrio do reator.
    Ademais, com relação da transferência de energia do reator, observa-se que a energia transferida aumenta conforme a temperatura de alimentação aumenta. Isso se deve ao deslocamento da temperatura de equilibrio de reator, sendo está maior ao passo que se aumenta a temperatura de alimentação.

*/


scf(2); clf(2)
for Ti = 25:25:75
    cor = ["r", "b", "m"](Ti/25)
    xi = [1000; 25]
    t = [0: 0.2: 140]
    xf = ode(xi, t(1), t, din)
    dQ_dt = U*A*(xf(2,:) - Tc)
    plotando(t, xf, dQ_dt, cor, "(Analise da temperatura de alimentação)")
end
subplot(3,1,1); legend(["Ti=25", "Ti=50", "Ti=75"])
subplot(3,1,2); legend(["Ti=25", "Ti=50", "Ti=75"])
subplot(3,1,3); legend(["Ti=25", "Ti=50", "Ti=75"])
Ti = 25

// ANALISANDO A INFLUÊNCIA DA COMPOSIÇÃO DE AMONIA NA ALIMENTAÇÃO

/*

REPOSTA: Analisando os resultados obtidos, foi possivel observar: 

    A concentração de amonia na alimentação não causou nenhuma interferência na taxa de entrada de massa, como era previsto, devido a mesma ser constante.
    Com relação a temperatura do reator é possivel observar que quanto maior a  concentração de amonia na alimentação maior a temperatura máxima do reator, isto se deve a maior energia liberada na conversão da amonia, pela reação exotermica, de modo que o equilibrio de energia liberada pela energia cedida na jaqueta seja deslocado.
    Paralelamente a isto, é possivel observar a maior transferência de energia do reator para jaqueta, como previsto devido ao fato do equilibro ter sido deslocado a maior energia liberada pela reação.
    
*/

scf(3); clf(3)
for xo = 0.25:0.25:0.75
    cor = ["r", "b", "m"](xo/0.25)
    xi = [1000; 25]
    t = [0: 0.4: 140]
    xf = ode(xi, t(1), t, din)
    dQ_dt = U*A*(xf(2,:) - Tc)
    plotando(t, xf, dQ_dt, cor, "(Composição de amônia na alimentação)")
end
subplot(3,1,1); legend(["xo=0.25", "xo=0.50", "xo=0.75"])
subplot(3,1,2); legend(["xo=0.25", "xo=0.50", "xo=0.75"])
subplot(3,1,3); legend(["xo=0.25", "xo=0.50", "xo=0.75"])
xo = 0.25

// ANALISANDO A INFLUÊNCIA DA TEMPERATURA DO FLUIDO REFRIGERANTE

/*

REPOSTA: Analisando os resultados obtidos, foi possivel observar: 

    A temperatura de fluido refrigerante não causou nenhuma interferência na taxa de entrada de massa, como era previsto, devido a mesma ser constante.
    Com relação a temperatura do reator é possivel observar que quanto maior a temperatura do fluido refrigerante maior a temperatura máxima do reator, isto se deve e taxa de troca termica reator-jaqueta, apesar da energia liberada na conversão da amonia se manter constante.
    Como afirmado acima, no gráfico da taxa de transferência de energia reator-jaqueta é possivel observar uma menor transferência de enrgia quanto maior a temperatura do fluido refrigerante.
    
*/
scf(4); clf(4)
for Tc = 25:25:75
    cor = ["r", "b", "m"](Tc/25)
    xi = [1000; 25]
    t = [0: 0.8: 140]
    xf = ode(xi, t(1), t, din)
    dQ_dt = U*A*(xf(2,:) - Tc)
    plotando(t, xf, dQ_dt, cor, "(Temperatura do fluido refrigerante)")
end
subplot(3,1,1); legend(["Tc=25", "Tc=50", "Tc=75"])
subplot(3,1,2); legend(["Tc=25", "Tc=50", "Tc=75"])
subplot(3,1,3); legend(["Tc=25", "Tc=50", "Tc=75"])














