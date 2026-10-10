function x = sampleGaussianMixture(n, means, standardDeviations, weights)
%SAMPLEGAUSSIANMIXTURE Draw from a finite univariate Gaussian mixture.
means = means(:).'; standardDeviations = standardDeviations(:).';
weights = weights(:).'/sum(weights);
if numel(means) ~= numel(standardDeviations) || numel(means) ~= numel(weights)
    error('apce:DimensionMismatch','Mixture parameter lengths must agree.');
end
u = rand(n,1);
edges = cumsum(weights);
component = ones(n,1);
for k = 1:numel(weights)-1
    component(u > edges(k)) = k+1;
end
selectedMean = reshape(means(component),[],1);
selectedStd = reshape(standardDeviations(component),[],1);
x = selectedMean + selectedStd.*randn(n,1);
end
