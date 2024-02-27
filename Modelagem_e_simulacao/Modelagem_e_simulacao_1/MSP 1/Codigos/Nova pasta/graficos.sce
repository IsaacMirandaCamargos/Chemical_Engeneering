clc
clear
mode(-1)


// VARIAVEIS
x = 0:%pi/500:%pi

// CRIANDO 1° GRAFICO
scf(0)
clf()
plot(x, sin(x),"r")
plot(x, cos(x), "b")

// EDITANDO 1° GRAFICO
xtitle("Graficos do seno e cosseno", "x", "sen/cos")
legend(["seno", "coss"],3)

// CRIANDO 2° GRAFICO
scf(1)
clf
subplot(1,2,1), plot(x, sin(x), "r")
xgrid(0)
xtitle("Grafico seno", "x", "sen")
subplot(1,2,2), plot(x, cos(x), "b")
xgrid(0)
xtitle("Grafico cos", "x", "cos")
// EDITANDO 2° GRAFICO

