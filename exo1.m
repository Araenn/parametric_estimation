clc; clear; close all

N = 10;
t = [0:1:N-1]';
y = [-1.04 1.21 3.36 4 5.43 8.45 10.67 13.61 15.12 16.11]';

M = [t ones(N,1)]
theta = [inv(M'*M)*M'*y]

figure(1)
plot(t, y, 'x')
grid()
xlabel('Temps t_k')
ylabel('Mesures y_k')
hold on
y_est = M*theta; %modele
plot(t, y_est)
hold on
theta_bis = [0.01 -0.02]';
y_bis = M*theta_bis;
plot(t, y_bis)
e_bis = y - y_bis;
J_bis = e_bis'*e_bis
legend('mesures', 'modele', 'modele bis')

figure(2)
e = y - y_est; %erreur
J = e'*e %critere
plot(t, e, 'x')
hold on
plot(t, e_bis, 'x')
grid()
legend('e', 'e_bis')

figure(3)
M_p = [t.^2 t ones(N,1)];
theta_p = [inv(M_p'*M_p)*M_p'*y]
plot(t, y, 'x')
hold on
y_p = M_p*theta_p;
plot(t, y_p)
grid()
e = y - y_p; %erreur
J_p = e'*e %critere

figure(4)
M_p3 = [t.^3 t.^2 t ones(N,1)];
theta_p3 = [inv(M_p3'*M_p3)*M_p3'*y]
plot(t, y, 'x')
hold on
y_p3 = M_p3*theta_p3;
plot(t, y_p3)
grid()
e = y - y_p3; %erreur
J_p3 = e'*e %critere