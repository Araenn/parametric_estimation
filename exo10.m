clc; clear; close all

N = 900;
k = 0:N-1;
dt = 1;
t = (k*dt)';
p = 2;
T = 150;
test = menu("Choix du theta", "theta stationnaire", "theta non stationnaire");
if test == 1
    lambda = 1;
    for k = 1:N  
        a1(k) = -0.5;
        b0(k) = 0.5;
    end
else
    lambda = 0.95;
    for k = 1:N
        if k <= 350
            a1(k) = -0.5;
            b0(k) = 0.3;
        else
            a1(k) = 0.5;
            b0(k) = -0.3;
        end
    end
end

test = menu("Choix de la séquence u", "signal carré", "spba");
if test == 1
    u = square(2*pi/T*t);
else 
    u = randn(N,1);
end

s = zeros(N,1);
y = zeros(N,1);
s(1) = b0(1)*u(1);
sigma = 0.02;
e = sigma*randn(N,1);
for i = 2:N
    s(i) = -a1(i)*s(i-1)+b0(i)*u(i);
    y(i) = s(i)+e(i);
end

k = 800;
C = [-y(1:k) u(2:k+1)];
theta_est = inv(C'*C)*C'*y(2:k+1);

theta_mcr = zeros(p,N); %initialisation
P = 10^12*eye(p,p);
theta_mcr(:,1) = [0;0];

for j = 2:N
    m = [-y(j-1) u(j)]';
    k = (P*m)/(lambda+m'*P*m);
    P = (P - k*m'*P)/lambda;
    y_est = m'*theta_mcr(:,j-1);
    theta_mcr(:,j) = theta_mcr(:,j-1) + k*(y(j)-y_est);
end

figure(1)
plot(s)
hold on
plot(y)
grid()
title("Sortie y bruitée et non bruitée")
legend("non bruitée", "bruitée")

figure(2)
plot(theta_mcr')
grid()
hold on
plot(a1)
plot(b0)
title("\theta estimé")
legend("\theta_1 estimé", "\theta_2 estimé", "\theta_1 réel", "\theta_2 réel")