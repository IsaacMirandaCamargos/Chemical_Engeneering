
# FUNCTION
def function(x, reynolds, kp, d_particula):
    """O valor x é o valor que queremos encontrar, o qual zera a função"""
    from math import exp

    if reynolds <= 0.1:
        B = d_particula/x
        return ((1-B)/(1-0.475*B))**4 - kp
    elif 0.1 < reynolds <= 1000:
        B = d_particula/x
        a = 8.91*exp(2.79*B)
        b = 1.17*10**-3 - 0.281*B
        return ((10)/(1+a*reynolds**b)) - kp
    elif reynolds > 1000:
        B = d_particula/x
        return 1 - B**(3/2) - kp



# DADOS (xf = xi - yi/m)
xi = 0.01
yi = function(xi, 0.1, 0.95, 0.005)
erro = 0.0000001
reynolds = 1000.1
m = (function(xi+erro, reynolds, 0.95, 0.005) - function(xi, reynolds, 0.95, 0.005))/erro
xf = xi -yi/m


while (xf - xi) > erro:
    xi = xf
    m = (function(xi+erro, reynolds, 0.95, 0.005) - function(xi, reynolds, 0.95, 0.005))/erro
    xf = xi - function(xi, reynolds, 0.95, 0.005)/m


print(f"A raiz da função é {xf}")