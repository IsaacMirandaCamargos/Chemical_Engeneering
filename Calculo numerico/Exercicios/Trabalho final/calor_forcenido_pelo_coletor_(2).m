function y = calor_forcenido_pelo_coletor(vazaoM, cp, T_Coletor, T_piscina)
  y = vazaoM*Cp*(T_Coletor-T_piscina);
endfunction