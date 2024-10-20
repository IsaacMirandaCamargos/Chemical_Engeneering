clear
format long
clc

# INPUTS (Chute inicial, erro, matriz [A], matriz dos coeficientes)

A = [-7 3 2; 1 3 -1; 1 1 -3];
b = [-2; 3; -1];
xi = [1; 0; 0];
eps = 1e-6;

# DETERMINADO A MATRIZ [C] E VETOR {D}

n = length(b);
p = max(max(abs(A)));
C = (-A./diag(A) + eye(n))/p;
d = (b./diag(A))/p;

# TESTE SE A MATRIZ CONVERGE, CALCULANDO NORMAS

n_1 = max(sum(abs(C),1));
n_inf = max(sum(abs(C),2));
n_2 = sqrt(sum(sum(C.^2)));

# ITERAÇÕES PARA APROXIMAR O VALOR 


if n_1 >= 1 && n_inf >= 1 && n_2 >= 1
  disp("Condição de convergencia não satisfeita")
  disp("Deseja continuar? Digite S ou N:")
  condicao = input("")
  if condicao == N
    return
  endif
endif
xf = (C*xi + d)*p;
erro = max(abs(xf - xi));
contador = 1;

while erro > eps
  contador += 1;
  xi = xf;
  xf = (C*xi + d)*p;
  erro = max(abs(xf - xi));
endwhile

disp(xf)
disp(contador)

  



