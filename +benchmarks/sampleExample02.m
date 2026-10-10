function X = sampleExample02(n)
%SAMPLEEXAMPLE02 Independent variables for the quadratic benchmark.
X = zeros(n,4);
X(:,1) = apce.dist.sampleFrechet(n,10,0.50);
X(:,2) = 25 + 5*randn(n,1);
X(:,3) = 0.8 + 0.2*randn(n,1);
X(:,4) = apce.dist.sampleLognormal(n,0.0625,1.0);
end
