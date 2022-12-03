clc
clear
mode(-1)

// VARIAVEIS 

X = [0:0.2:1]
_Ra = [0.1125 0.09 0.0675 0.045 0.0225 0]

// DETERMINANDO A TAXA DE REAÇÃO PARA OS FATORES DE CONVERSAO 25, 50 E 90%

_Ra_linear = interp1(X, _Ra, [0.25 0.50 0.9], "linear")
_Ra_spline = interp1(X, _Ra, [0.25 0.50 0.9], "spline")

disp("Interpolação linear é ")
disp(_Ra_linear)
disp("Interpolação linear é ")
disp(_Ra_spline)

Ra_linear_plot = interp1(X, _Ra, [0:0.01:1], "linear")
Ra_spline_plot = interp1(X, _Ra, [0:0.01:1], "spline")

subplot(1,2, 1)
plot([0:0.01:1], Ra_linear_plot)
subplot(1,2, 2)
plot([0:0.01:1], Ra_spline_plot)
