clc
clear
mode(-1)


//---------------------------------------------------------------------
//                                Aluno                               
//
// Isaac Miranda Camargos RA: 2018.1048-4
//
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//                               Metodo_falsa_posição                  


// CONSTANTES
a = 11 // atm
b = 1.5 // atm.s1,5/m4,5
h = 30 // m
p = 997.1 // kg/m³
L = 500 // m
D = 5.08 // cm
f =  0.03
g = 9.8 // m/s²
patm = 1 // atm
Q = 2 // m³/s

// FUNÇÃO
function f1 = funcao(p2)
    f1 = p2 - patm - a + b*Q**(3/2)
endfunction

xx = 1:0.01:100
plot(xx, funcao(xx))


// FALSA POSIÇÃO
xe = 2
xd = 10
erro = 1e-5
contador = 0

if funcao(xe) < 0 & funcao(xd) > 0 then
    while abs(funcao(xe) - funcao(xd)) > erro do
        contador = contador + 1
        xf = (xe*funcao(xd) - xd*funcao(xe))/(funcao(xd) - funcao(xe))
        if funcao(xf) < 0
            xe = xf
        elseif funcao(xf) > 0
            xd = xf
        else
            break
        end
    end
else
    while abs(funcao(xe) - funcao(xd)) > erro do
        contador = contador + 1
        xf = (xe*funcao(xd) - xd*funcao(xe))/(funcao(xd) - funcao(xe))
        if funcao(xf) < 0
            xd = xf
        elseif funcao(xf) > 0
            xe = xf
        else
            break
        end
    end
end

mprintf("O valor da pressão na bomba é: %f atm\n", xf)
mprintf("O valor da função para esse valor é (prova real): %f\n", funcao(xf))
mprintf("O número de iterações foram: %f\n", contador)
//---------------------------------------------------------------------








































