import math
import matplotlib.pyplot as plt


class Fluido:
    def __init__(self, densidade, viscosidade) -> None:
        self.densidade = densidade
        self.viscosidade = viscosidade


class Elutriador:
    def __init__(self, vazao, diametro, fluido, solido, massa_retida) -> None:
        self.vazao = vazao
        self.diametro = diametro
        self.area = (math.pi*diametro**2)/4
        self.velocidade = vazao/self.area
        self.gravidade = 980
        self.massa_retida = massa_retida

        # Outros componentes
        self.fluido = fluido
        self.solido = solido
    def Cd_div_Reynolds(self):
        cd_div_reynolds = (4*(self.solido.densidade - self.fluido.densidade)*self.fluido.viscosidade*self.gravidade)/(3*self.fluido.densidade**(2)*self.velocidade**3)
        return cd_div_reynolds
    def Reynolds(self):
        t1 = (24*(self.Cd_div_Reynolds())**(-1))**(0.88/2)
        t2 = (0.43*(self.Cd_div_Reynolds())**(-1))**(0.88)
        reynolds = (t1 + t2)**(1/0.88)
        return reynolds
    def Diametro_particula(self):
        diametro_particula_coletada = self.fluido.viscosidade*self.Reynolds()/(self.velocidade*self.fluido.densidade)
        return diametro_particula_coletada
    
class Solido:
    def __init__(self, densidade, massa, diametro_min=0, diametro_max=0) -> None:
        self.densidade = densidade
        self.massa = massa
        self.diametro_min = diametro_min
        self.diametro_max = diametro_max

class Sistema_de_Elutriadores:
    def __init__(self, massa_saida,*elutriadores) -> None:
        self.massa_saida = massa_saida
        self.sistema = list(elutriadores)
        
    def Massa_total(self):
        massa_total = self.massa_saida
        for i in self.sistema:
            massa_total += i.massa_retida
        return massa_total
    
    def Fração_massica_retida(self):
        massa_total = self.Massa_total()
        fracao_massica = []
        for i in self.sistema:
            fracao_massica.append(i.massa_retida/massa_total)
        fracao_massica.append(self.massa_saida/massa_total)
        return fracao_massica
    
    def Diametros_coletados_min(self):
        diametros = []
        for i in self.sistema:
            diametros.append(i.Diametro_particula())
        diametros.append(0)
        return diametros


solido = Solido(1.8, 25, diametro_max=0.01)
fluido = Fluido(1, 0.01)
elutriador1 = Elutriador(37/60, 3, fluido, solido, 4.62)
elutriador2 = Elutriador(37/60, 4, fluido, solido, 6.75)
elutriador3 = Elutriador(37/60, 6, fluido, solido, 7.75)
elutriador4 = Elutriador(37/60, 12, fluido, solido, 4.42)

sistema = Sistema_de_Elutriadores(1.45, elutriador1, elutriador2, elutriador3, elutriador4)

fracao_massica = sistema.Fração_massica_retida()
diametros = sistema.Diametros_coletados_min()

plt.plot(diametros, fracao_massica) 


