clear
clc

# ENCONTRAR A RAIZ DA FUNÇÃO


xi = 501;
eps = 0.000001;
p = 0.0000001;


function y = f(x);
  Ti = 533.15;
  y = (29.747492*(x- Ti)) + (0.01255414*((x^2) - (Ti^2))) - (-1546404/(Ti - x)) - 37218;
endfunction

inclinacao = ( f(xi+p) - f(xi) ) / p;
xf = xi - f(xi)/inclinacao;
contador = 1



while abs(xf-xi)/xf > eps
  contador += 1
  xi = xf;
  inclinacao = ( f(xi+p) - f(xi) ) / p;
  xf = xi - f(xi)/inclinacao;
endwhile

raiz = xf;

disp("A raiz é")
disp(raiz)