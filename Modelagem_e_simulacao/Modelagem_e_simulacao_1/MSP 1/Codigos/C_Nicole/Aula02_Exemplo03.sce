//Gráficos
//Nicole
//27/01/23

clc
clear
mode(-1)


x=0:%pi/50:%pi


//teste
scf(0)
clf()
plot(x,sin(x),'r')
plot(x,cos(x),'b')

legend(['seno','cosseno'],2)

//teste 02

scf(1)
clf()
//subplot(Linha, Coluna, Posição)
subplot(2,1,1), plot(x,sin(x),'r')

//Gráfico 2D xtitle('Titulo','Eixo X','Eixo Y')
xtitle('seno','x','seno(x)')
xgrid(0)

subplot(2,1,2), plot(x,cos(x),'b')
xgrid(0)
