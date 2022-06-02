function s = reponse(a, b, u)
    N = length(u);
    L = length(a);
    P = length(b);
    s = zeros(N,1);
    for i = 1:L
        s(i) = 0;
        for k = 1:i-1
            s(i) = s(i) - a(k)*s(i-k);
        end
        for k = 0:i-1
            s(i) = s(i) + b(k+1)*u(i-k);
        end
    end
    for i = L+1:N
        s1 = 0;
        for k = 1:L
            s1 = s1 + a(k)*s(i-k);
        end
        s2 = 0;
        for k = 0:P-1
            s2 = s2 + b(k+1)*u(i-k);
        end
        s(i) = -s1 + s2;
    end
end