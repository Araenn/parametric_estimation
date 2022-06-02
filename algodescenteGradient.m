function theta_est = algodescenteGradient(a, b, u, y, lambda)
    J = critere(a, b, u, y);
    theta = [a;b];
    flag = true;
    k = 1;
    while flag
        theta = theta - k*lambda*gradient(theta(1),theta(2),u,y);
        J_est = critere(theta(1),theta(2), u, y);
        if J_est >= J
            flag = false;
            theta_est = theta;
        end
        k = k+1;
        J = J_est;
    end
end