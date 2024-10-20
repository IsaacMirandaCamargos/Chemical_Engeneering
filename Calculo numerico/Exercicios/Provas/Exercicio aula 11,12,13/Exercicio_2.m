clear
format long
clc

hi = 1;
eps = 0.000000001;
p = 0.0000000001;

function y = f(x)
  r = 1;
  peso_h20 = 10000;
  peso_esfera = 2000;
  volume = (4*pi*r^3)/3;
  y = ((pi*x^2)/3)*(3*r-x)-volume*(1-peso_esfera/peso_h20);
#  y = ((pi*x^2)/3)*(3*r-x) - 3.351032163829113
endfunction


inclinacao = (f(hi+p)-f(hi))/p;
hf = hi - f(hi)/inclinacao;
contador = 1;

while abs(hf-hi) > eps;
  contador += 1;
  hi = hf;
  inclinacao = ( f(hi+p) - f(hi) )/p;
  hf = hi - f(hi)/inclinacao;
endwhile


disp("A altura acima da agua é")
disp(hf)
disp(contador)
