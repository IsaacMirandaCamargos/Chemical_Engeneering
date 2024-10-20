clc
clear

a = 0.5;
b = 5;
eps = 0.0001;

function y = f(x)
  y = exp(x)-5*sin(x);
endfunction


erro = abs(a-b);
while erro > eps
  x = (a+b)/2;
  
  if f(a)*f(x) < 0
    b = x;
  elseif f(a)*f(x) > 0
    a = x;
  else
    disp("A raiz tem 16 casas decimais corretas")
    break
  endif
  erro = abs(a-b);

endwhile
  
  
r = x;
disp("A raiz aproximada é")
disp(r)