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
rng(11)

%% generate data and EB for parameters (table 4.1)

panel_A = synthetic('zipf', [2, 300, 4]);
panel_B = synthetic('zipf', [1.5, 100, 4]);
panel_C = synthetic('dir', [0, 500, 4]);
panel_D = synthetic('unif', [0, 500, 4]);

Table1 = [panel_A; panel_B; panel_C; panel_D];

writematrix(Table1,"Table1.txt");

%% plots figure 1.2
max_nu = 1; % 5
num_evals = 2; % 50
n_variate = 2; % 2000
Plotter(panel_A, max_nu, num_evals, n_variate, 'A')
Plotter(panel_B, max_nu, num_evals, n_variate, 'B')
Plotter(panel_C, max_nu, num_evals, n_variate, 'C')
Plotter(panel_D, max_nu, num_evals, n_variate, 'D')

%% table 4.5
nu_points = [1, 2, 3, 4, 5];
n_variate = 2000;
exact_method = 'inverse';
Tabler(panel_A, nu_points, n_variate, 'A', exact_method)
Tabler(panel_B, nu_points, n_variate, 'B', exact_method)
Tabler(panel_C, nu_points, n_variate, 'C', exact_method)
Tabler(panel_D, nu_points, n_variate, 'D', exact_method)


%% table 4.6
nu_points = [1, 5, 10, 100];
n_variate = 2000;
exact_method = 'MonteCarlo';
Tabler(panel_A, nu_points, n_variate, 'A', exact_method)
Tabler(panel_B, nu_points, n_variate, 'B', exact_method)
Tabler(panel_C, nu_points, n_variate, 'C', exact_method)
Tabler(panel_D, nu_points, n_variate, 'D', exact_method)

