clear
clc

%Inputs--------------------------------
nx = 8;%número de pontos discretizados ao longo de x
ny = 8;%número de pontos discretizados ao longo de y
L = 0.8;%comprimento da placa quadrada
dx = L/(nx+1);%tamanho dos elementos em x
dy = L/(ny+1);%tamanho dos elementos em y
A = matrizA(nx,ny,dx,dy);%construção da matriz A
b = vetorB(nx,ny,dx,dy);%construção do vetor b
n = length(b);
eps = 1e-2;

X_antes = zeros(n,1);%campo de temperatura inicial

%Solução-------------------------------
C = -A./diag(A) + eye(n);
d = b./diag(A);
erro = eps+1;

%Cáculo das Normas--------------------------------------
norma1 = max(sum(abs(C),1));%norma do máximo das colunas
norma_Inf = max(sum(abs(C),2));%norma do máximo das linhas
norma2 = sqrt(sum(sum(C.^2)));%norma Euclidiana

%Teste de Convergência----------------------------
if norma1>=1 && norma_Inf>=1 && norma2>=1
  disp('Teste de convergência não satisfeito!')
  continuar = input('Deseja continuar (1 para sim/0 para não)?');
  if continuar == 0
    disp('EXECUÇÃO ABORTADA!')
    return
  endif
endif

%Método de Gauss-Jacobi------------------------------------------------
##cont_J = 0;%contador de iterações
##while erro>eps
##  X_depois = C*X_antes + d;
##  erro = max(abs(X_depois-X_antes));
##  X_antes = X_depois;
##  cont_J = cont_J + 1;
##endwhile
##X_jacobi = X_depois;%solução por Gauss-Jacobi

%Método de Gauss-Seidel-----------------------------------------
X_antes = zeros(n,1);
cont_S = 0;
erro = eps+1;
while erro>eps
  vet_iter_anterior = X_antes;
  for j=1:1:n%cálculo linha a linha do sistema
    X_depois(j,1) = C(j,:)*X_antes + d(j);
    X_antes(j,1) = X_depois(j);
  endfor    
  erro = max(abs(X_depois-vet_iter_anterior));
  X_antes = X_depois;
  cont_S = cont_S + 1;
endwhile
X_seidel = X_depois;%solução por Gauss-Seidel

%Resultados
##disp('A solução aproximada de Jacobi é: ')
##disp(X_jacobi)
##disp('O número de iterações de Jacobi é: ')
##disp(cont_J)

disp('A solução aproximada de Seidel é: ')
disp(X_seidel)
disp('O número de iterações de Seidel é: ')
disp(cont_S)

T = rearranjaX(X_seidel,nx,ny);%organiza vetor solução em uma matriz para visualização
surf(T)%plota superfície de resposta







