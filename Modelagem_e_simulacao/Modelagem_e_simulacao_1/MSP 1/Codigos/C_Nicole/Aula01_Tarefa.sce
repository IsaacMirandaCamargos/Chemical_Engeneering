clc
clear
mode(-1)

//INPUTS (Chute inicial (xi), erro (eps), matriz [A], matriz dos coeficientes (b))
A = [-4 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0;
 1 -4 1 0 0 1 0 0 0 0 0 0 0 0 0 0;
 0 1 -4 1 0 0 1 0 0 0 0 0 0 0 0 0;
 0 0 1 -4 0 0 0 1 0 0 0 0 0 0 0 0;
 1 0 0 0 -4 1 0 0 1 0 0 0 0 0 0 0;
 0 1 0 0 1 -4 1 0 0 1 0 0 0 0 0 0;
 0 0 1 0 0 1 -4 1 0 0 1 0 0 0 0 0;
 0 0 0 1 0 0 1 -4 0 0 0 1 0 0 0 0;
 0 0 0 0 1 0 0 0 -4 1 0 0 1 0 0 0;
 0 0 0 0 0 1 0 0 1 -4 1 0 0 1 0 0;
 0 0 0 0 0 0 1 0 0 1 -4 1 0 0 1 0;
 0 0 0 0 0 0 0 1 0 0 1 -4 0 0 0 1;
 0 0 0 0 0 0 0 0 1 0 0 0 -4 1 0 0;
 0 0 0 0 0 0 0 0 0 1 0 0 1 -4 1 0;
 0 0 0 0 0 0 0 0 0 0 1 0 0 1 -4 1;
 0 0 0 0 0 0 0 0 0 0 0 1 0 0 1 -4];

b = [0;0;-100;-200;0;0;0;-100;-20;0;0;-40;-40;-20;-40;-80];
xi = [10;13;5;16;8;9;4;2;13;5;25;20;10;4;15;24];
eps = 1e-2;

// DETERMINADO A MATRIZ [C] E VETOR {D}

n = length(b);
C = (-A./-4 + eye(n,n));
d = (b./diag(A));


// TESTE SE A MATRIZ CONVERGE, CALCULANDO NORMAS

n_1 = max(sum(abs(C),1));
n_inf = max(sum(abs(C),2));
n_2 = sqrt(sum(sum(C.^2)));

if n_1 >= 1 & n_inf >= 1 & n_2 >= 1
  disp("Condição de convergencia não satisfeita");
  disp("Deseja continuar? Digite s ou n:");
  ordem = input(">>>", "s")
  if ordem == "n"
    return;
  end
end

// ITERAÇÕES PARA APROXIMAR O VALOR 

erro = 1
contador = 0
while erro > eps
  xi_geral = xi;
  disp(xi_geral);
  for linha = 1:1:n
    xf(linha,:) = C(linha,:)*xi + d(linha,:);
    xi(linha,:) = xf(linha,:);
  end
  erro = sum(abs(xf - xi_geral).^2);
  contador = contador + 1;
end

disp("X final:",xf);
disp("Interações:",contador);
