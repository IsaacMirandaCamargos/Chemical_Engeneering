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
MMx = 25.13
MMs = 180


function r=balanco_componente(x)
    a=x(1)
    b=x(2)
    c=x(3)
    d=x(4)
    e=x(5)
    
    
   
    r(1)= c + d -6
    r(2)= -3*b -12 + c* 1.79+ e *2
    r(3)= 0.56*c +2*d + e -6 - 2*a
    r(4)= -b + 0.17 *c
    r(5)= 0.37 * MMs - c * MMx
    
endfunction

xchute=[0.1;0.1;0.1;0.1;0.1]
[sol,v,info]=fsolve(xchute, balanco_componente)
if info==1 then
    mprintf(' Solução do balanço por componente:\n\n')
    mprintf(' a : %f\n', sol(1))
    mprintf(' b : %f\n', sol(2))
    mprintf(' c : %f\n', sol(3))
    mprintf(' d : %f\n', sol(4))
    mprintf(' e : %f\n', sol(5))
    
else
    disp('Tente novamente!')
end

