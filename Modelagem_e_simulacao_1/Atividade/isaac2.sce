clear
clc
mode(-1)


// ANALISANDO OS DADOS
Texp=[-36.7;-19.6;-11.5;-2.6;7.6;15.4;26.1;42.2;60.6;80.1]; Texp=Texp+273.15
Pexp=[1;5;10;20;40;60;100;200;400;760]


// DEFININDO FUNÇÕES
function P = func(A, B, C, T)
    P = 10^(A + B./(T+C))
endfunction

function E = func_erro(x)
    global Texp, Pexp
    A = x(1)
    B = x(2)
    C = x(3)
    E = 10^(A + B./(Texp+C)) - Pexp
endfunction

// ENCONTRANDO VALORES DE A, B, C QUE OTIMIZAM A RESPOSTA
menor = 10^20
c = 0
try
    for x1=0:500:1000
        for x2=0:500:1000
           for x3=0:500:1000
               //c = c +1; disp(c)
               xatual = [x1, x2, x3]
               [fopt, xopt]= leastsq(func_erro,xatual)
               //erro = sum(abs(func_erro(xopt)))
               erro = sum(abs(fopt))
               if erro < menor
                   menor = erro
                   xm = xopt
              end
           end
        end
    end
end


mprintf("Os valores de A, B e C são respectivamente:\n%f\n%f\n%f\n", xm(1), xm(2), xm(3))
//disp(sum(abs(func_erro(xm))))


