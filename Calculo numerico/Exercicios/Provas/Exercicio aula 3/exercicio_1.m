clear
clc

% Implemente um codigo que realize a soma dos numeros multiplos de 3 no
% intervalo de 1 a 1000



soma = 0;

for i=1:1:1000
  if mod(i,3) == 0
    soma = soma + i;
  endif
endfor

soma

soma = 0;

for i=3:3:1000
  soma = soma + i;
endfor

soma