clear
clc

##function y = temperatura_com_tempo()
##  hora = [0	3600	7200	10800	14400	18000	21600	25200	28800	32400	36000	39600	43200	46800]; # Segundos
##  temperatura = [17.4,19.4,22.2,23.5,24.8,27,26.7,28.5,28.5,29.9,28.3,28.7,27.5,25.8]; # Graus celsius
##
##  temperatura = temperatura + 273.15;
##
##  # CALCULANDOS OS POLINOMIOS INTERPOLADORES (SPLINES)
##  s = spline(hora,temperatura);
##  # SUBSTITUINDO VALORES
##  xx = min(hora):1:max(hora);
##  yy = ppval(s,xx);
##  # CALCULANDO VOLUME
##  y = yy;
##  plot(xx,yy)
##endfunction
##
function y = incidencia_de_radiacao()

  tempo = [32400 36000 39600	43200	46800	50400	54000	57600	61200	64800	68400	72000	75600	79200];
  radiacao_incidente = [0,144.52,929.58,1834.64,1803.24,2297.38,2361.13,2872.26,3586.55,3124.73,1784.52,1364.89,830.81,123.55]; # kJ/h.m^2
  
  radiacao_incidente = radiacao_incidente*1000/3600; # W/m^2

  # CALCULANDOS OS POLINOMIOS INTERPOLADORES (SPLINES)
  s = spline(tempo,radiacao_incidente);
  # SUBSTITUINDO VALORES
  xx = min(tempo):3600:max(tempo);
  yy = ppval(s,xx);
  # CALCULANDO VOLUME
  y = yy;
  plot(xx,yy)
  disp(max(yy))
endfunction
# Incidencia de radiacao

incidencia_de_radiacao();