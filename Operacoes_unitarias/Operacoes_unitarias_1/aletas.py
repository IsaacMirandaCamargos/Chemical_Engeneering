from math import atanh, pi, sqrt
from re import A

d = 0.005
P = pi*d
h = 100
Atr = pi*d**2/4
values = [(398,"cobre"), (180, "aluminio"), (14, "aço")]


for k, name in values:
    m = sqrt(h*P/(k*Atr))
    L = atanh(0.99)/m
    print(f"O comprimento do tubo de {name} é {L}")