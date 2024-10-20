clear
clc

# Primeiro iremos receber os dados de pontos

x = 0:0.2:0.4;
y = [4, 3.84, 3.76];

numero_de_pontos = length(x);
n = numero_de_pontos - 1;

# Montando o vetor b

b = y';

# Montando matriz A

v1 = x';
A = [v1.^0];
for i = 1:1:n
  A = [A, v1.^i];
endfor

# Montando matriz A, segunda format

v2 = x';
for j = 1:1:numero_de_pontos
  S(:,j) = v2.^(j-1);
endfor

# Encontrando a solução do sistema, coeficientes do polinomio

a = A\b;

# Definindo polinomio interpolador

function y = p(x,vetor)
  n = length(vetor);
  for i = 1:1:n
    vetor(i) = vetor(i)*x^(i-1);
  endfor
  y = sum(vetor);
endfunction

# Definindo polinomio interpolador de outra forma

a_2 = flip(a);
xx = min(x):0.01:max(x);
yy = polyval(a_2,xx);

plot(x,y,"o")
hold on
plot(xx,yy)












