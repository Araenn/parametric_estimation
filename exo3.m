clc; clear; close all

N = 500;
k = [1:N]';
t = (k-1)*0.001;
a = 3;
phi = pi/5;
f0 = 20;

sigma = 1;
e = sigma*randn(N,1);
x = a*sin(2*pi*f0*t + phi);
y = x + e;

figure(1)
plot(t, x)
hold on
plot(t, y)
grid()
M = [sin(2*pi*f0*t) cos(2*pi*f0*t)];
theta = [a*cos(phi) a*sin(phi)]';
theta_c = [inv(M'*M)*M'*y]; 
y_c = M*theta_c;
plot(t, y_c, 'x')
phi_c = atan(theta_c(2)/theta_c(1))
a_c = sqrt(theta_c(1)^2 + theta_c(2)^2)

legend("x : signal vrai", "y : signal mesuré", "estimation")