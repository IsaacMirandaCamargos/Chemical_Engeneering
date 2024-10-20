clear
clc

# PENDULO DENTRO DA AGUA

massa = 2; # kg
Cd = 0.1;
pwater = 998; # kg/m^3
diametro = 0.15; # m
area = pi*(diametro/2)^2; # m^2
volume = (4*pi()*(diametro/2)^3)/3; # m^3
corda = 0.3; # m
gravidade = 9.81; # m/s^2

veloAngular(1) = 0; # velocidae angular inicial
tetha(1) = pi()/2; # angulo inicial

passo = 0.01;
tempo = 0:passo:20;
n = length(tempo);

function y = forca_gravidade(massa, gravidade, tetha)
  y = massa*gravidade*sin(tetha);
endfunction

function y = forca_arrasto(Cd, pwater, area, veloAngular)
  y = 0.5*Cd*pwater*area*veloAngular^2*sign(veloAngular);
endfunction

function dw_dt = variacao_da_velocidade_angular(forca_G, forca_A, massa)
  dw_dt = (forca_G - forca_A)/massa;
endfunction

function y = posicao_angular(tetha_inicio, velo_angular, variacao_velo, tempo)
  y = tetha_inicio - velo_angular*tempo - variacao_velo*tempo^2/2;
endfunction

for i = 1:1:n-1
  # FORÇA GRAVITACIONAL
  Forca_G(i) = forca_gravidade(massa, gravidade, tetha(i));
  # FORÇA ARRASTO
  Forca_A(i) = forca_arrasto(Cd, pwater, area, veloAngular(i));
  # VELOCIDADE PROXIMO INSTANTE
  aceleracao_angular(i) = variacao_da_velocidade_angular(Forca_G(i), Forca_A(i), massa);
  veloAngular(i+1) = veloAngular(i) + passo*aceleracao_angular(i);
  # ANGULO PROXIMO INSTANTE
  tetha(i+1) = posicao_angular(tetha(i), veloAngular(i), aceleracao_angular(i), passo);
endfor

# PRIMEIRA VIZUALIZACAO

plot(tempo,tetha)
hold
plot(tempo,veloAngular)
legend("tempo x angulo", "Tempo x velocidade")

# SEGUNDA VIZUALIZACAO

##plot(tetha,veloAngular)
##legend("angulo x velocidade")

# TERCEIRA VIZUALIZACAO

##plot(tempo(1:n-1),Forca_A)
##plot(tempo(1:n-1),Forca_G)
##legend("tempo x forca arrasto", "tempo x forca gravidade")

# QUARTA VIZUALIZACAO

##plot(tempo(1:n-1), aceleracao_angular)
##legend("tempo x aceleracao angular")

