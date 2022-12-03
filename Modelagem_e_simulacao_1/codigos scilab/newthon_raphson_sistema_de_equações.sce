clc
clear
mode(-1)


//---------------------------------------------------------------------
//                                Aluno                               
//
// Isaac Miranda Camargos RA: 2018.1048-4
// Lucas Eduardo Duarte Martins RA: 2018.1099-4
// Raul Cezar Serafin Manzan RA: 2019.1104-1
//
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//           Metodo_Newton_Raphson_para_sistema_de_equações            


// CONSTANTES
Fe = 0.00948 // m³/s
Fs = 0.00948 // m³/s
k = 0.00278 // 1/s
T = 922 // K
P = 11.4 // atm
V = 0.01704 // m³

// CONCENTRAÇÕE
Cae = 1 // mol/L
Cbe = 0 // mol/L
Cce = 0 // mol/L
Cie = 1/2 // mol/L

Cae = 1000 // mol/m³
Cbe = 0 // mol/m³
Cce = 0 // mol/m³
Cie = 1000/2 // mol/m³

// FUNÇÕES 1
function f1 = func1(Ca, Cb, Cc, Ci)
    f1 = (Cae*Fe - Ca*Fs)/V - k*Ca
endfunction

function f2 = func2(Ca, Cb, Cc, Ci)
    f2 = -Cb*Fs/V + k*Ca
endfunction

function f3 = func3(Ca, Cb, Cc, Ci)
    f3 = -Cc*Fs/V + 3*k*Ca/2
endfunction

function f4 = func4(Ca, Cb, Cc, Ci)
    f4 = (Cie*Fe-Ci*Fs)/V
endfunction

// FUNÇÕES 2
function f1 = func1_(Xi)
    Ca = Xi(1)
    Cb = Xi(2)
    Cc = Xi(3)
    Ci = Xi(4)
    f1 = (Cae*Fe - Ca*Fs)/V - k*Ca
endfunction

function f2 = func2_(Xi)
    Ca = Xi(1)
    Cb = Xi(2)
    Cc = Xi(3)
    Ci = Xi(4)
    f2 = -Cb*Fs/V + k*Ca
endfunction

function f3 = func3_(Xi)
    Ca = Xi(1)
    Cb = Xi(2)
    Cc = Xi(3)
    Ci = Xi(4)
    f3 = -Cc*Fs/V + 3*k*Ca/2
endfunction

function f4 = func4_(Xi)
    Ca = Xi(1)
    Cb = Xi(2)
    Cc = Xi(3)
    Ci = Xi(4)
    f4 = (Cie*Fe-Ci*Fs)/V
endfunction

function J = jacobiano(Xi, erro)
    Ca = Xi(1)
    Cb = Xi(2)
    Cc = Xi(3)
    Ci = Xi(4)
    J(1,:) = [(func1(Ca+erro, Cb, Cc, Ci)-func1(Ca, Cb, Cc, Ci))/erro, ...
              (func1(Ca, Cb+erro, Cc, Ci)-func1(Ca, Cb, Cc, Ci))/erro, ...
              (func1(Ca, Cb, Cc+erro, Ci)-func1(Ca, Cb, Cc, Ci))/erro, ...
              (func1(Ca, Cb, Cc, Ci+erro)-func1(Ca, Cb, Cc, Ci))/erro]
              
     J(2,:) = [(func2(Ca+erro, Cb, Cc, Ci)-func2(Ca, Cb, Cc, Ci))/erro, ...
               (func2(Ca, Cb+erro, Cc, Ci)-func2(Ca, Cb, Cc, Ci))/erro, ...
               (func2(Ca, Cb, Cc+erro, Ci)-func2(Ca, Cb, Cc, Ci))/erro, ...
               (func2(Ca, Cb, Cc, Ci+erro)-func2(Ca, Cb, Cc, Ci))/erro]
               
     J(3,:) = [(func3(Ca+erro, Cb, Cc, Ci)-func3(Ca, Cb, Cc, Ci))/erro, ...
               (func3(Ca, Cb+erro, Cc, Ci)-func3(Ca, Cb, Cc, Ci))/erro, ...
               (func3(Ca, Cb, Cc+erro, Ci)-func3(Ca, Cb, Cc, Ci))/erro, ...
               (func3(Ca, Cb, Cc, Ci+erro)-func3(Ca, Cb, Cc, Ci))/erro]
               
     J(4,:) = [(func4(Ca+erro, Cb, Cc, Ci)-func4(Ca, Cb, Cc, Ci))/erro, ...
               (func4(Ca, Cb+erro, Cc, Ci)-func4(Ca, Cb, Cc, Ci))/erro, ...
               (func4(Ca, Cb, Cc+erro, Ci)-func4(Ca, Cb, Cc, Ci))/erro, ...
               (func4(Ca, Cb, Cc, Ci+erro)-func4(Ca, Cb, Cc, Ci))/erro]
endfunction

erro = 1e-5
Xi = [Cae; Cbe; Cce; Cie]
Y = [func1_(Xi); func2_(Xi); func3_(Xi); func4_(Xi)]
J = jacobiano(Xi, erro)
Xf = Xi - inv(J)*Y
contador = 0

while abs(max(Xf - Xi)) > erro do
    contador = contador + 1
    Xi = Xf
    Y = [func1_(Xi); func2_(Xi); func3_(Xi); func4_(Xi)]
    J = jacobiano(Xi, erro)
    Xf = Xi - inv(J)*Y
end

mprintf(" Concentrações de A, B, C, I respectivamente:\n")
mprintf(" A: %f mol/L\n B: %f mol/L\n C: %f mol/L\n D: %f mol/L\n", Xf(1)/1000, ...
        Xf(2)/1000, Xf(3)/1000, Xf(4)/1000)
mprintf("\n")
mprintf(" Prova real de que as funções zeraram")
disp([func1_(Xf); func2_(Xf); func3_(Xf); func4_(Xf)])
mprintf("\n")
mprintf(" O número de iterações foram: %f\n", contador)
//---------------------------------------------------------------------
//           Estudo da relação dos volumes e concentrações             

V_vector = [0.0001:0.1:100]
for i = 1:1:length(V_vector)
    V = V_vector(i)
    erro = 1e-5
    Xi = [Cae; Cbe; Cce; Cie]
    Y = [func1_(Xi); func2_(Xi); func3_(Xi); func4_(Xi)]
    J = jacobiano(Xi, erro)
    Xf = Xi - inv(J)*Y
    contador = 0
    
    while abs(max(Xf - Xi)) > erro do
        contador = contador + 1
        Xi = Xf
        Y = [func1_(Xi); func2_(Xi); func3_(Xi); func4_(Xi)]
        J = jacobiano(Xi, erro)
        Xf = Xi - inv(J)*Y
    end
    
    result(:,i) = Xf/1000
end

scf(0)
clf(0)
xtitle("Concentração de cada componente", "$Volume [m³]$", "$Concentração [mol/L]$" )
plot(V_vector, result(1,:), "r")
plot(V_vector, result(2,:), "b")
plot(V_vector, result(3,:), "y")
plot(V_vector, result(4,:), "g")
legend(["Fosfina [PH3]", "Fosforo [P]", "Hidrogênio [H2]", "Inerte"],5)


























 






