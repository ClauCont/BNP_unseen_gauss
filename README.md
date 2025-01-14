This repository contains the scripts used to carry out the numerical tests of the methods described in the paper

_Gaussian credible intervals in Bayesian nonparametric estimation of the unseen_ (2025), by Claudia Contardi, Emanuele Dolera and Stefano Favaro

## Reproducibility Instructions

This directory contains all the code necessary to reproduce the numerical results presented in the paper.

## Contents and Structure

### Experiment Scripts
The following two files contain the main code to run the experiments with the specifications used in the paper, allowing to reproduce the figures and tables therein:
- `synth_test.m` generates the synthetic data used in section 4.1, plots the four panels of figure 1.2 and produces the data for tables 4.1, 4.2 and 4.3, saving them in text files.
- `real_test.m` contains the parameter specifications of the real data used in section 4.2, plots figure 4.2 and the the four panels of figure A.1 and produces the data for tables 4.4, 4.5 and 4.6, saving them in  text files.

### Results
All the outputs of the scripts of the previous section are stored in the folder `Results` - see the corresponding README for details.


### Other Scripts
- `Interval_maker.m` outputs the exact, Mittag-Leffler, Gaussian intervals and BNP estimator relative to the parameters $n, j, \alpha\, \theta$, a vector $M$ of additional (integer) sample size and a confidence level given as input. The method for the computation of the exact intervals (inverse transform or MC sampling from the predictive) can be specified. 
- `Plotter.m` takes as input a vector containing the parameters $n, j, \alpha\, \theta$, a number 'max_nuu' and a confidence level. It plots, for a user-specified number of points evenly distributed over the interval $[0, max\textunderscore nuu*n]$, the BNP estimator (solid black), the exact intervals (by default via inverse transform, dashed black), the Mittag-Leffler intervals (shaded blue) and the Gaussian intervals (shaded pink). 
- `Tabler.m` produces a text file containing the output of `Interval_maker.m` evaluated at the specified parameters $n, j, \alpha\, \theta$ and $M = n \cdot nu\textunderscore points$ (nu_points and the method for the construction of exact intervals being user-specified) and two additional rows containing the coverage of the Mittag-Leffler and Gaussian interval. 

Furthermore, 
- `MLThetaPY.m` outputs Empirical Bayes specifications of the parameter $(\alpha, \theta)$, given a dataset of counts.
- `synthetic.m` generates the zipf (using `zipf_rand.m`), Dirichlet-Multinomial and uniform data with specified parameters, and fits the Pitman-Yor model using `MLThetaPY.m`. It outputs the vector $[n, j, \alpha, \theta]$; 
- `rand_posterior_pd.m` and `rand_posterior_py.m` sample from the exact expression for the posterior distribution of $K_{n, m}$ under Dirichlet and Pitman-Yor prior, respectively;
- `MC_Knm.m` samples from the the predictive distribution of $K_{n, m}$
- `rand_limit_posterior_py.m` samples from the posterior $\alpha$-diversity limiting distribution 
- the rest of the scripts are instrumental to `rand_posterior_pd.m` and `rand_posterior_py.m`

