//------------------------------------------------------------------------------
//                                DESCRIÇÃO
//------------------------------------------------------------------------------
//Estudo de funções do Scilab
//Exemplo 1: Reator CSTR isotérmico com reação em série paralelo pag. 17 
//Autor:Nádia 
//Data:04/01/2023
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
    Ca=x(1)
    Cb=x(2)
    Cx=x(3)
    Cy=x(4)
    Cz=x(5)
    f(1)=1/tau*(Ca0-Ca)-k1*Ca*Cb
    f(2)=1/tau*(Cb0-Cb)-k1*Ca*Cb-k2*Cb*Cx-k3*Cb*Cy
    f(3)=1/tau*(Cx0-Cx)+k1*Ca*Cb-k2*Cb*Cy
    f(4)=1/tau*(Cy0-Cy)+k2*Cb*Cx-k3*Cb*Cy
    f(5)=1/tau*(Cz0-Cz)+k3*Cb*Cy
endfunction


function A=matrizA(xs)
    Cas = xs(1); Cbs = xs(2); Cxs = xs(3); Cys = xs(4); Czs = xs(5)
    A(1,1) = -1/tau - k1*Cbs
    A(1,2) = -k1*Cas
    A(1,3) = 0
    A(1,4) = 0
    A(1,5) = 0
    A(2,1) = -k1*Cbs
    A(2,2) = -1/tau - k1*Cas - k2*Cxs - k3*Cys
    A(2,3) = -k2*Cbs
    A(2,4) = -k3*Cbs
    A(2,5) = 0
    A(3,1) = k1*Cbs
    A(3,2) = k1*Cas-k2*Cys
    A(3,3) = -1/tau
    A(3,4) = -k2*Cbs
    A(3,5) = 0
    A(4,1) = 0
    A(4,2) = k2*Cxs-k3*Cys
    A(4,3) = k2*Cbs
    A(4,4) = -1/tau-k3*Cbs
    A(4,5) = 0
    A(5,1) = 0
    A(5,2) = k3*Cys
    A(5,3) = 0
    A(5,4) = k3*Cbs
    A(5,5) = -1/tau
endfunction

function dxbar_dt=din_linear(t, xdesvio)
    dxbar_dt = A*xdesvio
endfunction

function f=din(t,x)
    Ca=x(1)
    Cb=x(2)
    Cx=x(3)
    Cy=x(4)
    Cz=x(5)
    f(1)=1/tau*(Ca0-Ca)-k1*Ca*Cb
    f(2)=1/tau*(Cb0-Cb)-k1*Ca*Cb-k2*Cb*Cx-k3*Cb*Cy
    f(3)=1/tau*(Cx0-Cx)+k1*Ca*Cb-k2*Cb*Cy
    f(4)=1/tau*(Cy0-Cy)+k2*Cb*Cx-k3*Cb*Cy
    f(5)=1/tau*(Cz0-Cz)+k3*Cb*Cy
endfunction



//------------------------------------------------------------------------------
//                              Entrada de dados
//------------------------------------------------------------------------------
Ca0=0.4//kmol/m^3
Cb0=0.6//kmol/m^3
Cx0=0
Cy0=0   
Cz0=0
k1=0.0005//m^3/kmol.s
k2=0.005//m^3/kmol.s
k3=0.02//m^3/kmol.s
tau=5000//s
//------------------------------------------------------------------------------
//                              Solução da EDO (estado estacionário)
//------------------------------------------------------------------------------
xchute=[0.1;0.1;0.3;0.2;0.2]
[sol,v,info]=fsolve(xchute, ee)
if info==1 then
    disp('Solução:')
    disp(sol)
else
    disp('Tente novamente!')
end

//------------------------------------------------------------------------------
//                              Solução do sistema (estado dinâmico)
//------------------------------------------------------------------------------
xinicial=[Ca0;Cb0;Cx0;Cy0;Cz0]
t = 0:0.01:10000
x=ode(xinicial,t(1),t,din)

//------------------------------------------------------------------------------
//                              Questão 1: Printando e respostas
//------------------------------------------------------------------------------

