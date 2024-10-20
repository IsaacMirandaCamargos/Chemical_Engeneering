clear
clc

# A função de Deybe é encontrada em termodinamica estatica no calculo do
# calor especifico da agua a volume constante de certas substancias.

# A função é espressa por:

# D(x) = 3/x^3*integral[y^3/(e^y - 1)] dy

# Obter D(x) entre y = 1 e y = 5, nos seguintes casos:

# a) x = 0.5
# b) x = 10
# c) x = 50

############################################################################
# RESOLVENDO A INTEGRAL

yInicio = 1;
yFinal = 5;
passo = 0.01;
xx = yInicio:passo:yFinal;
n = length(xx);

function Deybe = D(x)
  Deybe = x.^3./(exp(x) - 1);
endfunction

yy = D(xx);

integral = (passo/2)*(yy(1) + 2*sum(yy(2:n-1)) + yy(n));

##########################################################################
# LETRA "a", "b", "c"

x = 0.5;

D1 = (3/x^3)*integral;
x = 10;
D2 = (3/x^3)*integral;
x = 50;
D3 = (3/x^3)*integral;

disp(D1)
disp(D2)
disp(D3)
