function y = energia_fornecida_pelo_coletor(area_coletor, fator_de_remocao, taxa_radicao_absorvida, perdas, temperatura_aquecida, temperatura_ambiente)
  y = area_coletor*fator_de_remocao*(taxa_radicao_absorvida - perdas*(temperatura_aquecida-temperatura_ambiente);
endfunction