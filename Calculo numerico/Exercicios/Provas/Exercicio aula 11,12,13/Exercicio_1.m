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

# INCLINA��O

m = (f(ti+p)-f(ti))/p;

# PRIMEIRA INTERA��O (Ponto onde a reta tangente cruza o eixo x)

tf = ti - f(ti)/m;
contador = 1;

while abs(tf-ti) > eps;
  contador += 1;
  ti = tf;
  m = (f(ti+p)-f(ti))/p;
  tf = ti - f(ti)/m;
endwhile

# A TRA��O �

disp("A tra��o �")
disp(tf)

# A BARRIGA FORMADA �

disp("A barriga �")
disp(barriga(tf))
disp(contador)



