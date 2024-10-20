format long
clc
clear

%Inputs-------------------------------------------------------------------------
a = input("Entre com o valor inferior do intervalo: ");
b = input("Entre com o valor superior do intervalo: ");
eps = input("Entre com a precisão desejada: ")


function y = f(x)
  y = x^2-4;
endfunction

%Loop---------------------------------------------------------------------------

while abs(a-b)>eps

  c = (a+b)/2;
  
  if f(a)*f(c) < 0    ## Raiz aqui
    b = c;
  elseif f(a)*f(c) > 0 ## Raiz não está aqui
    a = c;
  else
    disp('Raiz com 16 casas de precisão')
    break
  endif
  

endwhile

r = c;

%Output-------------------------------------------------------------------------
disp('A raiz aproximada é: ')
disp(r)
  
  
  
  
  
  


