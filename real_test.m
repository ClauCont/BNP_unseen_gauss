%% real data
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
rng(0, 'twister') p

% datasets
tomato_flower = [2586, 1825, 0.612, 741];
mastigamoeba = [715, 460, 0.770, 46];
mastigamoeba_norm = [363, 248, 0.7, 57];
naegleria_aer = [959, 473, 0.67, 46.3];
naegleria_anaer = [969, 631, 0.66, 155.5];

%% plots figure 4.2 and A.1
max_nu = 5;
num_evals = 50;
n_variate = 2000;
level = 0.95;
Plotter(tomato_flower, max_nu, level, num_evals, n_variate, 'tf')
Plotter(mastigamoeba, max_nu, level, num_evals, n_variate, 'mast')
Plotter(mastigamoeba_norm, max_nu, level, num_evals, n_variate, 'mastN')
Plotter(naegleria_aer, max_nu, level, num_evals, n_variate, 'naegA')
Plotter(naegleria_anaer, max_nu, level, num_evals, n_variate, 'naegAA')

%% table 4.5
nu_points = [1, 2, 3, 4, 5];
n_variate = 2000;
exact_method = 'inverse';
Tabler(tomato_flower, nu_points, level, n_variate, 'tomato', exact_method)
Tabler(mastigamoeba, nu_points, level, n_variate, 'mast', exact_method)
Tabler(mastigamoeba_norm, nu_points, level, n_variate, 'mastN', exact_method)
Tabler(naegleria_aer, nu_points, level, n_variate, 'naegA', exact_method)
Tabler(naegleria_anaer, nu_points, level, n_variate, 'naegAnA', exact_method)

%% table 4.6
nu_points = [10, 50, 100, 500];
n_variate = 2000;
exact_method = 'MonteCarlo';
Tabler(tomato_flower, nu_points, level , n_variate, 'tomato', exact_method)
Tabler(mastigamoeba, nu_points, level, n_variate, 'mast', exact_method)
Tabler(mastigamoeba_norm, nu_points, level, n_variate, 'mastN', exact_method)
Tabler(naegleria_aer, nu_points, level, n_variate, 'naegA', exact_method)
Tabler(naegleria_anaer, nu_points, level, n_variate, 'naegAnA', exact_method)