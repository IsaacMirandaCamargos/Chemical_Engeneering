clear
clc

covid = load("covid_br.txt");

# Separando as colunas

dias = covid(:,1);
obitos = covid(:,2);

# Pré-processamento dos dados, queremos ajustar esses dados do dia 100 até o 360

dias = dias(100:1:360);
obitos = obitos(100:1:360);

# Media movel do vetor obitos

periodo = 6;
n = length(obitos);

for i = 1:1:n-periodo
  media_movel(i) = mean(obitos(i:1:i+periodo));
endfor

# Ajuste da curva

x = dias(1:n-periodo);
y = media_movel';
plot(x,y,"*")
hold on
grau_polinomio = 1;
coeficientes = polyfit(x,y,grau_polinomio);

# Testando o ajuste

xx = min(x):0.01:max(x);
yy = coeficientes(1)*xx + coeficientes(2);

plot(xx,yy) 


