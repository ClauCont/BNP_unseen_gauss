function [] = Tabler(sample_params, nu_points, level, n_variate, panel_name, exact_method)

% extract sample parameters
n = sample_params(1);
j = sample_params(2);
alpha = sample_params(3);
theta = sample_params(4);

nu_points(nu_points == 0) = 0.01; % rand_posterior_py returns NaN if m = 0

M = floor(n*nu_points);

intervals = Interval_maker(sample_params,M, level, exact_method, n_variate);
true_intervals = intervals(1:2, :);
pitman_intervals = intervals(3:4, :);
clt_intervals = intervals(5:6, :);
means = intervals(7, :);

% coverage
num_samples = length(M);
coverage_ml = zeros(1, num_samples);
coverage_gauss = zeros(1, num_samples);


coverage_ml = Coverage(true_intervals, pitman_intervals);
coverage_gauss = Coverage(true_intervals, clt_intervals);

coverage_ml(1) = 1;
coverage_gauss(1) = 1;


% save in txt 
Table = [intervals; coverage_ml; coverage_gauss];
filename = sprintf('Table_%s_%s.txt', panel_name, exact_method);
writematrix(Table, filename);








