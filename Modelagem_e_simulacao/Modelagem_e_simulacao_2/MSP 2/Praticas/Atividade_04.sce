// Plano de fase
// Nicole Maia Argondizzi
//19/07/2023

clc
clear
mode(-1)

function f=no_atrator(t,x)
    f(1)=-x(1)
    f(2)=-4*x(2)
endfunction

function f=no_instavel(t,x)
    f(1)=x(1)
    f(2)=4*x(2)
endfunction

// Programa principal

//A=[-1,0;0,-4]
//[L,V]=spec(A)

//disp("Autovetor",L)
//disp("Autovalor",V)

// Criando limite para setas dentro da janela gráfica
xf=-10:3:10
yf=-10:3:10

// Tempo
t=0:0.1:10

for i=[-10:3:10]
    for j=[-5:2:5]
        xinicial=[i;j]
        x_no_atrator=ode(xinicial,t(1),t,no_atrator)
        
        scf(0)
        plot(x_no_atrator(1,:),x_no_atrator(2,:),'r')
        plot(0,0,'ko')
        fchamp(no_atrator,t(1),xf,yf)
        xtitle('Nó Atrator','X_1','X_2')
        
        scf(1)
        plot(t,x_no_atrator(1,:),'r')
        xtitle('Nó Atrator','t','X_1')
        
        x_no_instavel=ode(xinicial,t(1),t,no_instavel)
        
        scf(2)
        plot(x_no_instavel(1,:),x_no_instavel(2,:),'b')
        plot(0,0,'ko')
        fchamp(no_instavel,t(1),xf,yf)
        replot([-10,-10,10,10])
        xtitle('Nó Instável','X_1','X_2')
        
        scf(3)
        plot(t,x_no_instavel(1,:),'r')
        xtitle('Nó Instável','t','X_1')
        
    end
end








