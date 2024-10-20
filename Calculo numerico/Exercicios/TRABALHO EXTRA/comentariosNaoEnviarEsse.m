clear
clc

############################# FUNCOES ##################################
function y = incidenciaRadiacao()

  tempo = [0	3600	7200	10800	14400	18000	21600	25200	28800	32400	36000	39600	43200	46800];
  radiacaoI = [0,144.52,929.58,1834.64,1803.24,2297.38,2361.13,2872.26,3586.55,3124.73,1784.52,1364.89,830.81,123.55]; # kJ/h.m^2
  
  radiacaoI = radiacaoI*1000/3600; # W/m^2

  # CALCULANDOS OS POLINOMIOS INTERPOLADORES (SPLINES)
  s = spline(tempo,radiacaoI);
  # SUBSTITUINDO VALORES
  xx = min(tempo):1:max(tempo);
  yy = ppval(s,xx);
  # CALCULANDO VOLUME
  y = yy;
endfunction
# Incidencia de radiacao

function y = temperaturaAmbiente()
  hora = [0	3600	7200	10800	14400	18000	21600	25200	28800	32400	36000	39600	43200	46800]; # Segundos
  temperatura = [17.4,19.4,22.2,23.5,24.8,27,26.7,28.5,28.5,29.9,28.3,28.7,27.5,25.8]; # Graus celsius

  temperatura = temperatura + 273.15;

  # CALCULANDOS OS POLINOMIOS INTERPOLADORES (SPLINES)
  s = spline(hora,temperatura);
  # SUBSTITUINDO VALORES
  xx = min(hora):1:max(hora);
  yy = ppval(s,xx);
  # CALCULANDO VOLUME
  y = yy;

endfunction
# Temperatura do ambiente com o tempo

function y = variacaoTemperaturaPiscina(calorColetorPiscina, calorCapa, densidadeAgua, capacidadeAgua, volumePiscina)
  constante = capacidadeAgua*densidadeAgua*volumePiscina;
  y = (calorColetorPiscina + calorCapa)/constante;
endfunction
# Variação de temperatura da piscina

function y = variacaoTemperaturaOff(calorFornecido, densidadeAgua, capacidadeAgua, volumeColetor)
  y = (calorFornecido)/(densidadeAgua*capacidadeAgua*volumeColetor);
endfunction
# Variação de temperatura da agua do coletor (bomba off ou pouco tempo ligado)

function y = variacaoTemperaturaOn(calorFornecido, vazaoMassia, capacidadeAgua, temperaturaPiscina)
  y = (calorFornecido)/(vazaoMassia*capacidadeAgua) +temperaturaPiscina;
endfunction
# Variação temperatura da agua do coletor (bomba on)


############################# INPUTS ##################################

# ESTADO DA BOMBA
BOMBA = 0; # Estado da bomba ( 0 = DESLIGADO, 1 = LIGAD0 )
tempoLigadoContinuo = 0; # segundos
tempoBombaLigada = 0; # segundos

# AMBIENTE
temperaturaAmbiente = temperaturaAmbiente();

# TEMPO
passo = 1; # Discretização
horaInicio = 32400-10800;
horaFinal = 79200-10800;
periodo = horaInicio:passo:horaFinal;

# PISCINA
temperaturaPiscina(1) = 25 + 273.15; # Temperatura da piscina
t_on = 6 ; # Diferença de temperatura que liga a bomba
t_off = 4 ; # Diferença de temperatura que desliga a bomba
constanteCapa = 0.05; # W/mK
espessuraCapa = 0.00326; # m
A_piscina = 20.4; # m^2
volumePiscina = 15.85; # m^3

# AGUA
pwater = 998; # Kg/m^3
cpwater = 4190; # J/KgK

# COLETOR
temperaturaColetor(1) = 20 + 273.15; # Temperatura coletor
FR = 0.6; # FC
UL = 11.45; # W/m2K
ac = 0.8; # ac
A_coletor = 24; # m^2
volumeAguaColetor = 0.12; # m^3
radiacao = incidenciaRadiacao();

# BOMBA
vazaoVolumetrica = 0.72; # m^3/h
vazaoMassica = (vazaoVolumetrica*pwater)/3600; # kg/s
baixoTempoLigado = pwater*volumeAguaColetor/vazaoMassica; # pouco tempo de bomba ligada
gastoBombaSegundo = 1250; # Wh/h



