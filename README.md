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
All the outputs of the scripts of the previous section are stored in the folder `Results` - see the relative README for details.


### Helper Scripts
- `Interval_maker.m` produces 
- `Plotter.m` ...
- `Tabler.m` ...

Furthermore, 
- `synthetic.m` generates .... . `zipf_rand.m`, which ... and `MLThetaPY.m`
- `MLThetaPY.m` outputs Empirical Bayes specifications of the parameter $(\alpha, \theta)$, given a dataset of counts.
- `rand_posterior_pd.m` and `rand_posterior_py.m`
- `MC_Knm.m`
- `rand_limit_posterior_py.m` for the computation of Mittag-Leffler credible intervals
- the rest of the scripts ... for `rand_posterior_pd.m` and `rand_posterior_py.m`

