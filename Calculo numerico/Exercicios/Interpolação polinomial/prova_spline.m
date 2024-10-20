clear
clc

# INPUTS



x = [3	6.0961	9.6026	12.1318	13.5115	14.3510];
y = [3	5.6871	9.8232	14.5050	18.6985	22.9948];


# CALCULANDOS OS POLINOMIOS INTERPOLADORES (SPLINES)
s = spline(x,y);
# SUBSTITUINDO VALORES
xx = min(x):0.001:max(x);
yy = ppval(s,xx);
# CALCULANDO VOLUME

n = length(xx);
area = (xx.^2)*pi;
area = area(1:n-1);


for i = 1:1:n-1
  intervalos(i,:) = yy(i+1)-yy(i);
endfor


volume = area*intervalos;
volume_total = sum(volume);

disp('O volume total da caixa de água é: ')
disp(volume_total)


plot(x,y,"o")
hold
plot(xx,yy)