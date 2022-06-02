clc; clear; close all

N = 100;
k = [1:N]';
t = (k-1)*(100*10^-3);
x0 = 5;
v = 10;

sigma = 3;
e = sigma*randn(N,1);
x = x0 + v*t;
y = x + e;

figure(1)
plot(t, x)
hold on
plot(t, y)
grid()
M = [t ones(N,1)];
theta = [v x0]';
theta_c = [inv(M'*M)*M'*y];
y_c = M*theta_c;
plot(t, y_c, 'x')

legend("x : signal vrai", "y : signal mesuré", "estimation")