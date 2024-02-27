
//------------------------------------------------------------------------------
//                                DESCRIÇÃO
//------------------------------------------------------------------------------
//Autor:Nicole Maia Argondizzi
//------------------------------------------------------------------------------
//                             PRÉ-PROCESSAMENTO
//------------------------------------------------------------------------------
clc
clear
mode(-1)

//----------->Entrada de dados
//Parâmetros
Tin = 22 + 273.15 //K
Tjin = 22 + 273.15//K
Ta = 26 + 273.15//K
Cain= 1 //mol/L
UA=4.68 //kJ.K/min
UAra=0.6 //kJ.K/min
UAja=0.13 //kJ.K/min
Pemax=180 //kJ/min
ko=5e8 //1/min
E_R = 8800 //K
deltaH=580 //kJ/mol
V=8.74 //L
Vj=2.06 //L
Cp = 4.2 //kJ.kg/K
rho=1//kg/L
F = 0.3//L/min
Fj=1 //L/min

// Condições iniciais
To=350 //K
Tjo=283 //K
Cao = 2 //mol/L

//------------------------------------------------------------------------------
//                             FUNÇÕES
//------------------------------------------------------------------------------
function f=ee(xi)
     Ca = xi(1)
    T = xi(2)   
    Tj = xi(3)
    
    //Pe
    Pe = deltaH*ko*exp(-E_R/T)*Ca*V
    
    //Ca
    f(1)= (F/V)*(Cain-Ca)-(Pe/(deltaH*V))
   
    //T
    f(2)= (F/V) * (Tin-T) - (UA/(Cp*rho*V))*(T-Tj) - (UAra/(Cp*rho*V))*(T-Ta) + (Pe/(Cp*rho*V))
    
    //Tj
    f(3)= (Fj/Vj) * (Tjin-Tj) + (UA/(Cp*rho*Vj))*(T-Tj) - (UAja/(Cp*rho*Vj))*(Tj-Ta)
    
endfunction

function f=din(t,xi)
     Ca = xi(1)
    T = xi(2)   
    Tj = xi(3)
    
    //Pe
    Pe = deltaH*ko*exp(-E_R/T)*Ca*V
    
    //Ca
    f(1)= (F/V)*(Cain-Ca)-(Pe/(deltaH*V))
   
    //T
    f(2)= (F/V) * (Tin-T) - (UA/(Cp*rho*V))*(T-Tj) - (UAra/(Cp*rho*V))*(T-Ta) + (Pe/(Cp*rho*V))
    
    //Tj
    f(3)= (Fj/Vj) * (Tjin-Tj) + (UA/(Cp*rho*Vj))*(T-Tj) - (UAja/(Cp*rho*Vj))*(Tj-Ta)
endfunction

function f=din_lin(t,xbar,A)
    f=A*xbar
endfunction
//------------------------------------------------------------------------------
//                              PROGRAMA PRINCIPAL
//------------------------------------------------------------------------------

//----------->Processamento
//Estado estacionário
xestima=[1;200;200]
[sol,fsol,info]=fsolve(xestima,ee)
if  info==1 then
    disp('Solução Estado estacionário')
    disp(sol)
end



//Avaliando o sistema
J=numderivative(ee,sol);
disp("Matriz J:");
disp(J);

L = real(spec(J));

disp("Auto Valores:");
disp(L);

// Inicializando variáveis de controle
estavel = 0;
marginalmenteEstavel = 0;
instavel = 0;

for i = 1:length(L)
    if L(i) < 0 then
        estavel = 1;
    elseif L(i) == 0 then
        marginalmenteEstavel = 1;
    else
        instavel = 1;
    end
end

// Imprimindo os resultados após a análise de todos os dados
if estavel == 1 then
    disp("O sistema é estável.");
end
if marginalmenteEstavel == 1 then
    disp("O sistema é marginalmente estável.");
end
if instavel == 1 then
    disp("O sistema é instável.");
end

// Avaliando o condicionamento do modelo

P = abs(max(L))/abs(min(L))
disp("Análise de Autovalor P",P)

N= norm(J)*inv(norm(J))
disp("Análise da norma N",N)

CN = abs(max(sqrt(spec(J*J'))))/(abs(min(sqrt(spec(J*J')))))
disp("Análise do valor singular",CN)

if P<100 && N<100 && CN<100 then
    disp("Bem condicionado")
else
    disp("Mal condicionado")
end

//----------->Fim do programa
disp('***FIM***')
