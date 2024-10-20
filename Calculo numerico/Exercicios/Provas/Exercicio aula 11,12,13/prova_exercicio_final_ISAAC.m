clear
format long
clc

# Fração molar varia de 0 até 1

xi = 0.7;
eps = 1e-7;
p = 1e-7;

function y = f(x)
  pt = 3;
  K = 0.05;
  y = (x/(1-x))*(sqrt((2*pt)/(2+x))) - K;
endfunction

m = ( f(xi+p) - f(xi) )/p;
xf = xi - f(xi)/m;
contador = 1;

while abs(xf-xi) > eps
  contador += 1;
  xi = xf;
  m = ( f(xi+p) - f(xi) )/p;
  xf = xi - f(xi)/m;
endwhile

raiz = xf;

disp("A raiz é")
disp(raiz)

## Professor caso o senhor esteja lendo aqui, tire o cometario
## das duas linhas abaixo para ver a cagada, (achei a raiz perfeita).

disp(f(raiz))
disp(contador)