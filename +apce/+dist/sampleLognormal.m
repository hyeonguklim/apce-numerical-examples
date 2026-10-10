function x = sampleLognormal(n, meanValue, covValue)
%SAMPLELOGNORMAL Draw a lognormal sample specified by mean and COV.
[muLog,sigmaLog] = apce.dist.lognormalParameters(meanValue,covValue);
x = exp(muLog + sigmaLog*randn(n,1));
end
