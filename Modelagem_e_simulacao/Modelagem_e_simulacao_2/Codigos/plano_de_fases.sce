//------------------------------------------------------------------------------
//                                DESCRIÇÃO
//------------------------------------------------------------------------------
//Estudo de funções do Scilab
//Exemplo 1: Planos de fases
//Autor:Isaac
//Data:17/02/2023
//------------------------------------------------------------------------------
//                             PRÉ-PROCESSAMENTO
//------------------------------------------------------------------------------
clc
clear
mode(-1)
//------------------------------------------------------------------------------
//                              AUTOVALORES E AUTOVETORES
//------------------------------------------------------------------------------

function f=no_atrator(t, x)
    f(1) = -x(1)
    f(2) = -4*x(2)
endfunction

function f=no_instavel(t, x)
    f(1) = x(1)
    f(2) = 4*x(2)
endfunction


A = [-1, 0; 0, -4]
[autovetores, autovalores] = spec(A)
disp(autovalores)
disp(autovetores)

//------------------------------------------------------------------------------
//               PLANO DE FASES PARA DIFERENTES CONDIÇÕES INICIAIS
//------------------------------------------------------------------------------

function f=x1_x2(t, xinicial, funcao, tela, nome)
    x=ode(xinicial,t(1),t,funcao)
    scf(tela)
    subplot(3,1,1); plot(x(1,:), x(2,:),'b')
    xtitle(nome, "$x_1$", "$x_2$")
    xgrid(1)
    f=x
endfunction

function x1_t(t, x)
    subplot(3,1,2); plot(t, x(1,:),'r')
    xtitle("$x_1 \ variando \ com \ o \ tempo$", "$t$", "$x_1$")
    xgrid(1)
endfunction

function x2_t(t, x)
    subplot(3,1,3); plot(t, x(2,:),'g')
    xtitle("$x_2 \ variando \ com \ o \ tempo$", "$t$", "$x_2$")
    xgrid(1)
endfunction

t = 0:0.1:5
for x1 = -5:1:5
    for x2 = -5:1:5
        xinicial=[x1;x2]
        x = x1_x2(t, xinicial, no_atrator, 0, "Nó atrator")
        x1_t(t, x)
        x2_t(t, x)
        x = x1_x2(t, xinicial, no_instavel, 1, "Nó instável")
        x1_t(t, x)
        x2_t(t, x)
    end
end



//------------------------------------------------------------------------------
//                                CAMPO VETORIAL
//------------------------------------------------------------------------------

x1 = -5:1:5; x2= -5:1:5
scf(0)
subplot(3,1,1)
fchamp(no_atrator, t(1), x1,x2)

scf(1)
subplot(3,1,1)
fchamp(no_instavel, t(1), x1,x2)
replot([-5,-5,5,5])
//------------------------------------------------------------------------------
//                              Solução do sistema (estado dinâmico)
//------------------------------------------------------------------------------