/*
            Resposta 1(Discutindo os resultados): A partir dos resultados obtidos é possivel observar um rápido decrescimento nas concentrações das espécies alimentadas, A e B, seguido da estabilização no ponto estacionário. Contudo, após um intervalo de tempo é visualizado um aumento na concentração de A, isso ocorre devido as reações parelelas que consomem o B em grande quantidade e minimizam a sua disponibilidade para a reação de consumo de A.

Com relação as espécies X, Y e Z, suas concentrações aumentam rapidamente com no ínicio da operação, sendo as maiores velocidades iniciais respectivamente de X, seguido de Y e, por ultimo, Z. Esse fenômeno ocorre devido as reações envolvidos, sendo: o produto da reação 1 é reagente na reação 2; o produto da reação 2 é reagente da reação 3; e também as constantes cinéticas da reação, que são respectivamente maiores em: Z, Y e X, o que não permite acumulo de reagentes.

            Resposta 1(Avalie a influência da concentrações de alimentação): A concentração de alimentação de A está diretamente ligada a concentração de A dentro do reator no estado estacionário, após a produção dos reagentes das reações subsequentes. Desse modo, quanto maior a concentração de A na alimentação, maior a concentração de A no estado estacionário.

Ademais, a concentração de alimentação de B está diretamente ligada a concentação dos espécimes A, X, Y e Z no estado de equilibrio, este fato se deve a presente de B como reagente em todas as equações, ou seja, ele se torna o reagente limitante quando em menor quantidade ou excessivo em maior quantidade, dependendo apenas das constantes cinéticas e da concentração dos outros reagentes para ser consumido.

            Resposta 1(Avalie a influência do tempo de residência): O tempo de residência influência diretamente nas concentrações de A, B, X, Y e Z dentro do reator, ou seja, o tempo de residência implica na quantidade consumida de reagentes e produtos formados até sua consequente saída do reator. Em especifico das espécies A, B e Z, um alto tempo de residência permite que elas atinjam o estado de equilibrio dentro do reator e sua concentração se mantenha constante. Contudo, para baixos tempos de residência os espécimes não possuem tempo de reator o suficiente para atingirem o estado de equilibro e saem antes que ele ocorra.

*/
scf(0)
clf()
subplot(2,1,1),plot(t,x(1,:),'r')
xtitle('Concentração de A','$t[s]$','$C_A[kmol/m^3]$')
subplot(2,1,2),plot(t,x(2,:),'b')
xtitle('Concentração de B','$t[s]$','$C_B[kmol/m^3]$')

scf(1)
clf()
subplot(3,1,1),plot(t,x(3,:),'m')
xtitle('Concentração de X','$t[s]$','$C_X[kmol/m^3]$')
subplot(3,1,2),plot(t,x(4,:),'y')
xtitle('Concentração de Y','$t[s]$','$C_y[kmol/m^3]$')
subplot(3,1,3),plot(t,x(5,:),'g')
xtitle('Concentração de Z','$t[s]$','$C_Z[kmol/m^3]$')

//------------------------------------------------------------------------------
//                              Questão 2: Linearização do modelo
//------------------------------------------------------------------------------
/*
Resposta 2: A classificação do modelo foi respondida a lápis e a foto será enviada em anexo. Já a linearização do modelo está desenvolvida abaixo.
*/

A = matrizA(sol)
J = numderivative(ee,sol)
xdesvio = xinicial - sol
t = 0:0.01:10000
x_lin = ode(xdesvio,t(1),t,din_linear)
autovalores = spec(J)
disp(autovalores)

//------------------------------------------------------------------------------
//                              Questão 3: Printando e respostas
//------------------------------------------------------------------------------
/*
Resposta 3: Comparando o modelo não linear e o modelo linear é possivel concluir que ambos os modelos divergem na maioria dos pontos fora do estado estacionário, porem convergem no ponto de estado estacionário, o que era o resultado esperado.

Além disso, pela teoria de estabilidade (BIBO) "Se entradas limitadas provocam sempre saídas limitadas, para t -> ∞ , então o sistema é dito estável. Caso contrário será instável." e por meio de inumeros testes foi possivel concluir que o modelo sempre convergia para pontos de estados estacionário, mesmo que estes fossem distintos entre si.

Por fim, através da analise dos autovalores é possivel observar 3 autovalores reais menores que zero e 2 autovalores imaginarios, onde sua parte real é menor que zero, reforçando o argumento da estabilidade do modelo.
*/

scf(2)
clf()
subplot(2,1,1),plot(t,x(1,:),'r')
subplot(2,1,1),plot(t,x_lin(1,:) + sol(1,:),'r-.')
xtitle('Concentração de A','$t[s]$','$C_A[kmol/m^3]$')
subplot(2,1,2),plot(t,x(2,:),'b')
subplot(2,1,2),plot(t,x_lin(2,:) + sol(2,:),'b-.')
xtitle('Concentração de B','$t[s]$','$C_B[kmol/m^3]$')

scf(3)
clf()
subplot(3,1,1),plot(t,x(3,:),'m')
subplot(3,1,1),plot(t,x_lin(3,:) + sol(3,:),'m-.')
xtitle('Concentração de X','$t[s]$','$C_X[kmol/m^3]$')
subplot(3,1,2),plot(t,x(4,:),'y')
subplot(3,1,2),plot(t,x_lin(4,:) + sol(4,:),'y-.')
xtitle('Concentração de Y','$t[s]$','$C_y[kmol/m^3]$')
subplot(3,1,3),plot(t,x(5,:),'g')
subplot(3,1,3),plot(t,x_lin(5,:) + sol(5,:),'g-.')
xtitle('Concentração de Z','$t[s]$','$C_Z[kmol/m^3]$')

//----------->Fim do programa
disp('***FIM***')
