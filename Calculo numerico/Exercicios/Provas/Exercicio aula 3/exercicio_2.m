## Implemente um codigo que calcula a precis�o da maquina: eps

clear
clc

epsilon = 1;
contador = 0;

while epsilon+1 > 1
  epsilon = epsilon/2;
  contador += 1;
endwhile

epsilon = epsilon*2
contador
