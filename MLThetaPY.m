function params = MLThetaPY(counts, alpha_guess, options)%, plott)
% estimate theta maximizing eppf

k = length(counts);
n = sum(counts);
k_range = linspace(0, k-1, k-1);

minus_log_eppf = @(P) sum(log(P(2) + k_range*P(1))) ...
    - gammaln(P(2) + n) + gammaln(P(2)+1 ) ...
    + sum(gammaln(counts - P(1)))- k*gammaln(1 - P(1));
fun = @(P) - minus_log_eppf(P);
%fun2 = @(theta) - minus_log_eppf([alpha_guess, theta]);

lb = [0,0];
ub = [1,inf];
A = [];
b = [];
Aeq = [];
beq = [];

params = fmincon(fun,  [alpha_guess, 1], A,b,Aeq,beq,lb,ub);  %(fun, [alpha_guess, 0], [0, 0],[1 inf], options);%, [exp(-8), 10*exp(8)]);
%theta = fminsearchbnd(fun2, 0, 0, inf);%, [exp(-8), 10*exp(8)]);
%params = [alpha_guess, theta]

% if plott == 1
%     xx = linspace(0, 5*ceil(theta), 200);
%     figure(1)
%     plot(xx, minus_log_eppf(xx));
%     hold on
%     plot(theta,minus_log_eppf(theta), 'r*', 'LineWidth',1);
% 
%     formatSpec = 'Dirichlet EPPF, optimal theta = %.2f';
%     titlestr = sprintf(formatSpec, theta);
%     title(titlestr);
% end

end