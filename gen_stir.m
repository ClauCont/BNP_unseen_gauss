function gen_stir_coeff=gen_stir(n,r)

gen_stir_coeff(1,1)=log(1);
for i=2:n
    a1=gammaln(r+i-1)-gammaln(r);
    b1=log(r+i-1)+gen_stir_coeff(i-1,1);
    gen_stir_coeff(i,1)=max(a1,b1)+log(1+exp(min(a1,b1)-max(a1,b1)));
    for j=2:i
        if i==j
            gen_stir_coeff(i,j)=gen_stir_coeff(i-1,j-1);
        else
            a=gen_stir_coeff(i-1,j-1);
            b=log(r+i-1)+gen_stir_coeff(i-1,j);
            gen_stir_coeff(i,j)=max(a,b)+log(1+exp(min(a,b)-max(a,b)));
        end
    end
end
