function dJ = gradient(a, b, u, y)
    N = length(a);
    M = length(b);
    h = 10^-5;
    theta = [a b];
    for k = 1:length(theta)
        J = critere(a, b, u, y);
        for i = 1:N
            a_est = a;
            a_est(i) = a(i) + h;
            dJa(i) = (critere(a_est, b, u, y) - J)/h;
        end
        for i = 1:M
            b_est = b;
            b_est(i) = b(i) + h;
            dJb(i) = (critere(a, b_est, u, y) - J)/h;
        end
        dJ = [dJa;dJb];
    end
end