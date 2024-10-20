clear
clc

##Considerando os pontos:
## x = [ 0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5]
## y = [ 1.5, 0.75, 0.5, 0.75, 1.5, 2.75, 5.5, 6.75 ]


# INPUTS

x = [ 0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5];
y = [ 1.5, 0.75, 0.5, 0.75, 1.5, 2.75, 5.5, 6.75 ];

# CALCULANDO A AREA ABAIXO DOS PONTOS

area = 0;

for i = 1:1:length(y)-1
  area = area + (y(i) + y(i+1))*(x(i+1)-x(i))/2;
endfor

# CALCULANDO A AREA PELA REGRA DOS TRAPEZIOS

n = length(y);
h = x(2) - x(1);
areaT = (h/2)*(y(1) + 2*(sum(y(2:n-1))) + y(n));


disp(areaT)
disp(area)
