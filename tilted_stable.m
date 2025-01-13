function w=tilted_stable(s,t)
%w = 0
r=erf(sqrt(s*(1-s)*(t^s)*(pi^2)/2));

logc1 = gammaln(s*(t^s)) + (s*(t^s))-1 - (t^s)*log(s*(t^s)) + ((t^s)*(1-s)+1)*log((s/(1-s))+(s*(t^s)));

logc2 = gammaln(((1-s)*(t^s))+1)+(t^s)*(1-s) - ((1-s)*(t^s))*log((1-s)*(t^s));

logc3 = gammaln((s*(t^s))+1) + (s*(t^s))-1 - (s*t^s)*log((s*(t^s))) - 0.5*log(2*pi*s*(1-s)*(t^s)) + (1+(1-s)*(t^s))*log(1+(1/((1-s)*(t^s))));

logc4 = gammaln((1-s)*(t^s)+1) + (1-s)*(t^s) - 0.5*log(2*pi*s*(1-s)*(t^s)) - ((1-s)*(t^s))*log((1-s)*(t^s));

c1 = exp(logc1);
c2 = exp(logc2);
c3 = exp(logc3);
c4 = exp(logc4);

if c1==min([c1,c2,c3,c4])
    u=unifrnd(0,pi);
    x=gamrnd(s*(t^s),1);
    v=unifrnd(0,1);
    w=x/t;
    while v>((((s*exp(t^s)*gamma(s*(t^s)))/(1-s))*(kanter(s,u)^(1/(1-s)))*(t^(s/(1-s)))*(x^(-(s/(1-s))-s*(t^s)))*(exp(-(kanter(s,u)^(1/(1-s)))*(t^(s/(1-s)))*(x^(-(s/(1-s)))))))/c1)
        u=unifrnd(0,pi);
        x=gamrnd(s*(t^s),1);
        v=unifrnd(0,1);
        w=x/t;
    end
end

if c2==min([c1,c2,c3,c4])
    u=unifrnd(0,pi);
    z=gamrnd((1-s)*(t^s)+1,1);
    v=unifrnd(0,1);
    w=(kanter(s,u)^(1/s))*(z^(-((1-s)/s)));
    while v>((exp(t^s)*gamma((1-s)*(t^s)+1)*(z^(-(1-s)*(t^s)))*exp(-t*(kanter(s,u)^(1/s))*z^(-((1-s)/s))))/c2)
        u=unifrnd(0,pi);
        z=gamrnd((1-s)*(t^s)+1,1);
        v=unifrnd(0,1);
        w=(kanter(s,u)^(1/s))*(z^(-((1-s)/s)));
    end
end

if c3==min([c1,c2,c3,c4])
    u=truncated_gaussian(0,(s*(1-s)*(t^s))^(-1/2),0,pi,1);
    x=gamrnd(s*(t^s),1);
    v=unifrnd(0,1);
    w=x/t;
    while v>(((r*s*exp(t^s)*gamma(s*(t^s))*(t^(s/(1-s)))*(kanter(s,u)^(1/(1-s))))/(c3*(1-s)*sqrt(2*pi*s*(1-s)*(t^s))*(x^((s/(1-s))+s*(t^s)))))*exp(-((t*(kanter(s,u)^(1/s))*(x^(-1))))^(s/(1-s))+(s*(1-s)*(t^s)*(u^2)/2)))
        u=truncated_gaussian(0,(s*(1-s)*(t^s))^(-1/2),0,pi,1);
        x=gamrnd(s*(t^s),1);
        v=unifrnd(0,1);
        w=x/t;
    end
end

if c4==min([c1,c2,c3,c4])
    u=truncated_gaussian(0,(s*(1-s)*(t^s))^(-1/2),0,pi,1);
    z=gamrnd(((1-s)*(t^s))+1,1);
    v=unifrnd(0,1);
    w=(kanter(s,u)^(1/s))*(z^(-((1-s)/s)));
    while v>(((r*exp(t^s)*gamma(((1-s)*(t^s))+1))/(c4*sqrt(2*pi*s*(1-s)*(t^s))*(z^((1-s)*(t^s)))))*exp(-(t*(kanter(s,u)^(1/s))*z^(-((1-s)/s)))+((s*(1-s)*(t^s)*(u^2)/2))))
        u=truncated_gaussian(0,(s*(1-s)*(t^s))^(-1/2),0,pi,1);
        z=gamrnd(((1-s)*(t^s))+1,1);
        v=unifrnd(0,1);
        w=(kanter(s,u)^(1/s))*(z^(-((1-s)/s)));
    end
end




















    



























