clear
clc

## CONSIDERANDO QUE A CONCENTRAÇÃO DE UM COMPONENTE É DEFINIDA PELA
## EDO ABAIXO:

## dy = k(a-y)(b-y)
## k = 0.01
## a = 70 milimols/Litro
## b = 50 milimols/Litro
## Tempo varia de 0 até 2

### INPUTS

h = 5;
xi = 0; #Por onde vamos começar
xf = 10; #Até onde iremos discretizar
x = xi:h:xf;
y(1) = 0;
n = length(x);

### DERIVADA

function y1=dy(x,y)
  k = 0.01;
  a = 70;
  b = 50;
  y1 = k*(a-y)*(b-y);
endfunction

### METODO DE EULER

for i = 1:1:n-1
  y(i+1) = y(i) + h*dy(x(i),y(i));
endfor

### METODO RUNGE KUTTA QUARTA ORDEM
xx = x;
yy(i) = y(i);

for i = 1:1:n-1
  k1 = h*dy(xx(i),yy(i));
  k2 = h*dy(xx(i) + h/2, yy(i) + k1/2);
  k3 = h*dy(xx(i) + h/2, yy(i) + k2/2);
  k4 = h*dy(xx(i) + h, yy(i) + k3);
  soma = (1/6)*(k1 + 2*k2 + 2*k3 + k4);
  yy(i+1) = yy(i) + soma;
endfor


### SOLUCAO ANALITICA DO PROBLEMA DE PROJETO

t = x;
y_exato = 10*tanh(-0.1*t + 10*atanh(-6)/10) + 60;

### PLOTANDO GRAFICOS

plot(x,y) # METODO EULER
hold
plot(t,y_exato) # METODO ANALITICO
plot(xx,yy,"o") # METODO RUNGE-KUTTA

legend("Numerica","Analitica","Runge_Kutta")