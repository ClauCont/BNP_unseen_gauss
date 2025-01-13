function w=truncated_gaussian(mu,sigma,lower,upper,n_variate)

pd=makedist('Normal','mu',mu,'sigma',sigma);
t=truncate(pd,lower,upper);
w=random(t,n_variate,1);

