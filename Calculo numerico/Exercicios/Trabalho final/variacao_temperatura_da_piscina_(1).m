function y = variacao_temperatura_da_piscina(Calor_coletor, Calor_capa, pwater, cpwater, volume_piscina)
  constante = cpwater*pwater*volume_piscina;
  y = (Calor_coletor + Calor_capa)/constante;
endfunction