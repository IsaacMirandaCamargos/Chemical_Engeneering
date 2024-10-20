clear
clc


# Use o método de Newton-Raphson para calcular a raiz positiva da função
# F(x) = 4cos(x) - e^x até que o error relativo seja inferior à precisão
# eps < 0,01.

xi = 1;
eps = 0.01;

function y = f(x);
  y = 4*cos(x)-exp(x);
endfunction


function y_2 = f2(x);
  y_2 = -4*sin(x)-exp(x);
endfunction



xf = xi - f(xi)/f2(xi);
contador = 1



while abs(xf-xi)/xf > eps
  contador += 1
  xi = xf;
  xf = xi - f(xi)/f2(xi);
endwhile

raiz = xf;

disp("A raiz é")
disp(raiz)
