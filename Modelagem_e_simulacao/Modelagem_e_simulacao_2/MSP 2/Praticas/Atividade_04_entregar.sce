// Plano de fase
// Nicole Maia Argondizzi
//19/07/2023

clc
clear
mode(-1)

function f=no_improprio_estavel(t,x)
    f(1)=-x(1)+x(2)
    f(2)=-x(2)
endfunction


function f=espiral_foco_instavel(t,x)
    f(1)= x(1) + 2* x(2)
    f(2)= -2*x(1) + x(2)
endfunction

function f=no_central(t,x)
    f(1)= -x(1) - x(2)
    f(2)= 4*x(1) + x(2)
endfunction

function f=pendulo_linear(t,x)
    f(1)= -x(1) - x(2)
    f(2)= 4*x(1) + x(2)
endfunction


// Tempo
t=0:0.1:10

for i=[-10:3:10]
    for j=[-5:2:5]
        xinicial=[i;j]
        
        // Nó Impróprio Estável
        x_no_improprio_estavel=ode(xinicial,t(1),t,no_improprio_estavel)
        scf(0)
        plot(x_no_improprio_estavel(1,:),x_no_improprio_estavel(2,:),'r')
        plot(0,0,'ko')
        xtitle('no_improprio_estavel','X_1','X_2')
        
        scf(1)
        plot(t,x_no_improprio_estavel(1,:),'r')
        xtitle('no_improprio_estavel','t','X_1')
        
        // Nó Espiral Instável
        x_espiral_foco_instavel=ode(xinicial,t(1),t,espiral_foco_instavel)
        scf(2)
        plot(x_espiral_foco_instavel(1,:),x_espiral_foco_instavel(2,:),'b')
        plot(0,0,'ko')
        xtitle('x_espiral_foco_instavel','X_1','X_2')
        
        scf(3)
        plot(t,x_espiral_foco_instavel(1,:),'b')
        xtitle('x_espiral_foco_instavel','t','X_1')


        // Nó Central
        x_no_central=ode(xinicial,t(1),t,no_central)
        scf(4)
        plot(x_no_central(1,:),x_no_central(2,:),'m')
        plot(0,0,'ko')
        xtitle('x_no_central','X_1','X_2')
        
        scf(5)
        plot(t,x_no_central(1,:),'m')
        xtitle('x_no_central','t','X_1')
        
        // Pendulo Linear
        x_pendulo_linear=ode(xinicial,t(1),t,pendulo_linear)
        scf(6)
        plot(x_pendulo_linear(1,:),x_pendulo_linear(2,:),'y')
        plot(0,0,'ko')
        xtitle('x_pendulo_linear','X_1','X_2')
        
        scf(7)
        plot(t,x_pendulo_linear(1,:),'y')
        xtitle('x_pendulo_linear','t','X_1')
        
    end
end

// Criando limite para setas dentro da janela gráfica
xf=-10:1:10
yf=-10:1:10

xfi=-15:5:15
yfi=-30:5:30

// Nó Impróprio Estável
scf(0)
fchamp(no_improprio_estavel,t(1),xf,yf)

scf(2)
fchamp(espiral_foco_instavel,t(1),xf,yf)
replot([-10,-10,10,10])

scf(4)
fchamp(no_central,t(1),xfi,yfi)

scf(6)
fchamp(pendulo_linear,t(1),xfi,yfi)

// O gráfico do pendulo tem tendencia ao do nó central, é estável e espiral
