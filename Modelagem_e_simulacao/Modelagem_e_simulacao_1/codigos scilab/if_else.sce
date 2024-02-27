//Por questões de espaço físico da unidade reacional, o reator não pode
//ultrapassar 150 L, porém, caso ele seja menor que 120 L a conversão
//do sistema será muito baixa. Assim sendo, classifique os reatores
//projetados anteriormente de acordo com a tabela a seguir:


clc
clear
mode(-1)

// VARIAVEIS 

dados = [12.5, 0.65; 15.0, 0.65; 22.45, 0.95]
Q = dados(: , 1) // VETOR
X = dados(:, 2) // VETOR
Cao = 0.45 // mol/L
Fao = Q*Cao // VETOR
K = 0.21 // 1/min

// VOLUME

_Ra = K*(Cao*(1-X))
V = Fao.*X./_Ra

if V(1) <= 120 then
    disp("O reator 1 é subdimensionado", V(1))
elseif V(1) > 120 & V(1) <= 150
    disp("O reator 1 está dentro das especificações", V(1))
else
    disp("O reator 1 está superdimensionado", V(1))
end

if V(2) <= 120 then
    disp("O reator 2 é subdimensionado", V(2))
elseif V(2) > 120 & V(2) <= 150
    disp("O reator 2 está dentro das especificações", V(2))
else
    disp("O reator 2 está superdimensionado", V(2))
end

if V(3) <= 120 then
    disp("O reator 3 é subdimensionado", V(3))
elseif V(3) > 120 & V(3) <= 150
    disp("O reator 3 está dentro das especificações", V(3))
else
    disp("O reator 3 está superdimensionado", V(3))
end




