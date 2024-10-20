
clear
clc


function y = temperatura_com_tempo()
  hora = [0	3600	7200	10800	14400	18000	21600	25200	28800	32400	36000	39600	43200	46800];
  temperatura = [17.4,19.4,22.2,23.5,24.8,27,26.7,28.5,28.5,29.9,28.3,28.7,27.5,25.8];
  # kJ/m^2

  temperatura = temperatura + 273.15;

  # CALCULANDOS OS POLINOMIOS INTERPOLADORES (SPLINES)
  s = spline(hora,temperatura);
  # SUBSTITUINDO VALORES
  xx = min(hora):1:max(hora);
  yy = ppval(s,xx);
  # CALCULANDO VOLUME
  y = yy;
  
  plot(hora, temperatura,'o')
  hold
  plot(xx,yy)
endfunction

temperatura_com_tempo();