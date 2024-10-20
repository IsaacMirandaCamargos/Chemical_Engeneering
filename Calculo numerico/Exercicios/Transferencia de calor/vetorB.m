function b = vetorB(nx,ny,dx,dy)

Te = 100/dx^2;%leste
Tw = 0/dx^2;%oeste
Tn = 25/dy^2;%norte
Ts = 75/dy^2;%sul

k = 1;
b = zeros(nx*ny,1);

for n=1:ny
    for m=1:nx      
        if (m==1 && n==1)%Células do tipo T1
            b(k) = -Te-Tn;
        elseif (m>1 && m<nx && n==1)%Células do tipo T2
            b(k) = -Tn;
        elseif (m==nx && n==1)%Células do tipo T3
            b(k) = -Tn-Tw;
        elseif (m==1 && n>1 && n<ny)%Células do tipo T4
            b(k) = -Te;
        elseif (m>1 && m<nx && n>1 && n<ny)%Células do tipo T5
            b(k) = 0;
        elseif (m==nx && n>1 && n<ny)%Células do tipo T6
            b(k) = -Tw;
        elseif (m==1 && n==ny)%Células do tipo T7
            b(k) = -Te-Ts;
        elseif (m>1 && m<nx && n==ny)%Células do tipo T8
            b(k) = -Ts;
        elseif (m==nx && n==ny)%Células do tipo T9
            b(k) = -Ts-Tw;
        endif
        k = k + 1;
    endfor
endfor

endfunction
