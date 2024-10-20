clear
clc


# Duas escadas, uma de 20m e outra de 30m de comprimento, apoiam-se em
# edificios frontais a uma avenida.
# Se o ponto no qual as escadas se cruzam esta a 8 metros de altura do
# solo, então determine a largura da avenida.

# Encontre a raiz do polinomio x^4 - 16x^3 +500x^2 - 8000x + 32000 = 0

xi = 15;
eps = 0.00001;

function y = f(x)
  y = x^4 - 16*x^3 + 500*x^2 - 8000*x + 32000;
endfunction

function y2 = f2(x)
  y2 = 4*x^3 - 48*x^2 + 1000*x - 8000;
endfunction

xf = xi - f(xi)/f2(xi);

while abs(xi-xf)> eps
  xi = xf;
  xf = xi - f(xi)/f2(xi);
endwhile


raiz = xf;
disp("A raiz é")
disp(raiz)

largura = sqrt(400-raiz^2);
disp("A largura da avenida é")
disp(largura)

  