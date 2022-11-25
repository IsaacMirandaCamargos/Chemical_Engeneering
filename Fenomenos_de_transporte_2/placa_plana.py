from dis import dis
import numpy as np
import matplotlib.pyplot as plt


class Placa:

    

    def __init__(self, comprimento, largura, discretização) -> None:
        self.comprimento = comprimento
        self.largura = largura
        self.discretização = discretização
        self.pontos = []
        for x in np.arange(0, self.comprimento, self.discretização,):
            for y in np.arange(0, self.largura, self.discretização):
                self.pontos.append((x, y))
        #print(self.pontos)

    def get_points(self):
        return self.pontos

    def plot_points(self):
        x, y = [x[0] for x in self.pontos], [y[1] for y in self.pontos]
        plt.scatter(x,y)

placa = Placa(1, 1, 0.25)
placa.plot_points()
