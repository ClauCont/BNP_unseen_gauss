function [Kmn] = MC_Knm(n, m, Kn, alpha, theta, n_var)
% Monte Carlo sampling from predictive distribution of Kn

K = Kn;
i = 0;
while i< m
    i = i +1;

    p = (theta + alpha*K)/(theta+n+i);
    X = double(rand(1, n_var) < p);

    K = K + X;

end
 Kmn = K-Kn;

