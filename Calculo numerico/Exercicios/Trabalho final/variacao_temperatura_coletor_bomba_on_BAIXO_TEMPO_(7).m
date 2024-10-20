function y = variacao_temperatura_coletor_bomba_on_BAIXO_TEMPO(calor_fornecido, pwater, cpwater,temperatura_piscina)
  y = (calor_fornecido)/(pwater*cpwater*volume_coletor);
endfunction