// Interpolação
// Nicole Maia Argondizzi
//13/01/2023

clc
clear
mode(-1)

X = [0:0.2:1]
ra = [0.1125,0.09,0.0675,0.045,0.0225,0]

//1° Forma - Separados
disp('1° forma')

X1 = 0.25
X2 = 0.50
X3 = 0.90

ra1 = interp1(X,ra,X1,'linear')
ra2 = interp1(X,ra,X2,'linear')
ra3 = interp1(X,ra,X3,'linear')

disp("ra1:",ra1,"ra2:", ra2,"ra3:", ra3)

//2° Forma - Juntos
disp('2° forma')

Xn = [X1,X2,X3]
ran= interp1(X,ra,Xn,'spline')
disp("ran:",ran)
