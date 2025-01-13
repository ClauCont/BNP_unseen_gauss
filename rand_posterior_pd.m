function k_posterior_dp=rand_posterior_pd(m,n,theta,n_variate)

gen_stir_coeff=gen_stir(m,n);
posterior_mass=zeros(1,m+1);

posterior_mass(1)=gammaln(n+m)-gammaln(n)+gammaln(theta+n)-gammaln(theta+n+m);
for i=2:m+1
    posterior_mass(i)=gen_stir_coeff(m,i-1)+(i-1)*log(theta)+gammaln(theta+n)-gammaln(theta+n+m);
end

k_posterior_dp=gendist(exp(posterior_mass),1,n_variate)-1;

% check with moments

%mean_mc=mean(k_posterior_dp);
%mean_exact=0;
%for i=1:m
%    mean_exact=mean_exact+(theta/(theta+n+i-1));
%end



