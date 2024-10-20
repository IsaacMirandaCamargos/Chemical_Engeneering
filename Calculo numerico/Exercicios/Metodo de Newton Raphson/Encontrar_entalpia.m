clear
clc

# CALCULAR INTEGRAL DO CP

# COEFICIENTES:

R = 8.314;
a = -7.663;
b = 10.815*10^-3;
c = -3.45*10^-6;
d = -0.135*10^5;


function y = f(ti, tf, a, b, c, d)
  p1 = a*(tf-ti) + b*(tf^2-ti^2)/2;
  p2 = c*(tf^3-ti^3)/3 - d/(tf-ti);
  y = p1 + p2;
endfunction

resposta = f(298, 1073, a, b, c, d)
