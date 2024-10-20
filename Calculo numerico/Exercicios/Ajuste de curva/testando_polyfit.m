clear
clc

# Testando polyfit

x = [-1, -0.5, 0, 0.5, 1, 1.5, 2, 2.5, 3];
y = [-1.796, -1.666, -1.386, -0.511, -0.223, 0.182, 0.588, 0.971, 1.308];

polyfit(x,y,1)

# O Polinomio sai na ordem y = a1x + a2
