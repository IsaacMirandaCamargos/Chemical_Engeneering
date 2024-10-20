clear
clc

##1) Dado o sistema linear
##
##x1 + x2 = 3
##x1 - 3x2 = -3
##
##a) Faça o gráfico de cada uma das retas representadas nas equações acima e
##verifique que o ponto de interseção entre elas, (3/2, 3/2), é a solução do 
##sistema linear.
##
##b) Isole x1 na primeira equação e x2 na segunda equação e escreva o método
##de Gauss-Jacobi;
##
##c) Considere {?}^(0) = (0,0)T e faça iterações até que se obtenha erro 
##absoluto menor do que 0,5×10-1 utilizando a norma da soma


## LETRA "A": Sim, a intersecção entre elas é solucão do sistema

##function y = f(x)
##  y = -x + 3;
##endfunction
##
##function y = g(x)
##  y = 3*x - 3;
##endfunction
##
##x1 = -10:0.1:10;
##y1 = f(x1);
##y2 = g(x1);
##
##plot(x1,y1,x1,y2)
##grid

###### LETRA "B" E "C"

## INPUTS

A = [1,1;1,-3];
b = [3;-3];
eps = 0.05;
xi = [0;0];

## ISOLANDO X

n = length(A);
C = -A./diag(A) + eye(n);
d = b./diag(A);

## ITERAÇÕES

erro = 1;
contador = 0;
while erro > eps
  xf = C*xi + d;
  erro = sum(abs(xf-xi));
  xi = xf;
  contador += 1;
endwhile


disp("A solução do sistema é")
disp(xf)
disp("iterações")
disp(contador)

  

