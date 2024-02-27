//------------------------------------------------------------------------------
//                                DESCRIÇÃO
//------------------------------------------------------------------------------
//Autor: Isaac Miranda Camargos
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
function f=ee(x)
    X = x(1)
    P = x(2)
    S = x(3)
    u = uo*exp(-k1*P)*S/(ks + S)
    e = eo*exp(-k2*P)*S/(kLs + S)
    f(1) = (u - D)*X
    f(2) = e*X - D*P
    f(3) = D*(Sf-S) - u*X/Yx_s
endfunction



function J = jacobian(x)
    X = x(1)
    P = x(2)
    S = x(3)
    u = uo*exp(-k1*P)*S/(ks + S)
    e = eo*exp(-k2*P)*S/(kLs + S)
    J(1,1) = u - D
    J(1,2) = -k1*u*X
    J(1,3) = ( (ks + S)*uo*X*exp(-k1*P) - uo*S*exp(-k1*P)*X ) / ( (ks + S)^(2) )
    J(2,1) = e
    J(2,2) = -k2*e*X - D
    J(2,3) = ( (ks + S)*eo*X*exp(-k2*P) - eo*S*exp(-k2*P)*X ) / ( (ks + S)^(2) )
    J(3,1) = -u/Yx_s
    J(3,2) = -k1*u*X
    J(3,3) = -D*Sf - ( (ks + S)*uo*X*exp(-k1*P) - uo*S*exp(-k1*P)*X ) / ( (ks + S)^(2)*Yx_s )
endfunction

//------------------------------------------------------------------------------
//                              VARIAVEIS
//------------------------------------------------------------------------------
ks = 0.22
kLs = 0.44
k1 = 0.028
k2 = 0.015
uo = 0.408
eo = 1
Yx_s = 0.1
Sf = 20


//------------------------------------------------------------------------------
//                              PERGUNTA 1 e 2
//------------------------------------------------------------------------------
/* 

Abaixo estão plotados os pontos de equilibrio no diagrama de bifucação
 e classificados mediante sua estabilidade (X: estavel, 0: Instável). 

*/

for D = 0:0.05:1
    xi = [0;0;0] 
    [xf, yf, info] = fsolve(xi, ee)
    if info == 1 then
        scf(0)
        J = jacobian(xf)
        [autovetores, autovalores] = spec(J)
        printar = "Estavel"
        for i = 1:1:length(real(autovalores))
            if real(autovalores(i)) <= 0
                continue
            else
                printar = "Instavel"
                break
            end
        end    
        if printar == "Estavel"
            plot(D, xf(1), 'rx')
            plot(D, xf(2), 'bx')
            plot(D, xf(3), 'mx')
        elseif printar == "Instavel"
            plot(D, xf(1), 'ro')
            plot(D, xf(2), 'bo')
            plot(D, xf(3), 'mo')
        end
     end
end
xtitle("Plano de bifurcação", "Estado estacionário", "Parâmetro de bifurcação")
xgrid(1)
legend(["Enzima", "Produtos", "Substrato"], 1)

for D = 0:0.01:1
    xi = [1.9;2.9;0.079] 
    [xf, yf, info] = fsolve(xi, ee)
    if info == 1 then
        scf(0)
        J = jacobian(xf)
        [autovetores, autovalores] = spec(J)
        printar = "Estavel"
        for i = 1:1:length(real(autovalores))
            if real(autovalores(i)) <= 0
                continue
            else
                printar = "Instavel"
                break
            end
        end    
        if printar == "Estavel"
            plot(D, xf(1), 'rx')
            plot(D, xf(2), 'bx')
            plot(D, xf(3), 'mx')
        elseif printar == "Instavel"
            plot(D, xf(1), 'ro')
            plot(D, xf(2), 'bo')
            plot(D, xf(3), 'mo')
        end
        
        
     end
end


//------------------------------------------------------------------------------
//                              PERGUNTA 3
//------------------------------------------------------------------------------

/* 
Os pontos de bifurcação encontrado é D = 0.41, P = 0, X = 0, S = 20 P(0.41, 0, 0, 20).
Pois nesse ponto Os pontos de estados estacionários instáveis e estáveis se encontram.
*/


//------------------------------------------------------------------------------
//                              PERGUNTA 4
//------------------------------------------------------------------------------

/* 
Analisando o diagrama de bifurcação, é possivel concluir que a melhor faixa de operação
seria com D entre 0.3 e 0.35, pois dentro desta faixa o estado estacionário de produção
de produto é máximo, além disso ele é estável.

*/

//------------------------------------------------------------------------------
//                              PERGUNTA 5
//------------------------------------------------------------------------------

function f=din(t, x)
    X = x(1)
    P = x(2)
    S = x(3)
    u = uo*exp(-k1*P)*S/(ks + S)
    e = eo*exp(-k2*P)*S/(kLs + S)
    f(1) = (u - D)*X
    f(2) = e*X - D*P
    f(3) = D*(Sf-S) - u*X/Yx_s
endfunction


D = 0.33
xi = [2; 0; 20]
t = [0: 0.01: 30]
xf = ode(xi, t(1), t, din)


scf(1)
plot(t,xf(1,:),'r')
plot(t,xf(2,:),'b')
plot(t,xf(3,:),'m')
xtitle("Operação do reator com D=0.33", "Tempo [h]", "Concentração [g/L]]")
xgrid(1)
legend(["Enzima", "Produtos", "Substrato"], 1)

/* 

Avaliando o comportamento do sistema é possivel observar uma alta taxa de consumo de substrato e geração de produto no instante inicial, isso se deve a concentração de enzimas presentes no meio, está que também começa a aumentar. 

Porem, reduzida a quantidade de substrato presente, a concentração de produto diminui e a taxa de crescimento de enzimas e a taxa de morte de enzimas se equilibram, fazendo com que o sistem atinja o estado estacionário.

*/











