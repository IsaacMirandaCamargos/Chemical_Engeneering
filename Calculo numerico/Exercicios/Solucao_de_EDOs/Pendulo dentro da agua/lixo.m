clear
clc

x = 2;
z = 2;

function y = print()
  global x
  global z
  y = x*z
endfunction

print()