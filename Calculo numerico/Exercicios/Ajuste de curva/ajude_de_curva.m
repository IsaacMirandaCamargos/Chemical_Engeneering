clear
clc

# Considerando os inputs abaixo, encontre a função f(x) = a1 + a2x + a3x^2 que
# Melhor se aproxima dos pontos.



%Inputs--------------------
x = [0.1 0.2 0.5 0.7 0.8 0.9 1.1 1.23 1.35 1.5 1.7 1.8];
y = [0.19 0.36 0.75 0.91 0.96 0.99 0.99 0.94 0.87 0.75 0.51 0.35];
n = length(x);
eps = 1e-6;

# Construindo a matriz A e vetor b, descrito no caderno pag 25

sum_x = sum(x);
sum_x2 = sum(x.^2);
sum_x3 = sum(x.^3);
sum_x4 = sum(x.^4);
sum_y = sum(y);
sum_xy = sum(x.*y);
sum_x2y = sum(x.^2.*y);

A = [n, sum_x, sum_x2; sum_x, sum_x2, sum_x3; sum_x2, sum_x3, sum_x4];
b = [sum_y; sum_xy; sum_x2y];
  
# Resolvendo o sistema linear

alfas = A\b;

alfa1 = alfas(1);
alfa2 = alfas(2);
alfa3 = alfas(3);

# Plotagem dos resultados


xx = [min(x):0.1:max(x)];
yy = alfa1 + alfa2.*xx + alfa3.*xx.^2;

plot(xx,yy) # função encontrada
hold on
plot(x,y, "o")
grid




