function V = monomialMatrix(X, alpha)
%MONOMIALMATRIX Evaluate multivariate monomials at sample rows.
%   X is N-by-D, ALPHA is P-by-D, and V is N-by-P with
%   V(n,k) = prod_j X(n,j)^ALPHA(k,j).

validateattributes(X, {'numeric'}, {'2d','real','finite'});
validateattributes(alpha, {'numeric'}, {'2d','integer','nonnegative'});
if size(X,2) ~= size(alpha,2)
    error('apce:DimensionMismatch', ...
        'X and alpha must describe the same number of variables.');
end

V = ones(size(X,1), size(alpha,1));
for j = 1:size(X,2)
    if any(alpha(:,j))
        V = V .* bsxfun(@power, X(:,j), alpha(:,j).');
    end
end
end
