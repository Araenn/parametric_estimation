clc; clear; close all

N = 2000;
k = [1:N]';
t = (k-1)*(100*10^-3);
x0 = 5;
v = 10;
p = 2;

sigma = 3;
e = sigma*randn(N,1);
x = x0 + v*t;
y = x + e;

figure(1)
plot(t, x)
hold on
plot(t, y)
grid()
legend("x : signal vrai", "y : signal mesuré")

theta_mcr = zeros(p,N); %initialisation
P = 10^12*eye(p,p);
theta_mcr(:,1) = [0;0];
for j = 2:N
    m = [t(j) 1]';
    k = (P*m)/(1+m'*P*m);
    P = P - k*m'*P;
    y_est = m'*theta_mcr(:,j-1);
    theta_mcr(:,j) = theta_mcr(:,j-1) + k*(y(j)-y_est);
    x0_mcr(:,j) = theta_mcr(2,j);
    v_mcr(:,j) = theta_mcr(1,j);
end

figure(2)
plot(theta_mcr')
grid()
title("\theta")
legend("\theta_1", "theta_2")

figure(3)
plot(x0_mcr)
hold on
plot(v_mcr)
grid()
legend("x0", "v")
title("x0 et v")