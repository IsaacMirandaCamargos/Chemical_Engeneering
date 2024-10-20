clear
clc

##A equação de Kepler, usada para determinar órbitas de satélites é
##dada por:
##
##M = x – K sen(x)
##
##Dado que K = 0.2 e M = 0.5, obtenha a raiz da equação de Kepler.

## INTERVALO

a = input("inferior ");
b = input("superior ");
eps = input("erro ");

## FUNÇÃO

function y = h(x)
  y = x -0.2*sin(x) - 0.5;
endfunction

## ENCONTRANDO RAIZ

while abs(a-b)>eps
  
  x = (a+b)/2;
  
  if h(a)*h(x) < 0
    b = x;
  elseif h(a)*h(x) > 0
    a = x;
  else
    break
  endif
endwhile

raiz = x;

disp("A raiz é: ")
disp(raiz)