function y = variacao_temperatura_coletor_bomba_off(calor_fornecido, pwater, cpwater, volume_coletor)
  y = (calor_fornecido)/(pwater*cpwater*volume_coletor);
endfunction
