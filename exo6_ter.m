clc; clear; close all

N = 2000;
k = [1:N]';
t = (k-1)*0.001;
p = 2;
f0 = 10;

sigma = 0.1;
e = sigma*randn(N,1);


%a, x, y
alpha = ((5-3)/(1250-750));
beta = 3-alpha*750; 
gamma = (((2*pi/5)-(pi/5))/(1250-750));
delta = (pi/5)-gamma*750;
x = zeros(N,1);
y = zeros(N,1);
for i = 1:N
    if k(i) <= 750
        a(i) = 3;
        phi(i) = pi/5;
    elseif 1250 <= k(i)
        a(i) = 5;
        phi(i) = 2*pi/5;
    else
        a(i) = alpha*k(i) + beta;
        phi(i) = gamma*k(i) + delta;
    end
    x(i) = a(i)*sin(2*pi*f0*t(i) + phi(i));
    y(i) = x(i) + e(i);
end

%mcr lambda
theta_mcr = zeros(p,N); %initialisation
P = 10^12*eye(p,p);
theta_mcr(:,1) = [0;0];
lambda = 0.95;
for j = 2:N
    m = [sin(2*pi*f0*t(j)) cos(2*pi*f0*t(j))]';
    k = (P*m)/(lambda+m'*P*m);
    P = (1/lambda)*(P - k*m'*P);
    y_est(:,j) = m'*theta_mcr(:,j-1);
    theta_mcr(:,j) = theta_mcr(:,j-1) + k*(y(j)-y_est(:,j));
    a_mcr(:,j) = sqrt(theta_mcr(1,j).^2 + theta_mcr(2,j).^2);
    phi_mcr(:,j) = atan2(theta_mcr(2,j),theta_mcr(1,j));
end

%fenetre glissante
M = [sin(2*pi*f0*t) cos(2*pi*f0*t)];
Nf = 100;
u = 1:Nf;
for i = 1:(N-Nf+1)
    Mf = M(u,:); %1 a nf, toutes colonnes
    yf = y(u);
    theta_f(:,i) = inv(Mf'*Mf)*Mf'*yf;
    u = u + 1;
    a_f(i) = sqrt(theta_f(1,i)^2 + theta_f(2,i)^2);
    phi_f(i) = atan2(theta_f(2,i),theta_f(1,i));
end

figure(1)
plot(a)
grid()
hold on
plot(y)
plot(-a)
plot(y_est, 'x')
legend("a", "y : signal mesuré", "-a", "y estime")

figure(2)
subplot(2,1,1)
plot(a)
hold on
plot(a_mcr)
grid()
legend("a", "a estime")
subplot(2,1,2)
plot(phi*ones(N,1))
hold on
plot(phi)
grid()
legend("phi", "phi estime")

figure(3)
subplot(2,1,1)
plot(a)
hold on
plot(a_f)
grid()
legend("a", "a estime")

subplot(2,1,2)
plot(phi)
hold on
plot(phi_f)
grid()
legend("phi", "phi estime")

title("fenetre glissante")