function J = critere(a, b, u, y)
    y_m = reponse(a, b, u);
    e = y_m - y;
    J = e'*e;
end
