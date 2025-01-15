function [sample_params] = synthetic(name, par)

% generate data
% set parameters
params_zipf = par(1); 
jub = par(2); % j upper bound 
nub_factor = par(3); % n upper bound = nub_fact * jub


% generate samples
if name == "unif"
    counts = zeros(1, jub);
    probs = randi(jub, 1, jub);
    probs = probs/sum(probs);
    
    i = 1;
    while i <= jub*nub_factor
        r = rand;
        die = sum(r >= cumsum([0, probs]));
        counts(die) = counts(die)+1;
        i = i+1;
    end

elseif name == "dir" 
    counts = zeros(1, jub);
    probs = zeros(1, jub);
    probs(1:jub-10) = gamrnd(2, 1, 1, jub-10);
    probs(jub-9:jub) = gamrnd(jub, 1, 1, 10);
    probs = probs/sum(probs);
    
    i = 1;
    while i <= jub*nub_factor
        r = rand;
        die = sum(r >= cumsum([0, probs]));
        counts(die) = counts(die)+1;
        i = i+1;
    end

elseif name == "zipf"
    params = params_zipf;
    counts = zipf_rand(jub*nub_factor, params, jub); 
end

counts = sort(counts, 'descend');
counts = counts(counts~=0);

j = length(counts);
n = sum(counts);

% plot of counts
% figure()
% plot(counts, 'ro')

% =========================================================================
% Empirical Bayes specification for alpha and theta

alpha = 0.5; % starting value for alpha
options = optimset();
Params = MLThetaPY(counts, alpha, options);
theta = Params(2);
alpha = Params(1); 

sample_params = [n, j, alpha, theta]; % parameters of dataset

end