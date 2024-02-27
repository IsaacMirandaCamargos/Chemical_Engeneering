// Analise de bifurcação
//Nome: Nicole Maia Argondizzi
//Data:23/08/2023

clc
clear
mode(-1)

mimax = 0.53 //h-1
km = 0.12
k1 = 0.4545
Sf = 4
Y = 0.4



function f=ee(x,mimax,km,k1,Sf,Y,D)
    X=x(1)
    S=x(2)
    mi= mimax*S/(km+S+k1*S^2)
    
    f(1)=(mi-D)*X
    f(2)=D*(Sf-S)-mi*X/Y
    
endfunction


function f=din(t,x,mimax,km,k1,Sf,Y,D)
    X=x(1)
    S=x(2)
    mi= mimax*S/(km+S+k1*S^2)
    
    f(1)=(mi-D)*X
    f(2)=D*(Sf-S)-mi*X/Y
    
endfunction


for D=0:0.01:1
    lista = list(ee,mimax,km,k1,Sf,Y,D)
    xchute = [1.5;0.17]//[0.99;1.51]//[0.1;4] 
    [sol,v,info] = fsolve(xchute,lista)
    if info == 1 then
        scf(0)
        plot(D,sol(1),'ro')
        plot(D,sol(2),'bo')
        xtitle('Bifurcação','D','X/S')
        legend(['X','S'])
        
    end    
end
D=0.3
t=0:0.01:20
xinicial= [1.1;1.7]
xi=ode(xinicial,t(1),t,din)

scf(1)
clf()

plot(t,xi(1,:),"g")
plot(t,xi(2,:),"r")
xtitle('Bifurcação','Tempo','X/S')
legend(['X','S'])
xgrid(0)


function A=matA(sol)
    X=sol(1)
    S=sol(2)
    mi=(mimax*S)/(km+S+k1*S^2)
    A(1,1)=mi-D
    A(1,2)=X*(mimax*(km+S+k1*S^2)-mimax*S*(1+2*k1*S))/((km+S+k1*S^2)^2)
    A(2,1)=-mi*(1/Y)
    A(2,2)=-D-(X/Y)*(mimax(km+S+k1*S^2)-mimax*S*(1+2*k1*S))/((km+S+k1*S^2)^2)
endfunction

function dxbarradt=linear(t,xbar,J)
    dxbarradt=J*xbar
endfunction

D=0.3

lista = list(ee,mimax,km,k1,Sf,Y,D)

x1=[0;175]
[sol1,v,info] = fsolve(x1,lista)

x2=[0.995;1.512]
[sol2,v,info] = fsolve(x2,lista)

x3=[1.523;4]
[sol3,v,info] = fsolve(x3,lista)


for i=0:1:2
    if  i==0 then
        sol=sol1
        A=matA(sol)
        V=spec(A)
        disp("Os autovalores da matriz jacobiana para o 1º EE são:")
        disp(V)

        cont=0
        for j=1:length(V)
            if real(V(j))>0 then
            disp("O modelo é instável no ponto de linearização!")
             break
            else
             cont=cont+1         
             end
             if cont==length(V) then
              disp("O modelo é estável no ponto de linearização!")
             end 
        end
        end
    if i==1 then
        sol=sol2
        A=matA(sol)
        V=spec(A)
        disp("Os autovalores da matriz jacobiana para o 2º EE são:")
        disp(V)

        cont=0
        for j=1:length(V)
             if real(V(j))>0 then
             disp("O modelo é instável no ponto de linearização!")
             break
             else
             cont=cont+1         
             end
             if cont==length(V) then
             disp("O modelo é estável no ponto de linearização!")
             end 
        end
        end
    if i==2 then
       sol=sol3
          A=matA(sol)
        V=spec(A)
        disp("Os autovalores da matriz jacobiana para o 3º EE são:")
        disp(V)

        cont=0
        for j=1:length(V)
            if real(V(j))>0 then
            disp("O modelo é instável no ponto de linearização!")
            break
            else
            cont=cont+1         
            end
            if cont==length(V) then
            disp("O modelo é estável no ponto de linearização!")
            end 
        end
end
end

// Qual seria a melhor faixa de operação para o parâmetro de diluição?
// D = 0.3; X1 = 0; X2= 0.995; X3 =  1.523; Y1=0.175; Y2=1.512; Y3=4
// O melhor ponto de operação em D=0.31 assim obteve os seguintes resultados X3 = 1.523 e Y2=1.512 aonde a quantidade de celulas e substratos são iguais assim tendo uma melhor capacidade de operação, pois equilibra o crescimento celular com a utilização do substrato.


//Escolha um valor dentro da faixa determinada no item anterior e apresente os gráficos da concentração (substrato e células) versus tempo, considere X(0)=1,1g/L e S(0)=1,7g/L. Discuta os resultados.
// A faixa escolhida foi  D = 0.3, o melhor ponto é em 14 horas aonde o nivel de celulas entra em um estado estacionario.


//Considerando D=0,3h^-1, quais são os estados estacionários? Discuta a estabilidade de cada ponto.
//D = 0.3; X1 = 0; X2= 0.995; X3 =  1.53; Y1=0.175; Y2=1.512; Y3=4
//1. O primeiro estado estacionário (X1=0) e (Y1=0.175) é instável.
//2. O segundo estado estacionário (X2=0.995) e (Y2=1.512) é instável.
//3. O terceiro estado estacionário (X3=1.53) e (Y3=4) é estável.





