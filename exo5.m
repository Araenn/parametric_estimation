clc; clear; close all

N = 2000; %+ n est grand, + mco long, mcr cst (0.04s). grandes variations de theta_est pour mco.
k = [0:N-1]';
t = k*0.001;
a = 10;

sigma = 2;
e = sigma*randn(N,1);
y = a + e;

%mco
t1 = cputime;
for i = 1:N
    M = ones(i,1);
    theta(i) = [inv(M'*M)*M'*y(1:i)];
end
temps_MCO = cputime - t1

%mcr
t2 = cputime;
theta_mcr(1) = 0; %initialisation
P = 10^12;
for j = 1:N-1
    m = 1;
    k = (P*m)/(1+m'*P*m);
    P = P - k*m'*P;
    y_est = m'*theta_mcr(j);
    theta_mcr(j+1) = theta_mcr(j) + k*(y(j+1)-y_est);
end
temps_MCR = cputime - t2

figure(1)
plot(t, y)
grid()
title("Données")

figure(2)
plot(theta)
hold on
plot(a*ones(N,1), 'r')
grid()
title("MCO")

figure(3)
plot(theta_mcr)
grid()
hold on
plot(a*ones(N,1), 'r')
plot(theta)
title("MCR")
legend("MCR", "a", "MCO")