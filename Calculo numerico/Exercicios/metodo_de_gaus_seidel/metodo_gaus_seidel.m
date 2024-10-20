clear
format long


# INPUTS (Chute inicial, erro, matriz [A], matriz dos coeficientes)

k = 10;
A = [-3*k 2*k 0; 2*k -3*k k; 0 k -k];
m1 = 2;
m2 = 3;
m3 = 2.5;
g = 9.81;
b = [-m1*g; -m2*g; -m3*g];
xi = [7; 10; 12];
eps = 1e-6;

# DETERMINADO A MATRIZ [C] E VETOR {D}

n = length(b);
C = (-A./diag(A) + eye(n));
d = (b./diag(A));


# TESTE SE A MATRIZ CONVERGE, CALCULANDO NORMAS

n_1 = max(sum(abs(C),1));
n_inf = max(sum(abs(C),2));
n_2 = sqrt(sum(sum(C.^2)));

# ITERAÇÕES PARA APROXIMAR O VALOR 


if n_1 >= 1 && n_inf >= 1 && n_2 >= 1
  disp("Condição de convergencia não satisfeita")
  disp("Deseja continuar? Digite S ou N:")
  ordem = input(">>>", "s");
  if ordem == "N"
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
  erro = sum(abs(xf - xi_geral).^2);
  contador += 1;
endwhile

disp(xf)
disp(contador)
