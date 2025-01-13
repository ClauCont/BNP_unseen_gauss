function [Kmn] = MC_Knm( n, m, Kn, alpha, theta, n_var)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
K = Kn;
i = 0;
while i< m
    i = i +1;

    p = (theta + alpha*K)/(theta+n+i);
    X = double(rand(1, n_var) < p);

    K = K + X;

end
 Kmn = K-Kn;


% Require: n, Kn, m, α, θ
% function MonteCarloK(n, Kn, m, α, θ)
% K ← Kn
% for i ← 0 to m − 1 do
% b ← Random sample from Bernoulli 􏰁 θ+αK 􏰂 θ+n+i
% K←K+b end for
% returnK(n) =K−K mn
% end function