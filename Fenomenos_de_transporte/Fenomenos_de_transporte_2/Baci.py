import matplotlib.pyplot as plt

def funcao(x):
    y = x**3 - 9515.7*x**2 + 85233.083*x - 5605128164.61
    return y

erro = 10**(-6)
respostas = set()

def newton_raphson(xi, erro):
    m = (funcao(xi+erro)-funcao(xi))/erro
    yi = funcao(xi)
    xf = xi - yi/m

    while abs(xf - xi) > erro:
        xi = xf
        m = (funcao(xi+erro)-funcao(xi))/erro
        yi = funcao(xi)
        xf = xi - yi/m

    if xf > 0 and funcao(xf) <= erro:
        respostas.add((xf))

for i in range(0,100000,100):
    newton_raphson(i, erro)

"""xx = [i for i in range(0,12000, 1)]
yy = [funcao(j) for j in xx]
plt.plot(xx,yy)
plt.show()"""


print(respostas)