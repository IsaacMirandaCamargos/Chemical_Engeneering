clear



# Use o m�todo de Newton-Raphson para calcular a raiz positiva da fun��o
# F(x) = 4cos(x) - e^x at� que o error relativo seja inferior � precis�o
# eps < 0,01.

xi = 1;
eps = 0.000001;
p = 0.0000000001;


function y = f(x);
  y = 4*cos(x)-exp(x);
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

disp("A raiz �")
disp(raiz)
