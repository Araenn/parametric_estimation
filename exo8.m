clc; clear; close all

f0 = 0.05; %Hz
N = 40;
dt = 1; %seconde
M = 8*N; %nbr de mesures
L = 32*N;
sigma = 0.1;
e = sigma*randn(L,1);

th = (0:N-1)'*dt;
h = sin(2*pi*f0*th).*exp(-0.2*th); %à trouver

t = (0:L-1)'*dt;

alpha = 0.002;
test = menu("Choix du type d'entrée", 'exp(-0.005*t)', 'quest 2', 'quest 3', 'carrée', 'spba');
if test == 1
    u = exp(-0.005*t);
elseif test == 2
    t1 = t(1:M/2);
    t2 = t(M/2+1:L);
    u = [exp(-0.005*t1);exp(-0.005*t2)+2*exp(-0.001*t2)];
elseif test == 3
    t1 = t(1:M/4);
    t2 = t((M/4)+1:M/2);
    t3 = t((M/2)+1:(3*M/4));
    t4 = t(((3*M/4)+1):L-1);
    for z = 1:2
        s1 = z*exp(-z*alpha*t3);
    end
    for z = 1:3
        s2 =tmp z*exp(-z*alpha*t4);
    end
    u = [exp(-0.005*t1);exp(-0.005*t2)+2*exp(-alpha*t2);exp(-0.005*t3)+2*s1;exp(-0.005*t4)+2*s2];
elseif test == 4
    D = pi/40;
    u = square(0:D:(L-1)*D)';
elseif test == 5
    u = sbpa(dt, 8, 1, 1, 20);
    u = u(1:L);
end
y = conv(u, h);
y = y(1:L) + e;
J = 0;
indice = N+J:N+J+M-1;
U = u(indice);

for k = 1:N-1
    U = [U u(indice-k)];
end
h_est = inv(U'*U)*U'*y(indice);
y_est = conv(u, h_est);

epsilon = sqrt((abs(h_est-h)).^2) %erreur quadratique moyenne
figure(1)
subplot(3,1,1)
plot(u)
grid()
hold on
plot(y_est)
legend("Entrée u", "Sortie bruitée")
title("Entrée u et sortie bruitée")

subplot(3,1,2)
plot(h)
hold on
plot(h_est)
title("h et h_{est}")
grid()
legend("h", "h_{est}")
title("Réponses impulsionnelles")

subplot(3,1,3)
plot(y)
hold on
plot(y_est)
grid()
legend("y", "y bruité")
title("Sorties avec et sans bruit, \sigma = 0.1")