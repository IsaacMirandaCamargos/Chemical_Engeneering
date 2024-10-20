clear
clc

# Sabendo-se que a quantidade de calor necessaria para elevar a 
# temperatura de um corpo de massa (m) de uma temperatura (To) a uma
# temperatura (T1) é dada por:

# Q = m*(integral[Cp(T)] dT)

# Onde (Cp) é o calor especifico do corpo à uma temperatura T.


# Para a agua temos a seguinte tabela, que fornece o calor especifico
# função da temperatura:

T = [0 10 20 30 40 50 60 70 80 90 100 ];  # C°
Cp = [ 999.9 999.7 998.2 995.3 992.3 988.1 983.2 977.8 971.8 965.3 958.4 ];  # Kcal/kg°C
massa = 20; # kg

# Calcular a quantidade de calor necessaria para elevar 20 kg de agua
# de 0 a 100°C:

CalorIsaac = 0;
n = length(Cp);
h = T(2)-T(1);
for i = 1:1:n-1
  CalorIsaac = CalorIsaac + (Cp(i) + Cp(i+1))*(T(i+1)-T(i))/2;
endfor
CalorIsaac = CalorIsaac*massa;

CalorTrapezio = (h/2)*(Cp(1) + 2*(sum(Cp(2:n-1))) + Cp(n));
CalorTrapezio = CalorTrapezio*massa;


disp(CalorIsaac)
disp(CalorTrapezio)