clear
format long
clc


function y = f(x);
  Ti = 533.15;
  y = (29.747492*(x- Ti)) + (25108.28*((x^2) - (Ti^2))) - (0.00001546404/(Ti - x)) - 37218;
endfunction

disp(f(1250))



# 0.463919002168567