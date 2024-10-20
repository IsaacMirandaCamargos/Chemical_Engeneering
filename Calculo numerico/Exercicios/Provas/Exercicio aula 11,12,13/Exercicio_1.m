clear
format long
clc




ti = 290;
eps = 0.000001;
p = 0.0000001;

function y = f(t)
 u = 15;  ##[N/m]
 S = 33;  ##[m]
 L = 30;  ##[m]
 y = (2*t/u)*(sinh((u*L)/(2*t))) - S;
endfunction

function y = barriga(t)
 u = 15;  ##[N/m]
 S = 33;  ##[m]
 L = 30;  ##[m]
 y = (t/u)*(cosh((u*L)/(2*t)) - 1);
endfunction

# INCLINAÇÃO

m = (f(ti+p)-f(ti))/p;

# PRIMEIRA INTERAÇÃO (Ponto onde a reta tangente cruza o eixo x)

tf = ti - f(ti)/m;
contador = 1;

while abs(tf-ti) > eps;
  contador += 1;
  ti = tf;
  m = (f(ti+p)-f(ti))/p;
  tf = ti - f(ti)/m;
endwhile

# A TRAÇÃO É

disp("A tração é")
disp(tf)

# A BARRIGA FORMADA É

disp("A barriga é")
disp(barriga(tf))
disp(contador)



