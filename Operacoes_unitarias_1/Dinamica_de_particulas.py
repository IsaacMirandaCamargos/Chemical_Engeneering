import math
import pandas as pd

class Reynolds_de_particulas:
    
    def __init__(self, pf, u, ps, esfericidade, g, vazao=None ,dp=None, vt=None, concentracao=None) -> None:
        self.pf = pf
        self.u = u
        self.ps = ps
        self.dp = dp
        self.esfericidade = esfericidade
        self.concentracao = concentracao
        self.g = g
        self.vt = vt
        self.vazao = vazao
        pass


    def Cd_reynolds_quadrado(self):
        numerador = 4*self.pf*(self.ps-self.pf)*self.g*self.dp**3
        denominador = 3*self.u**2
        self.cd_reynolds_quadrado = numerador/denominador
        return self.cd_reynolds_quadrado

    def Cd_div_reynolds(self):
        numerador = 4*(self.ps - self.pf)*self.u*self.g
        denominador = (3*self.pf**(2)*self.vt**3)
        self.cd_div_reynolds = numerador/denominador
        return self.cd_div_reynolds

    def Reynolds_calculator(self):
        from math import log10
        self.k1 = 0.843*log10(self.esfericidade/0.065)
        self.k2 = 5.31 - 4.88*self.esfericidade
        if self.vt == None:
            a = self.Cd_reynolds_quadrado()
            if self.esfericidade == 1:
                self.reynolds = ((a/24)**-0.95 + (a/0.43)**(-0.95/2))**(-1/0.95)
                return self.reynolds
            elif self.esfericidade != 1:
                n = 1.2
                self.reynolds = ((self.k1*a/24)**-n + (a/self.k2)**(-0.5*n))**(-1/n)
                return self.reynolds
        elif self.dp == None:
            a = self.Cd_div_reynolds()
            if self.esfericidade == 1:
                self.reynolds = ((24/a)**(0.88/2)+(0.43/a)**(0.88))**(1/0.88)
                return self.reynolds
            elif self.esfericidade != 1:
                n = 1.3
                self.reynolds = ((24/(self.k1*a))**(0.5*n) + (self.k2/a)**(n))**(1/n)
                return self.reynolds

    def Terminal_velocite(self):
        self.reynolds = self.Reynolds_calculator()
        self.v_terminal = self.reynolds*self.u/(self.dp*self.pf)
        return self.v_terminal
    
    def Diameters_of_particles(self):
        """Diametro de particulas que ficam dentro do elutriador"""
        self.reynolds = self.Reynolds_calculator()
        self.diameter_particle = self.reynolds*self.u/(self.pf*self.vt)
        return self.diameter_particle
    
    def Diameters_and_area_of_elutriator(self):
        self.area = self.vazao/self.terminal_velocite()
        self.diameter = math.sqrt(4*self.area/math.pi)
        return self.area, self.diameter*100
    
    def Print_all(self):
        if self.dp == None:
            self.Diameters_of_particles()
            a, b, c = self.cd_div_reynolds, self.reynolds, self.diameter_particle
            return (f"Cd/Re = {a}; Re = {b}; dp = {c}")
        elif self.vt == None:
            lixo = self.diameters_and_area_of_elutriator()
            lista = [self.cd_reynolds_quadrado, self.k1, self.k2, self.reynolds, self.dp, self.v_terminal,self.area, self.diameter]
            return lista
    
    def printao(self):
        self.Diameters_of_particles()
        a = self.cd_div_reynolds
        b = self.reynolds
        c = self.diameter_particle
        return f"Cd div reynolds = {a}; Reynolds = {b}; dp = {c}"


# pf, u, ps, esfericidade, g, vazao=None ,dp=None, vt=None, concentracao=None
elutriador1 = Reynolds_de_particulas(1, 0.01, 1.8, 1, 981, 37/60, vt=0.08724)
elutriador2 = Reynolds_de_particulas(1, 0.01, 1.8, 1, 981, 37/60, vt=0.04907)
elutriador3 = Reynolds_de_particulas(1, 0.01, 1.8, 1, 981, 37/60, vt=0.02181)
elutriador4 = Reynolds_de_particulas(1, 0.01, 1.8, 1, 981, 37/60, vt=0.00545)

lista = [elutriador1, elutriador2, elutriador3, elutriador4]
for i in lista:
    print(i.printao())







