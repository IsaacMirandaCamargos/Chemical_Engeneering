clc
clear
mode(-1)

// PROBLEMA

// Dois tanques em seríe estão em estado estacionario,
// determine a altura dos dois tanques


// DADOS
Fo = 3 // m³/h
A1 = 2 // m²
A2 = 1 // m²
B1 = 3 // m²/h
B2 = 2 // m²/h

// EQUAÇÕES

function printar(x, y1, y2, cor)
    subplot(2,1,1)
    plot(t, h1_t, cor)
    xtitle("Altura do tanque 1 com o tempo (h1)", "Tempo (h)", "Volume (m³)")
    subplot(2,1,2)
    xtitle("Altura do tanque 2 com o tempo (h2)", "Tempo (h)", "Volume (m³)")
    plot(t, h2_t, cor)
endfunction

// ENCONTRANDO A SOLUÇÃO DO SISTEMA DE EDO's ACIMA (h1, h2) desconhecidos

function y = funcao(t, xi)
    global Fo, A1, A2, B1, B2
    h1 = xi(1)
    h2 = xi(2)
    y(1) = (Fo/A1) - (B1*h1)/A1
    y(2) = (B1*h1)/A2 - (B2*h2)/A2
endfunction


scf(0)
clf
xi = [[0;0],[0;2], [2;2], [1;1], [4;5]]
colors = ["r", "b", "g", "m", "y"]
for i = 1:1:5
    t = [0:0.01:6]
    xf = ode(xi(:,i), t(1), t, funcao)
    h1_t = xf(1,:)
    h2_t = xf(2,:)
    
    printar(t, h1_t, h2_t, colors(i))
end

subplot(2,1,1)
legend(["CI1: [0;0]", "CI2: [0;2]", "CI3: [2;2]", "CI4: [1;1]", "CI5: [4;5]"])
subplot(2,1,2)
legend(["CI1: [0;0]", "CI2: [0;2]", "CI3: [2;2]", "CI4: [1;1]", "CI5: [4;5]"])


