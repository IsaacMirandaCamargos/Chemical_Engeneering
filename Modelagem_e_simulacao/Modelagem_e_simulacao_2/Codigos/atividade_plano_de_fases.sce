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
//                              SISTEMAS DE EQUAÇÕES
//------------------------------------------------------------------------------

function f=no_proprio_instavel(t, x)
    f(1) = x(1) + x(2)
    f(2) = x(2)
endfunction

function f=espiral_foco_instavel(t, x)
    f(1) = x(1) + 2*x(2)
    f(2) = -2*x(1) + x(2)
endfunction

function f=no_central(t, x)
    f(1) = -x(1) - x(2)
    f(2) = 4*x(1) + x(2)
endfunction

function f=pendulo(t, x)
    f(1) = x(2)
    f(2) = -x(1) - x(2)
endfunction
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

t = 0:0.01:20
for x1 = -10:2.5:10
    for x2 = -10:2.5:10
        xinicial=[x1;x2]
        x = x1_x2(t, xinicial, no_proprio_instavel, 0, "Nó impróprio instável")
        x1_t(t, x); x2_t(t, x)
        x = x1_x2(t, xinicial, espiral_foco_instavel, 1, "Espiral foco instável")
        x1_t(t, x); x2_t(t, x)
        x = x1_x2(t, xinicial, no_central, 2, "Nó central")
        x1_t(t, x); x2_t(t, x)
        x = x1_x2(t, xinicial, pendulo, 3, "pendulo")
        x1_t(t, x); x2_t(t, x)
    end
end



//------------------------------------------------------------------------------
//                                CAMPO VETORIAL
//------------------------------------------------------------------------------

x1 = -10:2.5:10; x2= -10:2.5:10
scf(0)
subplot(3,1,1)
fchamp(no_proprio_instavel, t(1), x1,x2)
replot([-10,-10,10,10])

scf(1)
subplot(3,1,1)
fchamp(espiral_foco_instavel, t(1), x1,x2)
replot([-10,-10,10,10])

scf(2)
subplot(3,1,1)
fchamp(no_central, t(1), x1,x2)
replot([-10,-10,10,10])

scf(3)
subplot(3,1,1)
fchamp(pendulo, t(1), x1,x2)
replot([-10,-10,10,10])
//------------------------------------------------------------------------------
//                              Solução do sistema (estado dinâmico)
//------------------------------------------------------------------------------

