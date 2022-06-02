clc; clear; close all

a = [1900:10:1980]';
a_p = [1900:10:2000]';
y = [1000 1050 1104 1158 1212 1268 1323 1381 1400]';
N = length(a);
N_p = length(a_p);

%lineaire
figure(1)
M = [a ones(N,1)];
M_p = [a_p ones(N_p,1)];
theta = [inv(M'*M)*M'*y];
plot(a, y, 'x')
hold on
y_c = M*theta;
plot(a, y_c)
grid()
y_p = M_p*theta;
hold on
plot(a_p, y_p, 'x') 

%quadratique
figure(2)
a = a - 1900;
a_p = a_p - 1900;
M_q = [a.^2 a ones(N,1)];
M_qp = [a_p.^2 a_p ones(N_p,1)];
theta_q = [inv(M_q'*M_q)*M_q'*y];
plot(a, y, 'x')
hold on
y_q = M_q*theta_q;
plot(a, y_q)
grid()
y_pq = M_qp*theta_q;
hold on
plot(a_p, y_pq, 'x')

%p3
figure(3)
M_p3 = [a.^3 a.^2 a ones(N,1)];
M_q = [a_p.^3 a_p.^2 a_p ones(N_p,1)];
theta_p3 = [inv(M_p3'*M_p3)*M_p3'*y];
plot(a, y, 'x')
hold on
y_p3 = M_p3*theta_p3;
plot(a, y_p3)
grid()
y_p = M_q*theta_p3;
hold on
plot(a_p, y_p, 'x')

%p7
figure(4)
M_p7 = [a.^7 a.^6 a.^5 a.^4 a.^3 a.^2 a ones(N,1)];
M_q = [a_p.^7 a_p.^6 a_p.^5 a_p.^4 a_p.^3 a_p.^2 a_p ones(N_p,1)];
theta_p7 = [inv(M_p7'*M_p7)*M_p7'*y];
plot(a, y, 'x')
hold on
y_p7 = M_p7*theta_p7;
plot(a, y_p7)
grid()
y_p = M_q*theta_p7;
hold on
plot(a_p, y_p, 'x')