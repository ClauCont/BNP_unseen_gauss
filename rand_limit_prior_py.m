function w=rand_limit_prior_py(sigma,theta,n_variate)

for i=1:n_variate
    x=gamrnd(theta/sigma,1);
    y=tilted_stable(sigma,x^(1/sigma));
    w(i)=y^(-sigma);
end

% check with moments

% mean_mc=mean(w);
% mean2_mc=mean(w.^2);
% logmean_exact=log(theta/sigma)+gammaln(theta)-gammaln(theta+sigma);
% mean_exact=exp(logmean_exact);
% logmean2_exact=log(theta/sigma)+log((theta/sigma)+1)+gammaln(theta)-gammaln(theta+2*sigma);
% mean2_exact=exp(logmean2_exact);


