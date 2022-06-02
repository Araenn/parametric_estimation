clc; clear; close all

N = 20;
a = 2;
b = 0.25;
sigma = sqrt(0.1);
e = sigma*randn(N,1);
dt = 1;
k = 0:N-1;
t = (k*dt)';
p = 2;

y = a*exp(-b*t)+e;
y_da = exp(-b*t); %derivee en a
y_db = -a*exp(-b*t); %derivee en b

figure(1)
plot(t,y)
hold on
plot(t, y_da)
plot(t, y_db)
grid()
title("Mesures y_k et dérivées du signal non bruité")
legend("Signal mesuré", "dérivée en \alpha", "dérivée en \beta") 

%test algo
