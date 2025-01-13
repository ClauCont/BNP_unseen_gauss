function gen_fact_coeff=gen_fact(n,sigma,r)

if r==0
    gen_fact_coeff(1,1)=log(sigma);
    for i=2:n
        gen_fact_coeff(i,1)=log(-(sigma-(i-1)))+gen_fact_coeff(i-1,1);
        for j=2:i
            if i==j
                gen_fact_coeff(i,j)=log(sigma)+gen_fact_coeff(i-1,j-1);
            else
                a=log(sigma)+gen_fact_coeff(i-1,j-1);
                b=log(-((sigma*j)-(i-1)))+gen_fact_coeff(i-1,j);
                gen_fact_coeff(i,j)=max(a,b)+log(1+exp(min(a,b)-max(a,b)));
            end
        end
    end
else
    gen_fact_coeff(1,1)=log(sigma);
    for i=2:n
        a1=log(sigma)+gammaln(-r+i-1)-gammaln(-r);
        b1=log(-(sigma+r-(i-1)))+gen_fact_coeff(i-1,1);
        gen_fact_coeff(i,1)=max(a1,b1)+log(1+exp(min(a1,b1)-max(a1,b1)));
        for j=2:i
            if i==j
                gen_fact_coeff(i,j)=log(sigma)+gen_fact_coeff(i-1,j-1);
            else
                a=log(sigma)+gen_fact_coeff(i-1,j-1);
                b=log(-((sigma*j)+r-(i-1)))+gen_fact_coeff(i-1,j);
                gen_fact_coeff(i,j)=max(a,b)+log(1+exp(min(a,b)-max(a,b)));
            end
        end
    end
end