############################## RESOLVENDO ###############################

interacoes = length(periodo);

for i = 1:1:interacoes
  
  ################################ ESTADO DA BOMBA ################################
  if (temperaturaColetor(i) - temperaturaPiscina(i)) > t_on
    BOMBA = 1;
    tempoLigadoContinuo += 1;
  elseif (temperaturaColetor(i) - temperaturaPiscina(i)) < t_off
    BOMBA = 0;
    tempoLigadoContinuo = 0;
  endif
  

  ################################ PISCINA ################################

  # TEMPERATURA DA CAPA
  t_capa(i) = (temperaturaPiscina(i) + temperaturaAmbiente(i))/2;
  # TAXA DE CALOR TRANSFERIDA PELO AMBIENTE
  Q_capa(i) = constanteCapa*A_piscina*(t_capa(i)-temperaturaPiscina(i))/espessuraCapa;
  # TAXA DE CALOR TRANSFERIDA PELA AGUA AQUECIDA
  if BOMBA == 1
    Q_coletor_piscina(i) = vazaoMassica*cpwater*(temperaturaColetor(i)-temperaturaPiscina(i));
  else
    Q_coletor_piscina(i) = 0;
  endif
  # VARIACAO TEMPERATURA PISCINA
  temperaturaPiscina(i+1) = temperaturaPiscina(i) + passo*variacaoTemperaturaPiscina(Q_coletor_piscina(i), Q_capa(i), pwater, cpwater, volumePiscina);
  
  ################################ COLETOR ################################
  
  # RADIAÇÃO SOLAR ABSORVIDA
  radiacao_abs = ac*radiacao;
  # ENERGIA FORNECIDA A AGUA DO COLETOR
  Q_coletor_agua(i) = A_coletor*FR*(radiacao_abs(i)-UL*(temperaturaColetor(i)-temperaturaAmbiente(i)));
  # VARIAÇÃO TEMPERATURA COLETOR
  if BOMBA == 0
    temperaturaColetor(i+1) = temperaturaColetor(i) + passo*variacaoTemperaturaOff(Q_coletor_agua(i),pwater, cpwater,volumeAguaColetor);
  else
    if tempoLigadoContinuo <= baixoTempoLigado
      temperaturaColetor(i+1) = temperaturaColetor(i) + passo*variacaoTemperaturaOff(Q_coletor_agua(i),pwater, cpwater,volumeAguaColetor);
    else
      temperaturaColetor(i+1) = variacaoTemperaturaOn(Q_coletor_agua(i),vazaoMassica, cpwater, temperaturaPiscina(i));
    endif
  endif
    
endfor


for i = 1:1:length(Q_coletor_piscina)
  if Q_coletor_piscina(i) == 0
      continue
  else
    tempoBombaLigada += 1;
  endif
endfor

############################## RESPONDENDO AS PERGUNATAS ##############################

# LETRA A
disp("A temperatura da piscina as 19 horas é:")
disp(temperaturaPiscina(end))

# LETRA B
periodo_horas = periodo/3600;
temperaturaColetor_plot = temperaturaColetor(2:end)-273.15;
temperaturaPiscina_plot = temperaturaPiscina(2:end)-273.15;

##hold on
##plot(periodo_horas, temperaturaColetor_plot,";Temperatura agua coletor;")
##plot(periodo_horas, temperaturaPiscina_plot,";Temperatura agua piscina;")
##ylabel("Temperatura (Celsius)")
##xlabel("Tempo (Horas)")
##xlim([6 19])
##hold off

# LETRA C
hold on
plot (periodo_horas, Q_capa, ";Calor transferido pela capa;")
plot (periodo_horas, Q_coletor_piscina, ";Calor fornecido a piscina;")
ylabel ("Calor (Joules)");
xlabel ("Hora (h)"); 
xlim([6 19])
hold off

# LETRA D

Energia_total_transferida_piscina = passo*(Q_coletor_piscina(1) + sum(Q_coletor_piscina(2:end-1)) + Q_coletor_piscina(end))/2;
Energia_total_bomba = gastoBombaSegundo*tempoBombaLigada;
COP = Energia_total_transferida_piscina/Energia_total_bomba;

disp("O COP é:")
disp(COP)
