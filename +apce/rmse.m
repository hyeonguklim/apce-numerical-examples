function value = rmse(truth, estimate)
%RMSE Root-mean-square error.
truth = truth(:); estimate = estimate(:);
if numel(truth) ~= numel(estimate)
    error('apce:SampleCountMismatch','Inputs must have the same length.');
end
value = sqrt(mean((truth-estimate).^2));
end
