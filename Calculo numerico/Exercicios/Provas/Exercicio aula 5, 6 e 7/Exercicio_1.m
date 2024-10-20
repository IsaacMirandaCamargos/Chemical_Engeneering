clear
format long
clc

# Use o metodo da Bisse��o para calcular a raiz da fun��o
# f(x) = ln(x) - sen(x) at� que seja satisfeita a seguinte condi��o:
# |b-a| < eps para eps = 0.0001

a = input("Digite o valor inferior do intervalo: ");
b = input("Digite o valor superior do intervalo: ");
eps = 0.00001;

function y = f(x)
  y = log(x) - sin(x);
endfunction

while abs(b-a)>eps
  
  x = (a+b)/2;
  
  if f(a)*f(x) < 0
    b = x;
  elseif f(a)*f(x) > 0
    a = x;
  else
    break
  endif
  
endwhile

raiz = x;
disp(raiz)

