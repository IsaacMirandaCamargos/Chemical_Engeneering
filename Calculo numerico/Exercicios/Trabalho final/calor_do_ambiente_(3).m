function y = Calor_do_ambiente(Kcapa, Area_piscina, T_capa, T_piscina, espessura_capa)
  y = Kcapa*Area_piscina*(T_capa-T_piscina)/espessura_capa;
endfunction