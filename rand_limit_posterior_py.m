function w=rand_limit_posterior_py(n,j,sigma,theta,n_variate)

b=betarnd(j+(theta/sigma),(n/sigma)-j,1,n_variate);
a=rand_limit_prior_py(sigma,theta+n,n_variate);
w=b.*a;

% check with moments

% mean_mc=mean(w);
% mean2_mc=mean(w.^2);
% logmean_exact=log(j+(theta/sigma))+gammaln(theta+n)-gammaln(theta+n+sigma);
% mean_exact=exp(logmean_exact);
% logmean2_exact=log((theta/sigma)+j)+log((theta/sigma)+j+1)+gammaln(theta+n)-gammaln(theta+n+2*sigma);
% mean2_exact=exp(logmean2_exact);
