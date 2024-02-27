clc
clear
mode(-1)

//------------------------------------------------------------------------------
//                               CONSTANTES                                     
ko1 = 2.145e10 / 60 // 1/s
ko2 = 2.145e10 / 60 // 1/s
ko3 = 1.5072e8 / (60*1000) // m³/s.mol
E1_R = 9758.3; E2_R = 9758.3; E3_R = 8560 // K
h1 = -4200; h2 = 11000; h3 = 41850 // J/mol
Fo = 0.0235 / 60 // m³/s [Observação: Nas equações está como qr]
Ar = 0.215 // m²
Vr = 0.01 // m³
pr = 934.2 // kg/m³
Cpc = 2000; Cpr = 3010 // J/kg.K
U = 67200 / 60 // J /m².s.K
Qc = 4333200 / 60 // J/s
mc = 5 // kg


//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//                             FUNÇÕES
//Modelo dimensional
function y = ee(x)
    Ca = x(1)
    Cb = x(2)
    Cc = x(3)
    Cd = x(4)
    Tr = x(5)
    Tc = x(6)
    K1 = ko1*exp(-E1_R/Tr)
    K2 = ko2*exp(-E2_R/Tr)
    K3 = ko3*exp(-E3_R/Tr)
    hr = h1*K1*Ca + h2*K2*Cb + h3*K3*Ca**2
    y(1) = Fo*(Cao - Ca)/Vr - K1*Ca - K3*Ca**2
    y(2) = Fo*(Cbo - Cb)/Vr + K1*Ca - K2*Cb
    y(3) = Fo*(Cco - Cc)/Vr + K2*Cb
    y(4) = Fo*(Cdo - Cd)/Vr + (K3*Ca**2)/2
    y(5) = Fo*(Tro - Tr)/Vr - hr/(pr*Cpr) - Ar*U*(Tr-Tc)/(Vr*pr*Cpr)
    y(6) = (Qc + Ar*U*(Tr - Tc))/(mc*Cpc)
endfunction

function dxdt=din(t,x)
    Ca = x(1)
    Cb = x(2)
    Cc = x(3)
    Cd = x(4)
    Tr = x(5)
    Tc = x(6)
    K1 = ko1*exp(-E1_R/Tr)
    K2 = ko2*exp(-E2_R/Tr)
    K3 = ko3*exp(-E3_R/Tr)
    hr = h1*K1*Ca + h2*K2*Cb + h3*K3*Ca**2
    dxdt(1) = Fo*(Cao - Ca)/Vr - K1*Ca - K3*Ca**2
    dxdt(2) = Fo*(Cbo - Cb)/Vr + K1*Ca - K2*Cb
    dxdt(3) = Fo*(Cco - Cc)/Vr + K2*Cb
    dxdt(4) = Fo*(Cdo - Cd)/Vr + (K3*Ca**2)/2
    dxdt(5) = Fo*(Tro - Tr)/Vr - hr/(pr*Cpr) - Ar*U*(Tr-Tc)/(Vr*pr*Cpr)
    dxdt(6) = (Qc + Ar*U*(Tr - Tc))/(mc*Cpc)
endfunction


//Adimensional
function f = ee_adimensional(x)
    Ca_ad = x(1)
    Cb_ad = x(2)
    Cc_ad = x(3)
    Cd_ad = x(4)
    Tr_ad = x(5)
    Tc_ad = x(6)
    K1 = ko1*exp(-E1_R/Tro*Tr_ad)
    K2 = ko2*exp(-E2_R/Tro*Tr_ad)
    K3 = ko3*exp(-E3_R/Tro*Tr_ad)
    hr_ad = h1*K1*Ca_ad + h2*K2*Cb_ad + Cao*h3*K3*Ca_ad**2
    f(1) = (1 - Ca_ad) - Vr*K1*Ca_ad/Fo - (Cao*Vr*K3*Ca_ad**2)/Fo
    f(2) = (0 - Cb_ad) + Vr*K1*Ca_ad/Fo - Vr*K2*Cb_ad/Fo
    f(3) = (0 - Cc_ad) + Vr*K2*Cb_ad/Fo
    f(4) = (0 - Cd_ad) + Cao*Vr*K3*Ca_ad/(2*Fo)
    f(5) = (1 - Tr_ad) - (Cao*Vr*hr_ad)/(pr*Cpr*Fo*Tro) - Ar*U*(Tr_ad - Tc_ad)/(Fo*pr*Cpr)
    f(6) = (Vr*Qc)/(Tro*Fo*mc*Cpc) + Ar*U*Vr*(Tr_ad - Tc_ad)/Fo
endfunction


