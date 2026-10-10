function X = sampleExample04(n)
%SAMPLEEXAMPLE04 Independent three-mode Gaussian mixtures, paper Eq. (28).
means = [2.0 2.5 3.5];
standardDeviations = [0.1 0.5 0.2];
weights = ones(1,3)/3;
X = zeros(n,3);
for j = 1:3
    X(:,j) = apce.dist.sampleGaussianMixture(n,means,standardDeviations,weights);
end
end
