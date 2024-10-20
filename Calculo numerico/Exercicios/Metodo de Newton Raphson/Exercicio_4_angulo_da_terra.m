clear
format long
clc

# Encontre a raiz da equa��o 
# tg(tetha/2) = sin(alfa)*cos(alfa) / ( gR/v^2 - cos^2(alfa) )
# theta = 80�     v = 8840 m/s

# chute inicial angulo alfa varia de 0 at� 90




xi = deg2rad(input("> "));
eps = 0.0000000000000001;
p = 0.000000000000001;

# fun��o
function y = f(x)
  v = 8840;
  R = 6371000;
  g = 9.81;
  theta = deg2rad(80);    #graus
  y = (sin(x)*cos(x)) / ( g*R/v^2 - (cos(x))^2 ) - tan(theta/2);
endfunction



# Inclina��o
m = (f(xi+p)-f(xi))/p;

# Intera��o
xf = xi - f(xi)/m;
contador = 1;


while abs(xf-xi) > eps
  contador += 1;
  xi = xf;
  m = (f(xi+p)-f(xi))/p;
  xf = xi - f(xi)/m;
endwhile

# Resultado
angulo = xf;
disp("Para acertar o alvo � necessario lan�ar o projetil com angulo de ")
disp(angulo)
disp(contador)
