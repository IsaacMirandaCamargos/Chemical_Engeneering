clear
clc

############################# FUNCOES ##################################
function y = incidencia_de_radiacao()

  tempo = [32400 36000 39600	43200	46800	50400	54000	57600	61200	64800	68400	72000	75600	79200];
  radiacao_incidente = [0,144.52,929.58,1834.64,1803.24,2297.38,2361.13,2872.26,3586.55,3124.73,1784.52,1364.89,830.81,123.55]; # kJ/h.m^2
  
  radiacao_incidente = radiacao_incidente*1000/3600; # W/m^2

  # CALCULANDOS OS POLINOMIOS INTERPOLADORES (SPLINES)
  s = spline(tempo,radiacao_incidente);
  # SUBSTITUINDO VALORES
  xx = min(tempo):1:max(tempo);
  yy = ppval(s,xx);
  # CALCULANDO VOLUME
  y = yy;
endfunction
# Incidencia de radiacao

function y = temperatura_com_tempo()
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

function y = variacao_temperatura_da_piscina(Calor_coletor, Calor_capa, pwater, cpwater, volume_piscina)
  constante = cpwater*pwater*volume_piscina;
  y = (Calor_coletor + Calor_capa)/constante;
endfunction
# Variação de temperatura da piscina

function y = variacao_temperatura_coletor_bomba_off(calor_fornecido, pwater, cpwater, volume_coletor)
  y = (calor_fornecido)/(pwater*cpwater*volume_coletor);
endfunction
# Variação de temperatura da agua do coletor (bomba off ou pouco tempo ligado)

function y = variacao_temperatura_coletor_bomba_on_ALTO_TEMPO(calor_fornecido, vazao_massica, cpwater, temperatura_piscina)
  y = (calor_fornecido)/(vazao_massica*cpwater) +temperatura_piscina;
endfunction
# Variação temperatura da agua do coletor (bomba on)


############################# INPUTS ##################################

# ESTADO DA BOMBA
BOMBA = 0; # Estado da bomba ( 0 = DESLIGADO, 1 = LIGAD0 )
tempo_ligado = 0; # segundos
tempo_total_bomba_ligada = 0; # segundos

# AMBIENTE
t_ambiente = temperatura_com_tempo();

# TEMPO
dt = 1; # Discretização
Hora_i = 32400-10800;
Hora_f = 79200-10800;
periodo = Hora_i:dt:Hora_f;

# PISCINA
t_piscina(1) = 25 + 273.15; # Temperatura da piscina
t_on = 6 ; # Diferença de temperatura que liga a bomba
t_off = 4 ; # Diferença de temperatura que desliga a bomba
k_capa = 0.05; # W/mK
espessura_capa = 0.00326; # m
A_piscina = 20.4; # m^2
V_piscina = 15.85; # m^3

# AGUA
pwater = 998; # Kg/m^3
cpwater = 4190; # J/KgK

# COLETOR
t_coletor(1) = 20 + 273.15; # Temperatura coletor
fator_de_absorcao_coletor = 0.6; # FC
perda_de_calor_global = 11.45; # W/m2K
absorvidade_do_material_do_coletor = 0.8; # ac
A_coletor = 24; # m^2
V_agua_coletor = 0.12; # m^3
radiacao = incidencia_de_radiacao();

# BOMBA
vazao_volumetrica = 0.72; # m^3/h
vazao_massica = (vazao_volumetrica*pwater)/3600; # kg/s
pouco_tempo_ligado = pwater*V_agua_coletor/vazao_massica; # pouco tempo de bomba ligada
gasto_hora = 1250; # Wh/h
gasto_segundo = gasto_hora; # Ws/s # Eb


############################## RESOLVENDO ###############################

n = length(periodo);

