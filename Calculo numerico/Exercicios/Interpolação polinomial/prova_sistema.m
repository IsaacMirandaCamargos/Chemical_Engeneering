clear
clc

# PONTOS

x = [0	3.0961	6.6026	9.1318	10.5115	11.3510];
y = [0	2.6871	6.8232	11.5050	15.6985	19.9948];
n = length(x);

# MOTANDO A MATRIZ A E VETOR B

B = y';

c = x';
for i = 1:1:n
  A(:,i) = c.^(i-1);
endfor

# disp(A)

# RESOLVENDO O SISTEMA

a = A\B;

# disp(a)

# DEFININDO O POLINOMIO INTERPOLADOR

xx = min(x):0.01:max(x);
aa = flip(a);
yy = polyval(aa,xx);

plot(x,y,"o")
hold
plot(xx,yy)