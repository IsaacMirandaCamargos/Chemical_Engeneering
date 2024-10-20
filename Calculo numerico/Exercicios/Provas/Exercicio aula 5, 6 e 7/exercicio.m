clear
clc

## Use o metodo da bisseção para calcular a raiz da função f(x) = ln(x) - sin(x)
## até que seja satisfeita a seguinte condição: b-a < c    para   c = 0,2

erro = 0.00001
x = -10:0.01:10;
y = sin(x);


for i = 1:1:length(x)
  a = x(i);
  b = x(i+1);
  
  if sin(a)*sin(b) < 0    ## Raiz está aqui
    
    while abs(a-b) > erro
      c = (a + b)/2;
      
      if sin(a)*sin(c) < 0  ## Raiz aqui
        b = c;
      elseif sin(a)*sin(c) > 0
        a = c;
      else
        break
      endif
      
    endwhile
    
r = c;
disp(r)


