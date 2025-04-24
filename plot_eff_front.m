function plot_eff_front(expretrange,mu,sigma,rho,r_f)

Sig = formCov(sigma,rho);
N=numel(expretrange);
stdevrange=zeros(1,N);
for n=1:N, [~,stdevrange(n)]=optrisky(expretrange(n),mu,Sig);end
figure
scatter(stdevrange,expretrange)
hold
scatter(sigma,mu)
N1=max(max(stdevrange),max(sigma));
N2=max(max(expretrange),max(mu));
axis([0 N1 expretrange(1) N2])
if nargin==5
    mu=mu-r_f;
    invSig=inv(Sig);
    try A=mu'*invSig*mu; catch, A=mu*invSig*mu'; end
    stepsize=stdevrange(1)-stdevrange(2);
    stdevrange=0:stepsize:max(stdevrange);
    y=sqrt(A)*stdevrange+r_f;
    scatter(stdevrange,y)

end

end