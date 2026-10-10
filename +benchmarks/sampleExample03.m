function [X,latentCorrelation] = sampleExample03(n, latentCorrelation)
%SAMPLEEXAMPLE03 Correlated uniform/exponential pair, paper Table 5.
if nargin < 2 || isempty(latentCorrelation)
    latentCorrelation = apce.dist.gaussianCopulaLatentCorrelation(0.5);
end
X = apce.dist.sampleCorrelatedUniformExponential(n,0.5,latentCorrelation);
end
