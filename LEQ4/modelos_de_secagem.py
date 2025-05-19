from deap import creator, base, tools, algorithms
import random
import numpy as np


# RAZÃO DE UMIDADE
# RU = (Xt - Xf) / (X0 - Xf) # base umida
# RU = Xt / X0 # base seca

# TEOR DE UMIDADE
# Xi = (m_umida - m_seca) / m_umida # base umida
# xi = (m_umida - m_seca) / m_seca # base seca
from deap import tools
from deap import algorithms

def eaSimpleWithElitism(population, toolbox, cxpb, mutpb, ngen, stats=None,
             halloffame=None, verbose=__debug__):
    """This algorithm is similar to DEAP eaSimple() algorithm, with the modification that
    halloffame is used to implement an elitism mechanism. The individuals contained in the
    halloffame are directly injected into the next generation and are not subject to the
    genetic operators of selection, crossover and mutation.
    """
    logbook = tools.Logbook()
    logbook.header = ['gen', 'nevals'] + (stats.fields if stats else [])

    # Evaluate the individuals with an invalid fitness
    invalid_ind = [ind for ind in population if not ind.fitness.valid]
    fitnesses = toolbox.map(toolbox.evaluate, invalid_ind)
    for ind, fit in zip(invalid_ind, fitnesses):
        ind.fitness.values = fit

    if halloffame is None:
        raise ValueError("halloffame parameter must not be empty!")

    halloffame.update(population)
    hof_size = len(halloffame.items) if halloffame.items else 0

    record = stats.compile(population) if stats else {}
    logbook.record(gen=0, nevals=len(invalid_ind), **record)
    if verbose:
        print(logbook.stream)

    # Begin the generational process
    for gen in range(1, ngen + 1):

        # Select the next generation individuals
        offspring = toolbox.select(population, len(population) - hof_size)

        # Vary the pool of individuals
        offspring = algorithms.varAnd(offspring, toolbox, cxpb, mutpb)

        # Evaluate the individuals with an invalid fitness
        invalid_ind = [ind for ind in offspring if not ind.fitness.valid]
        fitnesses = toolbox.map(toolbox.evaluate, invalid_ind)
        for ind, fit in zip(invalid_ind, fitnesses):
            ind.fitness.values = fit

        # add the best back to population:
        offspring.extend(halloffame.items)

        # Update the hall of fame with the generated individuals
        halloffame.update(offspring)

        # Replace the current population by the offspring
        population[:] = offspring

        # Append the current generation statistics to the logbook
        record = stats.compile(population) if stats else {}
        logbook.record(gen=gen, nevals=len(invalid_ind), **record)
        if verbose:
            print(logbook.stream)

    return population, logbook


# FUNÇÃO OBJETIVO
import math

def wang_singh(t, a, b):
    """Eq. (3) - Wang e Singh: RU = 1 + a·t + b·t²"""
    return 1 + a * t + b * t**2

def verna(t, a, k, k1):
    """Eq. (4) - Verna: RU = a·exp(-k·t) + (1-a)·exp(-k1·t)"""
    return a * math.exp(-k * t) + (1 - a) * math.exp(-k1 * t)

def thompson(t, a, b):
    """Eq. (5) - Thompson: RU = exp( (-a - √(a² + 4·b·t)) / (2·b) )"""
    if b <= 0:
        return 100_000_000
    return math.exp(( -a - math.sqrt(a**2 + 4 * b * t) ) / (2 * b))

def page(t, k, n):
    """Eq. (6) - Page: RU = exp(-k·tⁿ)"""
    try:
        return math.exp(-k * t**n)
    except:
        return 100_000_000

def newton(t, k):
    """Eq. (7) - Newton: RU = exp(-k·t)"""
    return math.exp(-k * t)

def midilli(t, a, k, n, b):
    """Eq. (8) - Midilli: RU = a·exp(-k·tⁿ) + b·t"""
    try:
        return a * math.exp(-k * t**n) + b * t
    except:
        return 100_000_000


def logaritmico(t, a, k, c):
    """Eq. (9) - Logarítmico: RU = a·exp(-k·t) + c"""
    return a * math.exp(-k * t) + c

def henderson_pabis(t, a, k):
    """Eq. (10) - Henderson & Pabis: RU = a·exp(-k·t)"""
    return a * math.exp(-k * t)

def henderson_pabis_modificado(t, a, b, c, k0, k1):
    """Eq. (11) - Henderson & Pabis Modificado:
       RU = a·exp(-k0·t) + b·exp(-k0·t) + c·exp(-k1·t)
    """
    return a * math.exp(-k0 * t) + b * math.exp(-k0 * t) + c * math.exp(-k1 * t)

