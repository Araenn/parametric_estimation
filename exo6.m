clc; clear; close all

N = 2000;
k = [1:N]';
t = (k-1)*0.001;
a = 3;
phi = pi/5;
f0 = 20;
p = 2;

sigma = 1;
e = sigma*randn(N,1);
x = a*sin(2*pi*f0*t + phi);
y = x + e;

figure(1)
plot(t, x)
hold on
plot(t, y)
grid()
legend("x : signal vrai", "y : signal mesuré")
title("Données")

figure(3)
theta_mcr = zeros(p,N); %initialisation
P = 10^12*eye(p,p);
theta_mcr(:,1) = [0;0];

for j = 2:N
    m = [sin(2*pi*f0*t(j)) cos(2*pi*f0*t(j))]';
    k = (P*m)/(1+m'*P*m);
    P = P - k*m'*P;
    y_est(:,j) = m'*theta_mcr(:,j-1);
    theta_mcr(:,j) = theta_mcr(:,j-1) + k*(y(j)-y_est(:,j));
    phi_mcr(:,j) = atan2(theta_mcr(2,j),theta_mcr(1,j));
    a_mcr(:,j) = sqrt(theta_mcr(1,j).^2 + theta_mcr(2,j).^2);
end

figure(2)
plot(theta_mcr')
grid()
title("MCR : \theta")
legend("\theta_1", "\theta_2")

figure(3)
plot(phi_mcr)
hold on
plot(a_mcr)
grid()
title("\phi et a")
legend("\phi", "a")