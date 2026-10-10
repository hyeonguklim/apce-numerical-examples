function basis = fitBasis(Xmoment, order, options)
%FITBASIS Construct a distribution-free APCE basis from joint moments.
%   BASIS = apce.fitBasis(XMOMENT,ORDER) estimates the monomial Gram
%   matrix E[m(X)m(X)'] from unlabeled samples and factors it to form an
%   orthonormal polynomial basis.  This is a numerically stable matrix form
%   of Gram-Schmidt orthogonalization using the joint raw moments described
%   in Eqs. (4.15)-(4.19) of Lim and Manuel (2021).
%
%   Inputs are centered and scaled before moments are formed.  An affine
%   change of coordinates does not change the total-degree polynomial span,
%   but it substantially improves conditioning for engineering variables
%   with different units.

if nargin < 3 || isempty(options)
    options = struct();
end
if ~isfield(options,'chunkSize'), options.chunkSize = 25000; end
if ~isfield(options,'regularization'), options.regularization = 1e-12; end

validateattributes(Xmoment, {'numeric'}, {'2d','real','finite','nonempty'});
validateattributes(order, {'numeric'}, {'scalar','integer','nonnegative'});

location = mean(Xmoment,1);
scale = std(Xmoment,0,1);
if any(scale <= sqrt(eps))
    error('apce:DegenerateVariable', ...
        'Every APCE input must have nonzero sample variance.');
end

alpha = apce.multiIndex(size(Xmoment,2), order);
P = size(alpha,1);
G = zeros(P,P);
count = size(Xmoment,1);
for first = 1:options.chunkSize:count
    last = min(count, first + options.chunkSize - 1);
    Xs = bsxfun(@rdivide, bsxfun(@minus, Xmoment(first:last,:), location), scale);
    V = apce.monomialMatrix(Xs, alpha);
    G = G + V.' * V;
end
G = (G / count + (G / count).') / 2;

baseJitter = max(options.regularization * trace(G) / P, eps);
jitter = baseJitter;
for attempt = 1:10
    [R,flag] = chol(G + jitter * eye(P));
    if flag == 0
        break
    end
    jitter = 10 * jitter;
end
if flag ~= 0
    error('apce:MomentMatrixNotPositiveDefinite', ...
        'The empirical moment matrix could not be factorized.');
end

basis = struct('order',order, 'dimension',size(Xmoment,2), ...
    'alpha',alpha, 'location',location, 'scale',scale, 'R',R, ...
    'momentSampleCount',count, 'regularizationUsed',jitter, ...
    'gramCondition',cond(G + jitter*eye(P)));
end
