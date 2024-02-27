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
//                              Metodo_Newton_Raphson                  


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
xi = 2
erro = 1e-5
m = (funcao(xi+erro) - funcao(xi))/erro
contador = 0
xf = xi - funcao(xi)/m

while abs(xf-xi) > erro do
    contador = contador + 1
    xi = xf
    m = (funcao(xi+erro) - funcao(xi))/erro
    xf = xi - funcao(xi)/m
end


mprintf("O valor da pressão na bomba é: %f atm\n", xf)
mprintf("O valor da função para esse valor é (prova real): %f\n", funcao(xf))
mprintf("O número de iterações foram: %f\n", contador)
//---------------------------------------------------------------------
