clear
clc

% Inputs --------------------------------------------------------------------
A = [10 -1 4; 1 10 9; 2 -3 -10];
b = [5;2;9];
eps = 1e-6;
X_antes = [0.5; 0.5; 0.5];
n = length (b);

% Solução -------------------------------------------------------------------
C = -A./diag(A) + eye(n);
d = b./diag(A);

erro = 2;
cont = 0;

for it = 1:1:2 %indexação i 
   vet_iter_anterior = X_antes;
   for j =1:1:n %cálculo linha a linha do sistema 
     X_depois(j,1) = C(j,:)*X_antes + d(j); 
     X_antes (j,1) = X_depois(j); 
  %aqui!
   endfor

   erro -= -1;
   X_antes = X_depois; 
   cont = cont+1;
endfor

disp(X_depois)
disp(cont)
