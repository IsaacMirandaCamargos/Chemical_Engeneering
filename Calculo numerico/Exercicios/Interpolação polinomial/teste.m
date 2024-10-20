clear
clc

%Valores tabelados
x = 0:0.2:0.4;
y = [4 3.84 3.76];
n = length(x);%número de pontos tabelados (n+1)

%Valor x a ser interpolado
xx = min(x):0.05:max(x);
np = length(xx);%número de pontos a serem interpolados

%Montando matriz de polinomio de lagrange

for i = 1:1:np
  M = [];
  for h = 1:1:n
    L = [];
    for j = 1:1:n
      numerador = xx(i) - x(j);
      denominador = x(h) - x(j);
      if demoninador != 0;
        L(j,:) = numerador/demoninador;
      endif
    endfor
  endfor
  M(h,:) = prod(L);
  yy(:,i) = y*M;
endfor

yy = y*M;
plot(x,y,"o")
hold on
plot(xx,yy)

