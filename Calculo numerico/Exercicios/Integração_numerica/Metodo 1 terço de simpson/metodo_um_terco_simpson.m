clear
clc


# Calcule a integral abaixo pelo metodo de 1/3 de simpson com h = 0.2:

# I = integral [(x^2)*(e^(x-1))]

# xInicio = -2
# xFinal = -1

###########################################################################
# ANALISANDO O NUMERO DE PONTOS

xInicio = -2;
xFinal = -1;
h = 0.2;
x = xInicio:h:xFinal;

# COMO HÁ 6 PONTOS, VAMOS DIMINUIR (h) E ENCONTRAR UM NUMERO DE PONTOS IMPAR

n = 7; # QUANTIDADE DE PONTOS QUE QUEREMOS
h = (xFinal - xInicio)/( n - 1);
x = xInicio:h:xFinal;

# USANDO O METODO DE 1/3 DE SIMPSON

function y = d(x)
  y = x.^2.*exp(x-1);
endfunction
y = d(x);

area_da_integral = (h/3)*(y(1) + 4*sum(y(2:2:n-1)) + 2*sum(y(3:2:n-2)) + y(n));

disp(area_da_integral)
