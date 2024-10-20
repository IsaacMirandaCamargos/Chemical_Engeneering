clear
clc

##1) Dado o sistema linear
##
##x1 + x2 = 3
##x1 - 3x2 = -3
##
##a) Fa�a o gr�fico de cada uma das retas representadas nas equa��es acima e
##verifique que o ponto de interse��o entre elas, (3/2, 3/2), � a solu��o do 
##sistema linear.
##
##b) Isole x1 na primeira equa��o e x2 na segunda equa��o e escreva o m�todo
##de Gauss-Jacobi;
##
##c) Considere {?}^(0) = (0,0)T e fa�a itera��es at� que se obtenha erro 
##absoluto menor do que 0,5�10-1 utilizando a norma da soma


## LETRA "A": Sim, a intersec��o entre elas � soluc�o do sistema

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

## ITERA��ES

erro = 1;
contador = 0;
while erro > eps
  xf = C*xi + d;
  erro = sum(abs(xf-xi));
  xi = xf;
  contador += 1;
endwhile


disp("A solu��o do sistema �")
disp(xf)
disp("itera��es")
disp(contador)

  

