function k_posterior_py=rand_posterior_py(m,n,j,sigma,theta,n_variate)

gen_fact_coeff=gen_fact(m,sigma,-n+(j*sigma));
posterior_mass=zeros(1,m+1);

posterior_mass(1)=gammaln(n-(j*sigma)+m)-gammaln(n-(j*sigma))+gammaln(j+(theta/sigma))+gammaln(theta+n)-gammaln(j+(theta/sigma))-gammaln(theta+n+m);
for i=2:m+1
    posterior_mass(i)=gen_fact_coeff(m,i-1)+gammaln(j+(theta/sigma)+i-1)+gammaln(theta+n)-gammaln(j+(theta/sigma))-gammaln(theta+n+m);
end

k_posterior_py=gendist(exp(posterior_mass),1,n_variate)-1;

% check with moments

%mean_mc=mean(k_posterior_py);
%mean_exact=exp(log(j+(theta/sigma))+gammaln(theta+n+sigma+m)+gammaln(theta+n)-gammaln(theta+n+sigma)-gammaln(theta+n+m))-j-(theta/sigma);