def exp_dois_termos(t, a, k):
    """Eq. (12) - Exponencial de Dois Termos:
       RU = a·exp(-k·t) + (1-a)·exp(-k·a·t)
    """
    try:
        return a * math.exp(-k * t) + (1 - a) * math.exp(-k * a * t)
    except:
        return 100_000_000


def dois_termos(t, a, b, k0, k1):
    """Eq. (13) - Dois Termos:
       RU = a·exp(-k0·t) + b·exp(-k1·t)
    """
    return a * math.exp(-k0 * t) + b * math.exp(-k1 * t)

def aproximacao_difusao(t, a, k, b):
    """Eq. (14) - Aproximação da Difusão:
       RU = a·exp(-k·t) + (1-a)·exp(-k·b·t)
    """
    try:
        return a * math.exp(-k * t) + (1 - a) * math.exp(-k * b * t)
    except:
        return 100_000_000
    
def fitness_function(solution, function):
    global RU, tempo
    y = [function(t, *solution) for t in tempo]
    errors = [abs(y[i] - RU[i]) for i in range(len(RU))]
    return sum(errors), # Return a tuple for DEAP compatibility

def run_genetic_algorithm(function, population_size=1000, generations=10, crossover_prob=0.75, mutation_prob=0.2):

    # GENETIC ALGORITHM
    # STRUCTURE
    creator.create("FitnessMin", base.Fitness, weights=(-1.0,))
    creator.create("ChromosomeStruct", list, fitness=creator.FitnessMin)
    toolbox = base.Toolbox()


    # GENE, CHROMOSOME, INDIVIDUAL, POPULATION
    CHROMOSOME_LENGTH = function.__code__.co_argcount - 1 # Number of parameters in the function (excluding t)
    BOUND_LOW, BOUND_UP = -5, 5 # Defining the limits of function domain
    def gene(l, u): 
        return random.uniform(l,u)
    toolbox.register("Gene", gene, l=BOUND_LOW, u=BOUND_UP)
    toolbox.register("Chromosome", tools.initRepeat, creator.ChromosomeStruct, toolbox.Gene, n=CHROMOSOME_LENGTH)
    toolbox.register("Individual", toolbox.Chromosome)
    toolbox.register("PopulationCreator", tools.initRepeat, list, toolbox.Individual)


    # GENETIC OPERATORS
    ETA = 20 # Constant that define how much will change in mutation and some kinds of crossover
    toolbox.register("evaluate", lambda solution: fitness_function(solution, function))
    toolbox.register("select", tools.selTournament, tournsize=3)
    toolbox.register("mate", tools.cxSimulatedBinaryBounded, eta=ETA, low=BOUND_LOW, up=BOUND_UP)
    toolbox.register("mutate", tools.mutPolynomialBounded, eta=ETA, low=BOUND_LOW, up=BOUND_UP, indpb=1/CHROMOSOME_LENGTH)

    
    # STORING THE INFORMATION
    stats = tools.Statistics(lambda population: population.fitness.values)
    stats.register("max", np.max)
    stats.register("min", np.min)
    stats.register("mean", np.mean)
    hof = tools.HallOfFame(population_size * 0.05 // 1) # Store the best individuals found so far

    # stats_ind = tools.Statistics(key=lambda ind: ind)
    # stats_ind.register("best", lambda pop: tools.selBest(pop, 1)[0])
    # mstats = tools.MultiStatistics(fitness=stats, individual=stats_ind)


    # CONTROL PANEL
    POPULATION_SIZE = population_size
    PROBABILITY_CROSSOVER = crossover_prob
    PROBABILITY_MUTATION = mutation_prob
    MAX_GENERATIONS = generations
    #random.seed(42)


    # EVOLVING THE SOLUTION
    generationCounter = 0
    population = toolbox.PopulationCreator(n=POPULATION_SIZE)
    result, logbook = eaSimpleWithElitism(population,
                                        toolbox,
                                        cxpb=PROBABILITY_CROSSOVER,
                                        mutpb=PROBABILITY_MUTATION,
                                        ngen=MAX_GENERATIONS,
                                        stats=stats,
                                        halloffame=hof,
                                        verbose=False)

    return {function.__name__: result, "logbook": logbook, "hof": hof} # Return the result of the algorithm


import numpy as np
import matplotlib.pyplot as plt

def plot_all_fitted_curves(results, tempo, RU, functions, num_points=200):
    """
    Plots all fitted model curves together with the observed data points.
    Each curve uses distinct color from matplotlib's default cycle, and
    includes the R² value in the legend label.
    """
    t_line = np.linspace(min(tempo), max(tempo), num_points)
    plt.figure(figsize=(8,6))
    
    # Plot observed data points
    plt.scatter(tempo, RU, label="Observado", marker='o')
    
    # Plot each model
    for func in functions:
        name = func.__name__
        best = results[name]['hof'][0]
        
        # Predictions for smooth curve
        y_line = [func(t, *best) for t in t_line]
        # Predictions at original points (for R²)
        y_points = [func(t, *best) for t in tempo]
        
        # Compute R²
        ru_mean = np.mean(RU)
        ss_res = sum((obs - pred)**2 for obs, pred in zip(RU, y_points))
        ss_tot = sum((obs - ru_mean)**2 for obs in RU)
        r2 = 1 - ss_res/ss_tot if ss_tot != 0 else float('nan')
        
        plt.plot(t_line, y_line, label=f"{name} (R²={r2:.3f})")
    
    plt.title("Modelos Ajustados vs Observado")
    plt.xlabel("Tempo")
    plt.ylabel("Razão de Umidade")
    plt.legend()
    plt.tight_layout()
    plt.show()

# Exemplo de chamada, após rodar seus GAs:
# plot_all_fitted_curves(results, tempo, RU, functions)


# Exemplo de chamada, após rodar seu GA:
# plot_results(results, tempo, RU, functions)
import inspect
import pandas as pd
import matplotlib.pyplot as plt

def plot_model_parameters(results, functions, precision=4):
    """
    Plota uma tabela em Matplotlib com os parâmetros (pesos) ótimos de cada modelo.

    — results: dicionário retornado pelos seus GAs: results[func.__name__] contendo 'hof'
    — functions: lista de funções de modelo (wang_singh, verna, ...)
    — precision: casas decimais para exibir os valores
    """
    # 1) Monta um DataFrame com linhas = nomes dos modelos, colunas = parâmetros
    data = {}
    for func in functions:
        name = func.__name__
        best_ind = results[name]['hof'][0]   # indivíduo campeão
        # extrai nomes dos parâmetros exceto 't'
        param_names = list(inspect.signature(func).parameters.keys())[1:]
        data[name] = {p: v for p, v in zip(param_names, best_ind)}
    df = pd.DataFrame.from_dict(data, orient='index')
    df = df.round(precision)

    # 2) Desenha a tabela
    fig, ax = plt.subplots(figsize=(1 + len(df.columns)*1.2, 1 + len(df)*0.3))
    ax.axis('off')
    tbl = ax.table(
        cellText=df.values,
        rowLabels=df.index,
        colLabels=df.columns,
        cellLoc='center',
        loc='center'
    )
    tbl.auto_set_font_size(False)
    tbl.set_fontsize(10)
    tbl.scale(1, 1.2)

    # 3) Título e layout
    plt.title("Parâmetros ótimos de cada modelo", pad=20)
    plt.tight_layout()
    plt.show()


if __name__ == "__main__":# DADOS
    # DADOS VOLUME
    n_particulas = 5
    massa = 2.140 # g
    volume = 1.55 # cm³
    volume_particula = volume / n_particulas
    massa_particula = massa / n_particulas
    densidade = massa / volume # g / cm³

    # DADOS SECAGEM
    massa_seca = 30.324 * 0.897
    massa_umida = 30.324
    
    massas = [30.324, 30.275, 30.252, 30.215, 30.177, 30.138, 30.096, 30.054, 30.010, 29.965, 29.919, 29.870, 29.824, 29.777, 29.729, 29.681, 29.634, 29.588, 29.542, 
              29.498, 29.456, 29.415, 29.375, 29.335, 29.298, 29.260, 29.224, 29.056, 28.915, 28.788, 28.680, 28.584, 28.500, 28.425, 28.358, 28.297, 28.240, 28.190, 
              28.144, 28.102, 28.064, 28.030, 27.997, 27.967, 27.936, 27.907, 27.881]
    
    teor_umidade_inicial = (massas[0] - massa_seca) / massa_seca # base seca
    teor_umidade_final = (massas[-1] - massa_seca) / massa_seca # base seca
    teor_umidade = [(m - massa_seca) / massa_seca for m in massas]

    # RU = (Xt - Xf) / (X0 - Xf) # base umida
    RU = [(teor_umidade[i] - teor_umidade_final) / (teor_umidade_inicial - teor_umidade_final) for i in range(len(teor_umidade))]

    tempo = [0, 1, 2, 3, 4, 5, 6, 7, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125]


    # Run the genetic algorithm for each function
    functions = [wang_singh, verna, thompson, page, newton, midilli, logaritmico, henderson_pabis,
                 henderson_pabis_modificado, exp_dois_termos, dois_termos, aproximacao_difusao]
    
    results = {}
    for function in functions:
        results[function.__name__] = run_genetic_algorithm(function, generations=50, population_size=2000)
    
    # Call the function after running GAs
    plot_all_fitted_curves(results, tempo, RU, functions)
    plot_model_parameters(results, functions)