clc; clear; close all

T = 150;
N = 900;

a1 = -0.5;
a2 = 0.3;
b0 = 0.5;
b1 = 1;
a1_est = -0.35;
a2_est = 0.5;
b0_est = 0.4;
b1_est = 0.8;

sigma = 0.02;
e = sigma*randn(N-1, 1);
k = 2:N;
dt = 1;
t = (k*dt)';

u = square(2*pi/T*t);
a = [a1;a2];
b = [b0;b1];
s = reponse(a,b, u);
y = s + e;

figure(1)
plot(u)
hold on
plot(s, "LineWidth", 2)
plot(y)
grid()
legend("Entrée u", "Sortie y_{M,k}", "Sortie y_k")
title("Entrée, sortie et sortie bruitée")

lambda = 10^-5;
flag = true;
a_est= [a1_est;a2_est];
b_est = [b0_est;b1_est];

theta_0 = [a_est;b_est];
Theta = theta_0;
J1 = critere(a_est, b_est, u, y);
k = 1;
while flag
    theta_tmp = algodescenteGradient(theta_0(1),theta_0(2),u,y,lambda);
    J_est = critere(theta_tmp(1),theta_tmp(2), u, y);
    
    if abs(J_est - J1) < 1e-5
        flag = false;
        theta_est = theta_0;
    end
    J1 = J_est;
    theta_0 = theta_tmp;
    k = k+1;
    Theta = [Theta theta_tmp];
end

% test = [Theta;Theta_2];
figure(2)
plot(Theta)
hold on
plot(a1*ones(length(Theta),1))
plot(a2*ones(length(Theta),1))
grid()
legend("\theta_1 estimé", "\theta_2 estimé", "\theta_1", "\theta_2")