function Phi = evaluateBasis(basis, X)
%EVALUATEBASIS Evaluate the fitted APCE polynomial basis.

validateattributes(X, {'numeric'}, {'2d','real','finite'});
if size(X,2) ~= basis.dimension
    error('apce:DimensionMismatch', ...
        'Expected %d input columns but received %d.', ...
        basis.dimension, size(X,2));
end
Xs = bsxfun(@rdivide, bsxfun(@minus, X, basis.location), basis.scale);
V = apce.monomialMatrix(Xs, basis.alpha);
Phi = V / basis.R;
end
