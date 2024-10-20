clear
clc

#
function y = incidenciaRadiacao()

  tempo = [0	3600	7200	10800	14400	18000	21600	25200	28800	32400	36000	39600	43200	46800];
  radiacaoI = [0,144.52,929.58,1834.64,1803.24,2297.38,2361.13,2872.26,3586.55,3124.73,1784.52,1364.89,830.81,123.55]; # kJ/h.m^2
  
  radiacaoI = radiacaoI*1000/3600; # W/m^2

  s = spline(tempo,radiacaoI);
  xx = min(tempo):1:max(tempo);
  yy = ppval(s,xx);
  y = yy;
endfunction

function y = temperaturaAmbiente()
  hora = [0	3600	7200	10800	14400	18000	21600	25200	28800	32400	36000	39600	43200	46800]; # Segundos
  temperatura = [11.8	11.7	12	12.4	12.6	14.3	16.2	18	19.2	19	18.4	17.8	17.2	16.5]; # Graus celsius

  temperatura = temperatura + 273.15;
  
  s = spline(hora,temperatura);
  xx = min(hora):1:max(hora);
  yy = ppval(s,xx);
  y = yy;

endfunction
#


# Inputs
temperaturaAmbiente = temperaturaAmbiente();
radiacao = incidenciaRadiacao();

constanteCapa = 0.05; 
espessuraCapa = 0.00326; 
A_piscina = 20.4; 
volumePiscina = 15.85; 
BOMBA = 0; # 0 = desligado, 1 = ligado
tempoLigadoContinuo = 0;
tempoBombaLigada = 0;
temperaturaPiscina(1) = 25 + 273.15; 
t_on = 6 ; 
t_off = 4 ; 
passo = 1; 
horaInicio = 32400-10800;
horaFinal = 79200-10800;
pwater = 998; 
cpwater = 4190; 
vazaoVolumetrica = 0.72; 
volumeAguaColetor = 0.12;
vazaoMassica = (vazaoVolumetrica*pwater)/3600; 
baixoTempoLigado = pwater*volumeAguaColetor/vazaoMassica; 
gastoBombaSegundo = 1250; 
temperaturaColetor(1) = 20 + 273.15; 
FR = 0.6; 
UL = 11.45; 
ac = 0.8; 
A_coletor = 24; 

periodo = horaInicio:passo:horaFinal;

#
function y = variacaoTemperaturaPiscina(calorColetorPiscina, calorCapa, densidadeAgua, capacidadeAgua, volumePiscina)
  constante = capacidadeAgua*densidadeAgua*volumePiscina;
  y = (calorColetorPiscina + calorCapa)/constante;
endfunction


function y = variacaoTemperaturaOff(calorFornecido, densidadeAgua, capacidadeAgua, volumeColetor)
  y = (calorFornecido)/(densidadeAgua*capacidadeAgua*volumeColetor);
endfunction

function y = variacaoTemperaturaOn(calorFornecido, vazaoMassia, capacidadeAgua, temperaturaPiscina)
  y = (calorFornecido)/(vazaoMassia*capacidadeAgua) +temperaturaPiscina;
endfunction
#



# Resolvendo

interacoes = length(periodo);

for i = 1:1:interacoes
  
  #
  if (temperaturaColetor(i) - temperaturaPiscina(i)) > t_on
    BOMBA = 1;
    tempoLigadoContinuo += 1;
  elseif (temperaturaColetor(i) - temperaturaPiscina(i)) < t_off
    BOMBA = 0;
    tempoLigadoContinuo = 0;
  endif
  #

  #
  temperaturaCapa(i) = (temperaturaPiscina(i) + temperaturaAmbiente(i))/2;
  taxaCalorCapa(i) = constanteCapa*A_piscina*(temperaturaCapa(i)-temperaturaPiscina(i))/espessuraCapa;
  if BOMBA == 1
    taxaCalorColetorParaPiscina(i) = vazaoMassica*cpwater*(temperaturaColetor(i)-temperaturaPiscina(i));
  else
    taxaCalorColetorParaPiscina(i) = 0;
  endif
  temperaturaPiscina(i+1) = temperaturaPiscina(i) + passo*variacaoTemperaturaPiscina(taxaCalorColetorParaPiscina(i), taxaCalorCapa(i), pwater, cpwater, volumePiscina);
  #

  
  #
  radiacao_abs = ac*radiacao;
  taxaCalorColetorParaAgua(i) = A_coletor*FR*(radiacao_abs(i)-UL*(temperaturaColetor(i)-temperaturaAmbiente(i)));
  if BOMBA == 0
    temperaturaColetor(i+1) = temperaturaColetor(i) + passo*variacaoTemperaturaOff(taxaCalorColetorParaAgua(i),pwater, cpwater,volumeAguaColetor);
  else
    if tempoLigadoContinuo <= baixoTempoLigado
      temperaturaColetor(i+1) = temperaturaColetor(i) + passo*variacaoTemperaturaOff(taxaCalorColetorParaAgua(i),pwater, cpwater,volumeAguaColetor);
    else
      temperaturaColetor(i+1) = variacaoTemperaturaOn(taxaCalorColetorParaAgua(i),vazaoMassica, cpwater, temperaturaPiscina(i));
    endif
  endif
  #
endfor


# PERGUNTAS

### A
disp("A temperatura da piscina as 19 horas é:")
disp(temperaturaPiscina(end))

### B
periodo_horas = periodo/3600;

##hold on
##plot(periodo_horas, temperaturaColetor(2:end)-273.15,";Temperatura agua coletor;")
##plot(periodo_horas, temperaturaPiscina(2:end)-273.15,";Temperatura agua piscina;")
##ylabel("Temperatura (Celsius)")
##xlabel("Tempo (Horas)")
##hold off

### C
##hold on
##plot (periodo_horas, taxaCalorCapa, ";Calor transferido pela capa;")
##plot (periodo_horas, taxaCalorColetorParaPiscina, ";Calor fornecido a piscina;")
##ylabel ("Calor (Joules)");
##xlabel ("Hora (h)"); 
##hold off

### D
for i = 1:1:length(taxaCalorColetorParaPiscina)
  if taxaCalorColetorParaPiscina(i) == 0
  else
    tempoBombaLigada += 1;
  endif
endfor

energia = passo*(taxaCalorColetorParaPiscina(1) + sum(taxaCalorColetorParaPiscina(2:end-1)) + taxaCalorColetorParaPiscina(end))/2;
gastomaximo = gastoBombaSegundo*tempoBombaLigada;
COP = energia/gastomaximo;

disp("O COP é:")
disp(COP)
