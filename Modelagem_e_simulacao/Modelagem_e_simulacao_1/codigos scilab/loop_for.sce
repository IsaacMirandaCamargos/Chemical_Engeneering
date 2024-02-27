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

for i = 1:1:length(V)
    if V(i) <= 120 then
        mprintf("O reator %i é subdimensionado, seu volume é %0.2f\n", i, V(i))
    elseif V(i) > 120 & V(i) <= 150
        mprintf("O reator %i está dentro das especificações, seu volume é %0.2f\n", i, V(i))
    else
        mprintf("O reator %i está superdimensionado, seu volume é %0.2f\n", i, V(i))
    end
end




