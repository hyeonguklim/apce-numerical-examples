function y = predict(model, X)
%PREDICT Evaluate an APCE surrogate at rows of X.
y = apce.evaluateBasis(model.basis, X) * model.coefficient;
end
