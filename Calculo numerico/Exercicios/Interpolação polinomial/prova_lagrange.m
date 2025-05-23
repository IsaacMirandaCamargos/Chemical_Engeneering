clear
clc

%Valores tabelados
x = [0	3.0961	6.6026	9.1318	10.5115	11.3510];
y = [0	2.6871	6.8232	11.5050	15.6985	19.9948];
n = length(x);%n�mero de pontos tabelados (n+1)

%Valor x a ser interpolado
xx = min(x):0.01:max(x);
np = length(xx);%n�mero de pontos a serem interpolados

%C�lculo e substitui��o no polinomio interpolador
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