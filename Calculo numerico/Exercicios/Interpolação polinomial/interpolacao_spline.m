clear
clc

# INPUTS

x = [0	3.1642	6.5322	7.7556	8.5130	11.8264	12.7257 14.2 15.8 16.89 17.5];
y = [0	3.9966	9.1534	11.2351	14.4995	17.5274	19.9402 22.6 23.8 24.1 25.8];

# CALCULANDOS OS POLINOMIOS INTERPOLADORES (SPLINES)

s = spline(x,y);

# SUBSTITUINDO VALORES

xx = min(x):0.01:max(x);
yy = ppval(s,xx);

plot(x,y,"o")
hold on
plot(xx,yy)

