function [] = Plotter(sample_params, max_nuu, num_evals, n_variate, panel_name)

ML_method = 'inverse';
rng(11) % set seed

% extract sample parameters
n = sample_params(1);
j = sample_params(2);
alpha = sample_params(3);
theta = sample_params(4);

% make intervals
% evaluate intervals for num_eval points on interval [0.01n, max_nu*n]
M = floor(n*linspace(0.01, max_nuu, num_evals));
num_samples = length(M);

[true_intervals, pitman_intervals, clt_intervals, means] = ...
    Interval_maker(sample_params,M, ML_method, n_variate)

M = [0, M]; % add m = 0

% plot panels

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