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

h = 0.0001;

function y1=dy(x,y)
  k = 0.01;
  a = 70;
  b = 50;
  y1 = k*(a-y)*(b-y);
endfunction
xi = 0; #Por onde vamos começar
xf = 10; #Até onde iremos discretizar
yy(1) = 0;
xx(1) = xi;
n = round((xf-xi)/h);


### METODO DE EULER

for i = 1:1:n
  xx(i+1) = xx(i) + h;
  yy(i+1) = yy(i) + h*dy(xx(i),yy(i));
endfor

plot(xx,yy)

### SOLUCAO ANALITICA DO PROBLEMA DE PROJETO

t = xi:h:xf;
y_exato = 10*tanh(-0.1*t+10*atanh(-6)/10)+60;
hold
plot(t,y_exato)

legend("Numerica","Analitica")