# IMPORTS

#from interpolação import interpolação

# FUNCTIONS

def delta_entalpia_cp_mistura(element, Ti, Tf):

    cte = element[1]
    if element[0] == "1":
        value = cte[0]*(Tf - Ti) + (cte[1]/2)*(Tf**2 - Ti**2) + (cte[2]/3)*(Tf**3 - Ti**3) + (cte[3]/4)*(Tf**4 - Ti**4)
    else:
        value = cte[0]*(Tf - Ti) + (cte[1]/2)*(Tf**2 - Ti**2) - (cte[2])/(Tf - Ti)
    
    return value

def cp_mistura(element1, element2, x1, x2):
    global cp
    cp1 = cp[element1]
    cp2 = cp[element2]
    if cp1[0] != cp2[0]:
        print("As formas polinomais dos Cp são diferentes")
    else:
        cp1 = cp1[1]
        cp2 = cp2[1]
        return (1, [cp1[i]*x1 + cp2[i]*x2 for i in range(4)])

def delta_entalpia(element, Ti, Tf):
    global cp
    cte = cp[element][1]
    if cp[element][0] == "1":
        value = cte[0]*(Tf - Ti) + (cte[1]/2)*(Tf**2 - Ti**2) + (cte[2]/3)*(Tf**3 - Ti**3) + (cte[3]/4)*(Tf**4 - Ti**4)
    else:
        value = cte[0]*(Tf - Ti) + (cte[1]/2)*(Tf**2 - Ti**2) - (cte[2])/(Tf - Ti)
    
    print(f"{value} kJ/mol")
    return value

# DATA

cp = {
    "H2O_G": (1,[33.46*10**-3, 0.688*10**-5, 0.7604*10**-8, -3.593*10**-12]),
    "H2O_L": (1, [75.4*10**-3, 0*10**-5, 0*10**-8, 0*10**-12]),
    "acetona_gas": (1, [71.96*10**-3, 20.1*10**-5, -12.78*10**-8, 34.76*10**-12]),
    "nitrogenio_gas": (1, [29*10**-3, 0.2199*10**-5, 0.5723*10**-8, -2.871*10**-12]),
    "etano_gas": (1, [49.37*10**-3, 13.92*10**-5, -5.816*10**-8, 7.28*10**-12]),
    "propano_gas": (1, [68.032*10**-3, 22.59*10**-5, -13.11*10**-8, 31.71*10**-12]),
    "benzeno_liquido": (1, [126.5*10**-3, 23.4*10**-5, 0*10**-8, 0*10**-12]),
    "tolueno_liquido": (1, [148.8*10**-3, 32.4*10**-5, 0*10**-8, 0*10**-12]),
    "cloreto_de_hidrogenio_gas": (1, [29.13*10**-3, -0.1341*10**-5, 0.9715*10**-8, -0.4335*10**-12]),
    "oxigenio_gas": (1, [29.10*10**-3, 1.158*10**-5, -0.6076*10**-8, -1.311*10**-12]),
    "NO_G": (1, [29.5*10**-3, 0.8188*10**-5, -0.2925*10**-8, 0.3652*10**-12]),
    "CH4_G": (1, [34.31*10**-3, 5.469*10**-5, 0.3661*10**-8, -11*10**-12]),
    "CH2O_G": (1, [34.28*10**-3, 4.268*10**-5, 0*10**-8, -8.694*10**-12]),
    "CO2_G": (1, [36.11*10**-3, 3.904*10**-5, -3.104*10**-8, 8.606*10**-12]),
    "n-butano": (1, [92.3*10**-3, 27.88*10**-5, -15.47*10**-8, 34.98*10**-12]),
    "isobutano": (1, [89.46*10**-3, 30.13*10**-5, -18.91*10**-8, 49.87*10**-12]),
}

# CALCULATING

delta_entalpia("n-butano",25,149)
delta_entalpia("isobutano",25,149)


#print(delta_entalpia("CO2_G", 25,150) - 393.5)

"""# SAIDA
s1 = [1, -1974]
s2 = [3, -285.84]

energia_sai = sum([i[0]*i[1] for i in [s1,s2]])

# ENTRADA
e1 = [1, -1294]
e2 = [3, -469.11]
energia_entra = sum([i[0]*i[1] for i in [e1,e2]])

print(energia_sai)
print(energia_entra)
print(energia_sai - energia_entra)"""