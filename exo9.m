clc; clear; close all

choix_spba = menu("Choix de la séquence", "spba : p = 7", "spba : p = 16", "spba : bruit gaussien blanc, p = 28");
if choix_spba == 1
    spba = [1 -1 1 1 1 -1 -1]';
    p = 7;
elseif choix_spba == 2
    spba = [1 -1 1 1 1 -1 -1 1 -1 1 1 -1 -1 1 1 -1]';
    p = 16;
elseif choix_spba == 3
    spba = randn(28,1);
    p = 28;
end
Nu = 30*p;

k = 30;
u = spba;
for i = 1:k-1
    u = [u; spba];
end

figure(1)
plot(u)
grid()
title("Entrée u")

h = zeros(k,1);
h(1) = 0;
for n = 1:k
    h(n) = (0.3)^(n-1)*0.7;
end
Nh = 12;
h = [0;h];
t = [0:Nh-1]';

figure(2)
plot(t, h(1:Nh))
grid()
title("Réponse impulsionnelle h")

y = conv(u, h);
sigma = 0.2;
e = sigma*randn(length(y),1);
y = y + e;
figure(3)
plot(y)
grid()
title("Sortie y bruitée de \sigma = 0.2")

figure(4)
M = 80; %nbr echantillons
v = [0:M-1]';
plot(v, u(1:M))
hold on
plot(v, y(1:M))
grid()
legend("u", "y")
title("Entrée u et sortie y sur 80 échantillons")

test = menu("Choix du N", "p-1", "p", "Nh-1", "Nh", "p+1");
if test == 1
    N = p-1;
elseif test == 2
    N = p;
elseif test == 3
    N = Nh-1;
elseif test == 4
    N = Nh;
else
    N = p+1;
end

indice = N:N+M-1;
U = u(indice);
for l = 1:N-1
    U = [U u(indice-l)];
end
h_est = inv(U'*U)*U'*y(indice);

figure(5)
plot(h(1:length(h_est)))
hold on
plot(h_est)
grid()
legend("h", "h estimé")
title("h et h estimé")