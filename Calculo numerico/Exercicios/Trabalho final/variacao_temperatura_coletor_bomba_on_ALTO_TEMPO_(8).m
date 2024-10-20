function y = variacao_temperatura_coletor_bomba_on_ALTO_TEMPO(calor_fornecido, vazao_massica, cpwater, temperatura_piscina)
  y = (calor_fornecido)/(vazao_massica*cpwater) +temperatura_piscina;
endfunction
