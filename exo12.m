clc; clear; close all

T = 150;
N = 900;

a1 = -0.5;
b0 = 0.5;
a_est = -0.35;
b_est = 0.4;
sigma = 0.02;
e = sigma*randn(N, 1);
k = 0:N-1;
dt = 1;
t = (k*dt)';
theta = [a1 b0];
u = square(2*pi/T*t);


s = reponse(a1, b0, u);
y = s + e;

figure(1)
% J = critere(a_est, b_est,u,y);
% dJ = gradient(a_est, b_est, u, y);
plot(u)
hold on
plot(s, "LineWidth", 2)
plot(y)
grid()
legend("Entrée u", "Sortie y_{M,k}", "Sortie y_k")
title("Entrée, sortie et sortie bruitée")

lambda = 10^-5;
flag = true;
theta_0 = [a_est;b_est];
Theta = theta_0;
J1 = critere(theta_0(1), theta_0(2), u, y);
k = 1;
J_p = J1;
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
    J_p = [J_p J_est];
end

figure(2)
subplot(2,1,1)
plot(Theta')
grid()
legend("\theta_1", "\theta_2")
title("\theta estimé")
subplot(2,1,2)
plot(J_p)
grid()
title("Evolution du critère")