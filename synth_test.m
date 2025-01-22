%% run tests: synthetic data
clear all
close all
clc

% change all interpreters from tex to latex. 
list_factory = fieldnames(get(groot,'factory'));
index_interpreter = find(contains(list_factory,'Interpreter'));
for i = 1:length(index_interpreter)
    default_name = strrep(list_factory{index_interpreter(i)},'factory','default');
    set(groot, default_name,'latex');
end

% set seed
rng(0, 'twister')

%% generate data and EB for parameters (table 4.1)

panel_A = synthetic('zipf', [2, 300, 4]);
panel_B = synthetic('zipf', [1.5, 100, 4]);
panel_C = synthetic('dir', [0, 500, 4]);
panel_D = synthetic('unif', [0, 500, 4]);

Table1 = [panel_A; panel_B; panel_C; panel_D];

writematrix(Table1,"Table1.txt");

%% plots figure 1.2
max_nu = 5; % 5
num_evals = 50; % 50
n_variate = 2000; % 2000
level = 0.95;
Plotter(panel_A, max_nu, level, num_evals, n_variate, 'A', 'True')
Plotter(panel_B, max_nu, level, num_evals, n_variate, 'B', 'True')
Plotter(panel_C, max_nu, level, num_evals, n_variate, 'C', 'True')
Plotter(panel_D, max_nu, level, num_evals, n_variate, 'D', 'True')

%% table 4.5
nu_points = [1, 2, 3, 4, 5];
exact_method = 'inverse';
Tabler(panel_A, nu_points, level, n_variate, 'A', exact_method)
Tabler(panel_B, nu_points, level, n_variate, 'B', exact_method)
Tabler(panel_C, nu_points, level, n_variate, 'C', exact_method)
Tabler(panel_D, nu_points, level, n_variate, 'D', exact_method)


%% table 4.6
nu_points = [10, 50, 100, 1000];
n_variate = 2000;
exact_method = 'MonteCarlo';
Tabler(panel_A, nu_points, level, n_variate, 'A', exact_method)
Tabler(panel_B, nu_points, level, n_variate, 'B', exact_method)
Tabler(panel_C, nu_points, level, n_variate, 'C', exact_method)
Tabler(panel_D, nu_points, level, n_variate, 'D', exact_method)
disp(rng)

