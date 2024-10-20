clc
clear
format long


A = [4,-1,-1,0;-1,4,0,-1;-1,0,4,-1;0,-1,-1,4];
b = [125;25;175;75];
xi = [0;0;0;0];
eps = 1e-6;

n = length(b);
C = (-A./diag(A) + eye(n));
d = (b./diag(A));

n_1 = max(sum(abs(C),1));
n_inf = max(sum(abs(C),2));
n_2 = sqrt(sum(sum(C.^2)));


if n_1 >= 1 && n_inf >= 1 && n_2 >= 1
  disp("Condição de convergencia não satisfeita")
  disp("Deseja continuar? Digite 1 para continuar, 2 para parar :")
  ordem = input(">>>");
  if ordem == 2
    return
  endif
endif

erro = 1;
contador = 0;
while erro > eps
  xi_geral = xi;
  for linha = 1:1:n
    xf(linha,:) = C(linha,:)*xi + d(linha,:);
    xi(linha,:) = xf(linha,:);
  endfor
  erro = max(abs(xf - xi_geral));
  contador += 1;
endwhile

disp("As temperaturas são respectivamente, T12, T22, T11, T21: ")
disp(xf)
