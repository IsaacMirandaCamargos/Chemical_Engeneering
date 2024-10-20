clear
clc

%Inputs--------------------------------
nx = 8;%n�mero de pontos discretizados ao longo de x
ny = 8;%n�mero de pontos discretizados ao longo de y
L = 0.8;%comprimento da placa quadrada
dx = L/(nx+1);%tamanho dos elementos em x
dy = L/(ny+1);%tamanho dos elementos em y
A = matrizA(nx,ny,dx,dy);%constru��o da matriz A
b = vetorB(nx,ny,dx,dy);%constru��o do vetor b
n = length(b);
eps = 1e-2;

X_antes = zeros(n,1);%campo de temperatura inicial

%Solu��o-------------------------------
C = -A./diag(A) + eye(n);
d = b./diag(A);
erro = eps+1;

%C�culo das Normas--------------------------------------
norma1 = max(sum(abs(C),1));%norma do m�ximo das colunas
norma_Inf = max(sum(abs(C),2));%norma do m�ximo das linhas
norma2 = sqrt(sum(sum(C.^2)));%norma Euclidiana

%Teste de Converg�ncia----------------------------
if norma1>=1 && norma_Inf>=1 && norma2>=1
  disp('Teste de converg�ncia n�o satisfeito!')
  continuar = input('Deseja continuar (1 para sim/0 para n�o)?');
  if continuar == 0
    disp('EXECU��O ABORTADA!')
    return
  endif
endif

%M�todo de Gauss-Jacobi------------------------------------------------
##cont_J = 0;%contador de itera��es
##while erro>eps
##  X_depois = C*X_antes + d;
##  erro = max(abs(X_depois-X_antes));
##  X_antes = X_depois;
##  cont_J = cont_J + 1;
##endwhile
##X_jacobi = X_depois;%solu��o por Gauss-Jacobi

%M�todo de Gauss-Seidel-----------------------------------------
X_antes = zeros(n,1);
cont_S = 0;
erro = eps+1;
while erro>eps
  vet_iter_anterior = X_antes;
  for j=1:1:n%c�lculo linha a linha do sistema
    X_depois(j,1) = C(j,:)*X_antes + d(j);
    X_antes(j,1) = X_depois(j);
  endfor    
  erro = max(abs(X_depois-vet_iter_anterior));
  X_antes = X_depois;
  cont_S = cont_S + 1;
endwhile
X_seidel = X_depois;%solu��o por Gauss-Seidel

%Resultados
##disp('A solu��o aproximada de Jacobi �: ')
##disp(X_jacobi)
##disp('O n�mero de itera��es de Jacobi �: ')
##disp(cont_J)

disp('A solu��o aproximada de Seidel �: ')
disp(X_seidel)
disp('O n�mero de itera��es de Seidel �: ')
disp(cont_S)

T = rearranjaX(X_seidel,nx,ny);%organiza vetor solu��o em uma matriz para visualiza��o
surf(T)%plota superf�cie de resposta







