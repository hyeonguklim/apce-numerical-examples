function probability = exceedanceProbability(values, thresholds)
%EXCEEDANCEPROBABILITY Empirical P(Y>b) at one or more thresholds.
values = values(:);
thresholds = thresholds(:).';
probability = zeros(size(thresholds));
for k = 1:numel(thresholds)
    probability(k) = mean(values > thresholds(k));
end
end
