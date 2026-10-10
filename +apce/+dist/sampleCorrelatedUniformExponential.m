function X = sampleCorrelatedUniformExponential(n, targetCorrelation, latentCorrelation)
%SAMPLECORRELATEDUNIFORMEXPONENTIAL Gaussian-copula benchmark sample.
%   X1~Uniform(0,100), X2~Exponential(mean=1), Corr(X1,X2)=target.
if nargin < 3 || isempty(latentCorrelation)
    latentCorrelation = apce.dist.gaussianCopulaLatentCorrelation(targetCorrelation);
end
z1 = randn(n,1);
z2 = latentCorrelation*z1 + sqrt(1-latentCorrelation^2)*randn(n,1);
u1 = apce.dist.normcdf(z1);
u2 = min(apce.dist.normcdf(z2),1-eps);
X = [100*u1, -log(1-u2)];
end
