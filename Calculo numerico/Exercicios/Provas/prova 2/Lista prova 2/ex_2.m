clear
clc

## INPUTS

A = [2,1,3;0,-1,1;1,0,3];
b = [9;1;3];
eps = 1e-6;
xi = [0;0;0];

## TROCANDO AS LINHAS E COLUNAS DE LUGAR

linha_1 = A(1,:);
A(1,:) = A(3,:);
A(3,:) = linha_1;

linha_b_1 = b(1);
b(1) = b(3);
b(3) = linha_b_1;

coluna_1 = A(:,1);
A(:,1) = A(:,3);
A(:,3) = coluna_1;


## VERIFICANDO CRITERIO DE CONVERGENCIA PELA NORMA LINHA

## ISOLANDO X

n = length(A);
C = -A./diag(A) + eye(n);
d = b./diag(A);

## ITERAÇÕES

erro = 1;
contador = 0;
while erro > eps
  xi_geral = xi;
  for linha = 1:1:n
    xf(linha,:) = C(linha,:)*xi + d(linha,:);
    xi(linha,:) = xf(linha,:);
  endfor
  erro = sum(abs(xf-xi_geral));
  contador += 1;
endwhile


disp("A solução do sistema é")
disp(xf)
disp("iterações")
disp(contador)