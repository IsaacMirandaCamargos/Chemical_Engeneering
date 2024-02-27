from math import ceil, log10, pi, sqrt

## Dados
V = 2  # m/s
Q = 6.94 * 10 ** (-3)  # m³/s
e = 2 * 10 ** (-3)
densidade = 1 * 10 ** (3)
VisCinematica = 1.01 * 10 ** (-6)
g = 9.81

## Calculo do diamêtro e da velocidade
Dm = sqrt((4 * Q) / (pi * V))  # m
Din = Dm / 0.0254  # in
print("Diametro em in: ", Din)

if type(Din) != int:
    Darredondado = ceil(Din)  # in
    print("Diamentro arredondado: ", Darredondado)
    Dm = Darredondado * 0.0254  # m
    print("Diamentro arredondado em m: ", Dm)

## Ajuste da velocidade
V = (4 * Q) / (pi * (Dm) ** 2)  # m/s
print("Ajuste da velocidade: ", V)

## Reynolds
Re = (Dm * V) / VisCinematica
print("Reynolds: ", Re)

## Calculo fator de atrito
primeira_parte = -1.8 * log10(((e / Dm) / 3.7) ** 1.11 + (6.9 / Re))
F = (1 / primeira_parte) ** 2
print("Calculo fator de atrito: ", F)

## Perda de carga na sucção
Le1 = 420 + 30
Ls = 6
v = (V**2) / (2 * g)

Hs = F * (Le1 + (Ls / Dm)) * v
print("Perda de carga na sucção: ", Hs)

## Perda de carga no recalque
Le2 = 900 + (2 * 150) + (2 * 30)
Lr = 1000

Hr = F * (Le2 + (Lr / Dm)) * v
print("Perda de carga no recalque: ", Hr)

## Perda de carga total
Ht = Hs + Hr
print("Perda de carga total: ", Ht)

## Bernoulli entre 1 e 4
Z4 = 302
Hb = (V**2 / (2 * g)) + Z4 + Ht
print("Bernoulli Hb: ", Hb)

## Potência
n = 0.7
P = (densidade * g * Hb * Q) / (745 * n)
print("Potência em J/s ou Watts: ", P)
print("Potência em HP: ", P / 745.7)