for i = 1:1:n
  
  ################################ ESTADO DA BOMBA ################################
  if (t_coletor(i) - t_piscina(i)) > t_on
    BOMBA = 1;
    tempo_ligado += 1;
  elseif (t_coletor(i) - t_piscina(i)) < t_off
    BOMBA = 0;
    tempo_ligado = 0;
  endif

  
  ################################ PISCINA ################################

  # TEMPERATURA DA CAPA
  t_capa(i) = (t_piscina(i) + t_ambiente(i))/2;
  # TAXA DE CALOR TRANSFERIDA PELO AMBIENTE
  Q_capa(i) = k_capa*A_piscina*(t_capa(i)-t_piscina(i))/espessura_capa;
  # TAXA DE CALOR TRANSFERIDA PELA AGUA AQUECIDA
  if BOMBA == 1
    Q_coletor_piscina(i) = vazao_massica*cpwater*(t_coletor(i)-t_piscina(i));
  else
    Q_coletor_piscina(i) = 0;
  endif
  # VARIACAO TEMPERATURA PISCINA
  t_piscina(i+1) = t_piscina(i) + dt*variacao_temperatura_da_piscina(Q_coletor_piscina(i), Q_capa(i), pwater, cpwater, V_piscina);
  
  ################################ COLETOR ################################
  
  # RADIAÇÃO SOLAR ABSORVIDA
  radiacao_abs = absorvidade_do_material_do_coletor*radiacao;
  # ENERGIA FORNECIDA A AGUA DO COLETOR
  Q_coletor_agua(i) = A_coletor*fator_de_absorcao_coletor*(radiacao_abs(i)-perda_de_calor_global*(t_coletor(i)-t_ambiente(i)));
  # VARIAÇÃO TEMPERATURA COLETOR
  if BOMBA == 0
    t_coletor(i+1) = t_coletor(i) + dt*variacao_temperatura_coletor_bomba_off(Q_coletor_agua(i),pwater, cpwater,V_agua_coletor);
  else
    if tempo_ligado <= pouco_tempo_ligado
      t_coletor(i+1) = t_coletor(i) + dt*variacao_temperatura_coletor_bomba_off(Q_coletor_agua(i),pwater, cpwater,V_agua_coletor);
    else
      t_coletor(i+1) = variacao_temperatura_coletor_bomba_on_ALTO_TEMPO(Q_coletor_agua(i),vazao_massica, cpwater, t_piscina(i));
    endif
  endif
    
endfor


for i = 1:1:length(Q_coletor_piscina)
  if Q_coletor_piscina(i) == 0
      continue
  else
    tempo_total_bomba_ligada += 1;
  endif
endfor

############################## RESPONDENDO AS PERGUNATAS ##############################

# LETRA A
disp("A temperatura da piscina as 19 horas é:")
disp(t_piscina(end))

# LETRA B
periodo_horas = periodo/3600;
t_coletor_plot = t_coletor(2:end)-273.15;
t_piscina_plot = t_piscina(2:end)-273.15;

hold on
plot(periodo_horas, t_coletor_plot,";Temperatura agua coletor;")
plot(periodo_horas, t_piscina_plot,";Temperatura agua piscina;")
ylabel("Temperatura (Celsius)")
xlabel("Tempo (Horas)")
xlim([6 19])
hold off

# LETRA C
##hold on
##plot (periodo_horas, Q_capa, ";Calor transferido pela capa;")
##plot (periodo_horas, Q_coletor_piscina, ";Calor fornecido a piscina;")
##ylabel ("Calor (Joules)");
##xlabel ("Hora (h)"); 
##xlim([6 19])
##hold off

# LETRA D

Energia_total_transferida_piscina = dt*(Q_coletor_piscina(1) + sum(Q_coletor_piscina(2:end-1)) + Q_coletor_piscina(end))/2;
Energia_total_bomba = gasto_segundo*tempo_total_bomba_ligada;
COP = Energia_total_transferida_piscina/Energia_total_bomba;

disp("O COP é:")
disp(COP)
