# @title
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit, fsolve
from scipy.integrate import simps
import numpy as np
from random import *

class TorreResfriamento():

    # CURVA 1
    def getParams_Har_x_Tar(self):

        T_ar = [15.6, 26.7, 29.4, 32.2, 35, 37.8, 40.6, 43.3, 46.1] # Temperatura
        H_ar = [43.68e3, 84e3, 97.2e3, 112.1e3, 128.9e3, 148.2e3, 172.1e3, 197.2e3, 224.5e3] # J/kg

        curve_Har_x_Tar =lambda T, a, b, c: a*T**(2) + b*T + c
        params, _ = curve_fit(curve_Har_x_Tar, T_ar, H_ar)
        a = params[0]
        b = params[1]
        c = params[2]
        return a, b, c

    # CURVA 2
    def getParams_Har_x_Tagua(self, TLs, He, L, G, Cp):
        a = L * Cp / G
        b = -a * TLs + He
        return a, b

    # CURVA Gmin
    def getParams_Gmin(self, He, Tls, L, Cp):
        a, b, c = self.getParams_Har_x_Tar()

        def equation(T, He, Tls, a, b, c):
            return a*T**(2) + b*T + c - He - (2*a*T + b) * (T - Tls)

        # Calculando valores da curva
        Tf = fsolve(equation, 100, args=(He, Tls, a, b, c))
        a_min = 2*a*Tf + b
        b_min = He - a_min*Tls
        G_min = L*Cp/a_min

        return a_min, b_min, G_min, Tf

    # DELTA H
    def getParams_Delta_H(self, Tli, Hi):

        hla = self.hla
        kga = self.kga
        Mb = self.Mb
        P = self.P

        try:
            a = - hla / (kga * Mb * P)
            b = - a * Tli + Hi
            return a, b
        except:
            return None, None



    def __init__(self, Tle, Tls, He, L, Cp, Mb, P, kga=None, hla=None, G=None, Gmin=None, Kga=None):
        self.Tle = Tle
        self.Tls = Tls
        self.He = He
        self.L = L
        self.Cp = Cp
        self.Mb = Mb
        self.P = P
        self.kga = kga
        self.hla = hla
        self.G = G
        self.Gmin = Gmin
        self.Kga = Kga

        # Analisando curva 1
        a, b, c = self.getParams_Har_x_Tar()
        x1 = np.linspace(15, 50, 100)
        y1 = a*x1**(2) + b*x1 + c

        # Obtendo Gmin
        a_min, b_min, G_min, Tf = self.getParams_Gmin(He, Tls, L, Cp)
        x2 = np.linspace(Tls, Tf, 100)
        y2 = a_min*x2 + b_min

        # Obtendo a curva 2
        if self.Gmin == None:
            a3, b3 = self.getParams_Har_x_Tagua(Tls, He, L, G, Cp)
            x3 = np.linspace(Tls, Tle, 100)
            y3 = a3*x3 + b3
        else:
            G = self.Gmin*G_min[0]
            a3, b3 = self.getParams_Har_x_Tagua(Tls, He, L, G, Cp)
            x3 = np.linspace(Tls, Tle, 100)
            y3 = a3*x3 + b3

        # Salvando dados
        self.Gmin = G_min[0]
        self.G = G

        # Plotando visualização básica
        plt.style.use('ggplot')
        plt.title('Analise inicial')
        plt.plot(x1, y1, label='Har = f(Tar)')
        plt.plot(x2, y2, label='Curva Gmin')
        plt.plot(x3, y3, label='Har = f(Tagua)')
        plt.xlabel("Temperaturas (°C)")
        plt.ylabel("Entalpia ar (J/kg)")
        plt.legend()
        plt.show()

    def calculate_Delta_H(self, discretizacao):

        # Dados
        He = self.He
        L = self.L
        G = self.G
        Cp = self.Cp


        # Curva 1
        a, b, c = self.getParams_Har_x_Tar()
        x1 = np.linspace(15, 50, 100)
        y1 = a*x1**(2) + b*x1 + c

        # Curva2
        a2, b2 = self.getParams_Har_x_Tagua(Tls, He, L, G, Cp)
        x2 = np.linspace(Tls, Tle, discretizacao)
        y2 = a2*x2 + b2


        # Obtendo delta_H
        delta_H = []
        H_ar = []
        for Tli, Hi in zip(x2, y2):
            a_delta, b_delta = self.getParams_Delta_H(Tli, Hi)
            if a_delta == None:
                Tf = Tli
                Hf = a*Tf**(2) + b*Tf + c
                x_plot = [Tli, Tf]
                y_plot = [Hi, Hf]
                plt.plot(x_plot, y_plot)
                # Salvando delta_H e H_ar
                delta_H.append(Hf-Hi)
                H_ar.append(Hi)
            else:
                Tf = fsolve(lambda T: a*T**(2) + (b - a_delta)*T + (c - b_delta), Tli)
                Hf = a_delta*Tf + b_delta
                x_plot = np.linspace(Tli, Tf, 10)
                y_plot = a_delta*x_plot + b_delta
                plt.plot(x_plot, y_plot)
                # Salvando delta_H e H_ar
                delta_H.append((Hf-Hi)[0])
                H_ar.append(Hi)






        # Plotando resultados
        plt.style.use('ggplot')
        plt.title('Obtendo $\Delta H$')
        plt.plot(x1, y1, label='H_ar = f(Tar)')
        plt.plot(x2, y2, label='H_ar = f(Tagua)')
        plt.xlabel("Temperaturas (°C)")
        plt.ylabel("Entalpa (J/kg)")
        plt.legend()
        plt.show()

        self.H_ar = np.array(H_ar)
        self.delta_H = np.array(delta_H)


    def calculate_Integral(self):

        # Dados
        G = self.G
        Mb = self.Mb
        P = self.P
        kga = self.kga
        Kga = self.Kga
        H_ar = self.H_ar
        delta_H = self.delta_H

        # Plotando integral
        plt.title('Calculando a altura')
        plt.plot(H_ar, 1/delta_H)
        plt.ylabel("$(H_{yi} - H_y)^{-1}$")
        plt.xlabel("$H_y$")
        plt.fill_between(H_ar, 0, 1/delta_H, alpha=0.3, color='orange', label='Área sob a curva') # Esta linha preenche a área sob a curva
        plt.show()

        # Calculando
        integral = simps(1/delta_H, H_ar)
        try:
            Z = G * integral / (Mb * kga * P)
        except:
            Z = G * integral / (Mb * Kga * P)
        #print(f"O valor de Z é {Z}")
        return integral

    def relatorio(self):
        return {
            "Tle": self.Tle,
            "Tls": self.Tls,
            "He": self.He,
            "L": self.L,
            "Cp": self.Cp,
            "Mb": self.Mb,
            "P": self.P,
            "kga": self.kga,
            "hla": self.hla,
            "G": self.G,
            "Gmin": self.Gmin,
            "Kga": self.Kga,
            "H_ar": self.H_ar,
            "delta_H": self.delta_H
        }


# Variaveis
Tle = 43.3 # °C
T_ar_e = 23.9 # °C bulbo umido
He = 71000 # J/kg
Tls = 29.4 # °C
L = 1.356 # kg/m².s
G = 1.356 # kg/m².s
Gmin = None
Cp = 4187 # J/kg.K
kga = 1.207e-7 # kg.kmol/s.m³.Pa
Kga = None # Coeficiente global
Mb = 29 # kg/kmol
P = 1.013e5 # Pascal
hla = 4.187e4 *kga*Mb*P
discretizacao = 10

Torre = TorreResfriamento(Tle, Tls, He, L, Cp, Mb, P, kga=kga, hla=hla, G=G, Gmin=Gmin, Kga=Kga)
Torre.calculate_Delta_H(discretizacao)
integral = Torre.calculate_Integral()
relatorio = Torre.relatorio()
Z = G*integral/(Mb*kga*P)
plt.show()