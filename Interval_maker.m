function [intervals] = Interval_maker(sample_params,M, exact_method, n_variate)
rng(11)

% extract sample parameters
n = sample_params(1);
j = sample_params(2);
alpha = sample_params(3);
theta = sample_params(4);

num_samples = length(M);

norm = norminv(0.975); % 97.5 percentile of standard Gaussian distribution

% initialize intervals
true_intervals = zeros(2, num_samples+1);
pitman_intervals = zeros(2, num_samples+1);
clt_intervals = zeros(2, num_samples+1);
means = zeros(1, num_samples +1);

% compute intervals
for i = 1: num_samples
    m = M(i); % length of additional sample

    % exact and Mittag-Leffler intervals
    if alpha<0.001 % Dirichlet case - no Mittag-Leffler interval
        exact_py = rand_posterior_pd(m,n,theta,n_variate);
    else
        % Pitman-Yor case:
        if strcmp(exact_method, 'inverse')
            % sample from exact distribution
            exact_py = rand_posterior_py(m,n,j,alpha,theta,n_variate);
        elseif strcmp(exact_method, 'MonteCarlo')
            exact_py = MC_Knm(n,m,j, alpha, theta, n_variate); 
        else
            error ('Error: invalid value for exact_method')
        end
        
        % Mittag-Leffler intervals
        limit_py = rand_limit_posterior_py(n, j, alpha, theta, n_variate);
        dx_lim = prctile(limit_py, 97.5);
        sx_lim = prctile(limit_py, 2.5);
        r = (theta + n + m)^alpha - (theta + n)^alpha; % adjusted rate
        % intervals:
        adj_sx_95_lim_ci = r.*sx_lim;
        adj_dx_95_lim_ci = r.*dx_lim;

        pitman_intervals(:, i+1) = [adj_sx_95_lim_ci, adj_dx_95_lim_ci];
    end
    
    % exact intervals
    dx = prctile(exact_py, 97.5);
    sx = prctile(exact_py, 2.5);
    
    % Gaussian approximation:
    % nu, tau, rho, lambda
    nu = n/m;
    tau = theta/m;
    rho = j/m;
    lambda = nu + tau;

    % approximating normal: mean and variance
    L = ((lambda+1)/lambda)^alpha;

    mean = (tau + rho*alpha)*(L-1)/alpha;
    variance = ((tau + rho*alpha)/(nu + tau))*L*((nu+tau)*(L-1)/alpha - ...
        (tau + rho*alpha)*L/(lambda+1));
    
    % Gaussian intervals
    clt_dx = m*mean + norm*sqrt(variance*m);
    clt_sx = m*mean - norm*sqrt(variance*m);


    % update results
    true_intervals(:, i+1) = [sx, dx];
    clt_intervals(:, i+1) = [clt_sx, clt_dx];
    means(i+1) = m*mean;
    
    % output
    intervals = [true_intervals; pitman_intervals; clt_intervals,; means];
end

end