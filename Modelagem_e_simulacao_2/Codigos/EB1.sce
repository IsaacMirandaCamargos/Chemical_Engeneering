//------------------------------------------------------------------------------
//                                DESCRIÇÃO
//------------------------------------------------------------------------------
//Estudo de funções do Scilab
//Exemplo 1: Reator CSTR isotérmico com reação em série paralelo pag. 17 
//Autor:Nádia 
//Data:04/01/2023
//------------------------------------------------------------------------------
//                             PRÉ-PROCESSAMENTO
//------------------------------------------------------------------------------
clc
clear
mode(-1)
//------------------------------------------------------------------------------
//                             Balanço de eletrons
//------------------------------------------------------------------------------
MMx = 23.71
MMs = 92
Ybs = 0.4
cinzas = 0.08; cinzas = 1 - cinzas

function f=balanco_eletron(x)
    a=x(1)
    c=x(2)
    f(1)= 4.23*c +4*a - 14
    f(2)= cinzas*MMs*Ybs - MMx*c
endfunction

xchute=[0.1;0.1]
[sol,v,info]=fsolve(xchute, balanco_eletron)
if info==1 then
    mprintf(' Solução do balanço de eletrons:\n\n')
    mprintf(' a : %f\n', sol(1))
    mprintf(' c : %f\n\n', sol(2))
    
else
    disp('Tente novamente!')
end
//------------------------------------------------------------------------------
//                             Balanço por componente
//------------------------------------------------------------------------------
MMx = 25.5
MMs = 162
MMp = 86


function r=balanco_componente(x)
    a=x(1)
    b=x(2)
    c=x(3)
    d=x(4)
    e=x(5)
    f=x(6)
    
    
   
    r(1)= 0.78571*c*MMx - f*MMp
    r(2)= c + d + 4*f - 6
    r(3)= -3*b + 2*c + 6*f + 2*e - 10
    r(4)= -2*a + 0.5*c + 2*d + e + 2*f - 5
    r(5)= -b + 0.25*c
    r(6)= 1.3*a - d
endfunction

xchute=[0.1;0.1;0.1;0.1;0.1;0.1]
[sol,v,info]=fsolve(xchute, balanco_componente)

if info==1 then
    mprintf(' Solução do balanço por componente:\n\n')
    mprintf(' a : %f\n', sol(1))
    mprintf(' b : %f\n', sol(2))
    mprintf(' c : %f\n', sol(3))
    mprintf(' d : %f\n', sol(4))
    mprintf(' e : %f\n', sol(5))
    mprintf(' f : %f\n', sol(6))
        
else
    disp('Tente novamente!')
end

