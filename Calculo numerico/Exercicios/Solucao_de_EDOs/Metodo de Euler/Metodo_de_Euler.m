clear
clc


### INPUTS

h = 0.1;

function y1=dy(x,y)
  y1 = 2.5 - 0.05*x;
endfunction
xi = 0; #Por onde vamos começar
xf = 0.3; #Até onde iremos discretizar
yy(1) = 10;
xx(1) = xi;
n = round((xf-xi)/h);


### METODO DE EULER

for i = 1:1:n
  xx(i+1) = xx(i) + h;
  yy(i+1) = yy(i) + h*dy(xx(i),yy(i));
endfor

plot(xx,yy)




