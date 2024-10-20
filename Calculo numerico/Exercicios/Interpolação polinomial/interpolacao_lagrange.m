clear
clc

%Valores tabelados
x = 0:0.2:0.4;
y = [4 3.84 3.76];
n = length(x);%número de pontos tabelados (n+1)

%Valor x a ser interpolado
xx = min(x):0.01:max(x);
np = length(xx);%número de pontos a serem interpolados

%Cálculo e substituição no polinomio interpolador
for i = 1:1:np
  yy(i) = 0;%coordenada y do valor interpolado
  for k = 1:1:n
    Lk = 1;
    for j = 1:1:n
      if k~=j
        Lk = Lk*(xx(i) - x(j)) / (x(k)-x(j));
      endif
    endfor
    yy(i) = yy(i) + y(k)*Lk;
  endfor
endfor

plot(x,y,'o')
hold
plot(xx,yy)
