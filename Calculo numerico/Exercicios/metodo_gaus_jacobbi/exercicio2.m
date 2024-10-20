clear
format long
clc

# INPUTS (Chute inicial, erro, matriz [A], matriz dos coeficientes)

A = [6, -4.6954, -4.642;-4.6954, 3.887, 3.576;-4.642, 3.576, 3.689];
b = [0.4403;-0.02576;-0.5866];
xi = [1; 0; 0];
eps = 1e-6;

# DETERMINADO A MATRIZ [C] E VETOR {D}

n = length(b);
C = (-A./diag(A) + eye(n))/1000;
d = (b./diag(A))/1000;

# TESTE SE A MATRIZ CONVERGE, CALCULANDO NORMAS

n_1 = max(sum(abs(C),1));
n_inf = max(sum(abs(C),2));
n_2 = sqrt(sum(sum(C.^2)));

# ITERAÇÕES PARA APROXIMAR O VALOR 


if n_1 >= 1 && n_inf >= 1 && n_2 >= 1
  disp("Condição de convergencia não satisfeita")
  disp("Deseja continuar? Digite S ou N:")
  condicao = input("")
  if condicao == 2
    return
  endif
endif
xf = (C*xi + d)*1000;
erro = max(abs(xf - xi));
contador = 1;

while erro > eps
  contador += 1;
  xi = xf;
  xf = (C*xi + d)*1000;
  erro = max(abs(xf - xi));
endwhile

disp(xf)
disp(contador)
