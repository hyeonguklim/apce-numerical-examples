function X = sampleExample01(n)
%SAMPLEEXAMPLE01 Six independent lognormal variables (paper Table 1).
means = [120 120 120 120 50 40];
covs = [0.10 0.10 0.10 0.10 0.30 0.30];
X = zeros(n,6);
for j = 1:6
    X(:,j) = apce.dist.sampleLognormal(n,means(j),covs(j));
end
end
