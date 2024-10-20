clear
clc


function y = incidencia_de_radiacao()
  tempo = [0	3600	7200	10800	14400	18000	21600	25200	28800	32400	36000	39600	43200	46800];
  radiacao_incidente = [0,144.52,929.58,1834.64,1803.24,2297.38,2361.13,2872.26,3586.55,3124.73,1784.52,1364.89,830.81,123.55]; # kJ/m^2

  radiacao_incidente = radiacao_incidente*1000/3600; # watts/ m^2

  # CALCULANDOS OS POLINOMIOS INTERPOLADORES (SPLINES)
  s = spline(tempo,radiacao_incidente);
  # SUBSTITUINDO VALORES
  xx = min(tempo):1:max(tempo);
  yy = ppval(s,xx);
  # CALCULANDO VOLUME
  y = yy;
  
  plot(tempo, radiacao_incidente,'o')
  hold
  plot(xx,yy)
endfunction

incidencia_de_radiacao();