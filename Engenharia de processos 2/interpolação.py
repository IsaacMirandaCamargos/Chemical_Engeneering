from math import sqrt

def baskara(l):
    a = l[0]
    b = l[1]
    c = l[2]
    delta = b**2-4*a*c
    print(delta)
    try:
        t1 = (-b-sqrt(delta))/2*a
        print(t1)
    except:k
        None
    try:
        t2 = (-b+sqrt(delta))/2*a
        print(t2)
    except:
        None
    

def interpolar(xinter):
    global x1, y1, x2, y2
    a = (y2-y1)/(x2-x1)
    b = y1 - a*x1
    yinter = a*xinter + b

    print(yinter)
    return yinter


x1 = 5
x2 = 10
y1 = 58.03
y2 = 67.03
#interpolar(9)

baskara([-25, 250, 750-2692.8])