function [] = Plotter(sample_params, max_nuu, num_evals, n_variate, panel_name)
% plots
% n_variate = num of Monte Carlo variates
rng(11) % set seed

% parameters
n = sample_params(1);
j = sample_params(2);
alpha = sample_params(3);
theta = sample_params(4);

% =========================================================================
% Method comparison

% evaluate intervals for num_eval points on interval [0.01n, max_nu*n]
M = floor(n*linspace(0.01, max_nuu, num_evals));
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

    % exact via inverse transform and Mittag-Leffler intervals
    if alpha<0.001 
        % Dirichlet case - no Mittag-Leffler interval
        exact_py = rand_posterior_pd(m,n,theta,n_variate);
    else
        % Pitman-Yor case:
        % sample from exact distribution
        exact_py = rand_posterior_py(m,n,j,alpha,theta,n_variate);
        
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
    
end
M = [0, M]; % add m = 0

% =========================================================================
% plot (panels of figure 1.2)

    figure()

if alpha< 0.001 % Dirichlet case
    plot (M, means ,'k', 'LineWidth', 1) % plot means
    hold on
    % plot exact intervals
    plot (M, true_intervals(1, :) ,'k--', 'LineWidth', 0.8)
    hold on
    plot (M, true_intervals(2, :) ,'k--', 'LineWidth', 0.8)
    
    % plot Gaussian intervals (shaded)
    M2 = [M, fliplr(M)];
    inBetween = [clt_intervals(2, :), fliplr(clt_intervals(1, :))];
    fill(M2, inBetween, 'magenta','FaceAlpha',0.1, 'EdgeAlpha', 0.1, ...
        'EdgeColor','magenta');
    
    % graphical specifications
    yl = ylim; 
    ylim([0, yl(2)]); 

    xl = xlim; 
    xlim([xl(1), 5*n]); 

    xticks(floor(n*[0, 1, 2, 3, 4, 5]))
    xticklabels({'$0$', '$n$', '$2n$', '$3n$', '$4n$', '$5n$'})
    set(gca,"FontSize",40)

    xlabel('$m$')

else % Pitman-Yor case
    plot (M, means ,'k', 'LineWidth', 1) % plot means
    hold on
    % plot exact intervals
    plot (M, true_intervals(1, :) ,'k--', 'LineWidth', 0.8)
    hold on
    plot (M, true_intervals(2, :) ,'k--', 'LineWidth', 0.8)
    
    % plot M-L and Gaussian intervals (shaded)
    M2 = [M, fliplr(M)];
    inBetween = [clt_intervals(2, :), fliplr(clt_intervals(1, :))];
    fill(M2, inBetween, 'magenta','FaceAlpha',0.1, 'EdgeAlpha', 0.1, ...
        'EdgeColor','magenta');
    inBetween2 = [pitman_intervals(2, :), fliplr(pitman_intervals(1, :))];
    fill(M2, inBetween2, 'blue','FaceAlpha',0.1, 'EdgeAlpha', 0.1, ...
        'EdgeColor','black');
    
    % graphical specifications
    yl = ylim; 
    ylim([0, yl(2)]); 

    xl = xlim; 
    xlim([xl(1), 5*n]); 

    xticks(floor(n*[0, 1, 2, 3, 4, 5]))
    xticklabels({'$0$', '$n$', '$2n$', '$3n$', '$4n$', '$5n$'})
    set(gca,"FontSize",40)

    xlabel('$m$')
end

figname = sprintf('PANEL_%s.fig', panel_name);
savefig(figname)
end