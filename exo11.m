clc; clear; close all

N = 900;
k = 0:N-1;
dt = 1;
t = (k*dt)';
p = 4;
T = 150;
test = menu("Choix du theta", "theta stationnaire", "theta non stationnaire");
if test == 1
    lambda = 1;
    for k = 1:N
        a1(k) = -0.5;
        a2(k) = 0.3;
        b0(k) = 0.5;
        b1(k) = 1;
    end
else
    lambda = 0.95;
    for k = 1:N
        if k <= 350 
            a1(k) = -0.5;
            a2(k) = 0.3;
            b0(k) = 0.5;
            b1(k) = 1;
        elseif k <= 600 
            a1(k) = 0.5;
            a2(k) = -0.3;
            b0(k) = 0.5;
            b1(k) = 1;
        else
            a1(k) = 0.5;
            a2(k) = -0.3;
            b0(k) = 0.9;
            b1(k) = 1.6;
        end
    end
end

test = menu("Choix de la séquence u", "signal carré", "spba");
if test == 1
    u = square(2*pi/T*t);
else 
    u = randn(900,1);
end

s = zeros(N,1);
y = zeros(N,1);
s(1) = b0(1)*u(1);
s(2) = -a1(2)*s(1)+b0(2)*u(2)+b1(2)*u(1);
test = menu("Choix du sigma", "0", "0.02", "0.2", "0.5");
if test == 1
    sigma = 0;
elseif test == 2
    sigma = 0.02;
elseif test == 3
    sigma = 0.2;
else
    sigma = 0.5;
end
e = sigma*randn(N,1);
for i = 3:N
    s(i) = -a1(i)*s(i-1)-a2(i)*s(i-2)+b0(i)*u(i)+b1(i)*u(i-1);
    y(i) = s(i)+e(i);
end

k = 800;
C = [-y(2:k) -y(1:k-1) u(3:k+1) u(2:k)];
theta_est = inv(C'*C)*C'*y(2:k);

theta_mcr = zeros(p,N); %initialisation
P = 10^12*eye(p,p);
theta_mcr(:,1) = [0 0 0 0];

for j = 3:N
    m = [-y(j-1) -y(j-2) u(j) u(j-1)]';
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
plot(a1, 'b.')
plot(a2, 'r.')
plot(b0, 'y.')
plot(b1, 'm.')
title("\theta estimé")
legend("a_1 estimé", "a_2 estimé", "b_0 estimé", "b_1 estimé","a_1 réel", "a_2 réel", "b_0 réel", "b_1 réel")