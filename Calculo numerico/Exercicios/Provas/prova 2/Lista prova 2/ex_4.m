clear
clc

## INPUTS

A = [120,-20,0;40,60,-120;80,-80,0];
b = [2500;-600;0];
eps = 1e-10;
xi = [0;0;0];

## TIRANDO O ZERO DA DIAGONAL DA MATRIZ A

A(3,:) += A(2,:);
b(3) += b(2);

## ISOLANDO X

n = length(A);
p = max(max(abs(A)));
C = (-A./diag(A) + eye(n))/p;
d = (b./diag(A))/p;


## ITERAÇÕES

erro = 1;
contador = 0;
while erro > eps
  contador += 1;
  xf = (C*xi + d)*p;
  erro = max(abs(xf - xi));
  xi = xf;
endwhile

disp("c1,c2,c3, são respectivamente:")
disp(xf)

disp(contador)
disp(A*xf)
