function T = rearranjaX(X_depois,nx,ny)
  
  for i = 1:ny
    T(nx-i+1,:) = X_depois((i-1)*nx+1:i*nx);
  end
  
endfunction
