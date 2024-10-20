function A = matrizA(nx,ny,dx,dy)

Ae = 1/(dx^2);%leste
Aw = 1/(dx^2);%oeste
An = 1/(dy^2);%norte
As = 1/(dy^2);%sul
Ap = -2/(dx^2) - 2/(dy^2);%ponto central

A = zeros(nx*ny,nx*ny);%inicialização da matriz A
k = 1;%indexador
for n=1:ny%linhas
    for m=1:nx%colunas     
        if (m==1 && n==1)%Células do tipo T1
            A(k,k) = Ap;      %Ap
            A(k,k+1) = Ae;    %Ae
            A(k,k+nx) = As;   %As
        elseif (m>1 && m<nx && n==1)%Células do tipo T2
            A(k,k) = Ap;     %Ap
            A(k,k-1) = Aw;   %Aw
            A(k,k+1) = Ae;   %Ae
            A(k,k+nx) = As;  %As
        elseif (m==nx && n==1)%Células do tipo T3
            A(k,k) = Ap;     %Ap
            A(k,k-1) = Aw;   %Aw
            A(k,k+nx) =  As; %As
        elseif (m==1 && n>1 && n<ny)%Células do tipo T4
            A(k,k) = Ap;     %Ap
            A(k,k-nx) = An;  %An           
            A(k,k+1) = Ae;   %Ae
            A(k,k+nx) =  As; %As
        elseif (m>1 && m<nx && n>1 && n<ny)%Células do tipo T5
            A(k,k-nx) =  An; %An
            A(k,k-1)  =  Aw; %Aw
            A(k,k)    =  Ap; %Ap
            A(k,k+1)  =  Ae; %Ae
            A(k,k+nx) =  As; %As
        elseif (m==nx && n>1 && n<ny)%Células do tipo T6
            A(k,k-nx) = An;   %An
            A(k,k-1)  = Aw;   %Aw
            A(k,k)    = Ap;   %Ap
            A(k,k+nx) = As;   %As
        elseif (m==1 && n==ny)%Células do tipo T7
            A(k,k) = Ap;      %Ap
            A(k,k+1) = Ae;    %Ae
            A(k,k-nx) = An;   %An
        elseif (m>1 && m<nx && n==ny)%Células do tipo T8
            A(k,k)    = Ap; %Ap
            A(k,k-1)  = Aw; %Aw
            A(k,k+1)  = Ae; %Ae
            A(k,k-nx) = An; %An
        elseif (m==nx && n==ny)%Células do tipo T9
            A(k,k) = Ap;     %Ap
            A(k,k-1) = Aw;   %Aw
            A(k,k-nx) = An; %An
        endif
        k = k + 1;
    endfor
endfor

endfunction