function dxdt = din_adimensional(t, x)
    Ca_ad = x(1)
    Cb_ad = x(2)
    Cc_ad = x(3)
    Cd_ad = x(4)
    Tr_ad = x(5)
    Tc_ad = x(6)
    K1 = ko1*exp(-E1_R/(Tro*Tr_ad))
    K2 = ko2*exp(-E2_R/(Tro*Tr_ad))
    K3 = ko3*exp(-E3_R/(Tro*Tr_ad))
    hr_ad = h1*K1*Ca_ad + h2*K2*Cb_ad + Cao*h3*K3*Ca_ad**2
    dxdt(1) = (1 - Ca_ad) - Vr*K1*Ca_ad/Fo - (Cao*Vr*K3*Ca_ad**2)/Fo
    dxdt(2) = (0 - Cb_ad) + Vr*K1*Ca_ad/Fo - Vr*K2*Cb_ad/Fo
    dxdt(3) = (0 - Cc_ad) + Vr*K2*Cb_ad/Fo
    dxdt(4) = (0 - Cd_ad) + Cao*Vr*K3*Ca_ad/(2*Fo)
    dxdt(5) = (1 - Tr_ad) - (Cao*Vr*hr_ad)/(pr*Cpr*Fo*Tro) - Ar*U*(Tr_ad - Tc_ad)/(Fo*pr*Cpr)
    dxdt(6) = (Vr*Qc)/(Tro*Fo*mc*Cpc) + Ar*U*Vr*(Tr_ad - Tc_ad)/(Fo*mc*Cpc)
endfunction

//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
//                           CONDIÇÕES INICIAIS                                 
Cao = 5100 // mol/m³
Cbo = 0 // mol/m³
Cco = 0 // mol/m³
Cdo = 0 // mol/m³
Tro = 387.05 //K
// Dimensionais
Ca = 0 // mol/m³
Cb = 0 // mol/m³
Cc = 0 // mol/m³
Cd = 0 // mol/m³
Tr = 150 + 273 // K
Tc = 25 + 273 // K

// Adimensionais
Ca_ad = Ca/Cao
Cb_ad = Cb/Cao
Cc_ad = Cc/Cao
Cd_ad = Cd/Cao
Tr_ad = Tr/Tro
Tc_ad = Tc/Tro

//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
//                                   DIMENSIONAL                                 

// ESTADO ESTACIONARIO
xi = [Ca; Cb; Cc; Cd; Tr; Tc]
[xf_ee, yf, info] = fsolve(xi, ee)
if info==1 then
    disp('Solução dimensional (h1, h2):')
    disp(xf_ee)
else
    disp('Tente novamente!')
end

// ESTADO DINÂMICO
xi = [Ca; Cb; Cc; Cd; Tr; Tc]
t=[0:0.1:400]
xf = ode(xi, t(1), t, din)

//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//                                   ADIMENSIONAL                                 

// ESTADO ESTACIONARIO
xi_ad = [Ca_ad; Cb_ad; Cc_ad; Cd_ad; Tr_ad; Tc_ad]
[xf_ad, yf_ad, info] = fsolve(xi_ad, ee_adimensional)
if info==1 then
    disp('Solução dimensional (h1, h2):')
    disp(xf_ad)
else
    disp('Tente novamente!')
end

// ESTADO DINÂMICO
xi_ad = [Ca_ad; Cb_ad; Cc_ad; Cd_ad; Tr_ad; Tc_ad]
t=[0:0.1:400]
tau = Fo*t/Vr
xf_ad_din = ode(xi_ad, tau(1), tau, din_adimensional)

//------------------------------------------------------------------------------





//----------->Saída de dados
scf(0)
clf(0)
// Dimensionais
subplot(2,2,1); plot(t,xf(1,:),'r')
subplot(2,2,1); plot(t,xf(2,:),'b')
subplot(2,2,1); plot(t,xf(3,:),'g')
subplot(2,2,1); plot(t,xf(4,:),'m')
xtitle('$Concentrações$','$tempo[s]$','$Concentração[mol/m³]$')
legend(["Concentração de A", "Concentração de B", "Concentração de C", "Concentração de D"], 1)
subplot(2,2,2); plot(t,xf(5,:),'r')
subplot(2,2,2); plot(t,xf(6,:),'b')
xtitle('$Temperaturas$','$tempo[s]$','$Temperatura[K]$')
legend(["Temperatura do reator", "Temperatura da jaqueta"], 2)

// Adimensionais
subplot(2,2,3); plot(tau,xf_ad_din(1,:),'r')
subplot(2,2,3); plot(tau,xf_ad_din(2,:),'b')
subplot(2,2,3); plot(tau,xf_ad_din(3,:),'g')
subplot(2,2,3); plot(tau,xf_ad_din(4,:),'m')
xtitle('$Adimensional$','$t_a_d$','$C_a_d$')
legend(["Ca_ad", "Cb_ad", "Cc_ad", "Cc_ad"], 1)
subplot(2,2,4); plot(tau,xf_ad_din(5,:),'r')
subplot(2,2,4); plot(tau,xf_ad_din(6,:),'b')
xtitle('$Adimensional$','$t_a_d$','$T_a_d$')
legend(["Tr_ad", "Tc_ad"], 2)


//----------->Fim do programa
disp('***FIM***')



