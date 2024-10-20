clear
format long
clc

# Encontre a raiz da função




xi = 40;
eps = 0.000001;
p = 0.000001;

# função
function y = f(x)
  
  # Reynolds
  p = 1000; # kg/m3
  d = 0.0762; # m
  u = 1.002*10^(-3); # Pa.s
  Re = p*x*d/u;
  
  # Fator de atrito
  r = 0.0015*10^(-3); # m #Rugosidade
  t1 = (r/(d*3.7))^(1.11);
  t2 = (6.9/Re);
  denominador = -1.8*log10(t1+t2);
  Fd = (1/denominador)^(2); # Fator de atrito

  # Função para encontrar solução
  y = x - (20.14/(37.73*Fd + 0.0509))^(1/2);
endfunction



# Inclinação
m = (f(xi+p)-f(xi))/p;

# Interação
xf = xi - f(xi)/m;
contador = 1;


while abs(xf-xi) > eps
  contador += 1;
  xi = xf;
  m = (f(xi+p)-f(xi))/p;
  xf = xi - f(xi)/m;
endwhile

# Resultado
raiz = xf;
disp("A raiz é")
disp(raiz)
disp(contador)
