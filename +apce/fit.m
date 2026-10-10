function model = fit(Xtrain, ytrain, order, Xmoment, options)
%FIT Fit an APCE surrogate by ordinary least squares.
%   MODEl = apce.fit(XTRAIN,YTRAIN,ORDER,XMOMENT) uses unlabeled XMOMENT
%   samples for the distribution-free basis and the expensive truth-model
%   pairs (XTRAIN,YTRAIN) only for regression coefficients.

if nargin < 4 || isempty(Xmoment), Xmoment = Xtrain; end
if nargin < 5, options = struct(); end
validateattributes(Xtrain, {'numeric'}, {'2d','real','finite','nonempty'});
validateattributes(ytrain, {'numeric'}, {'vector','real','finite'});
ytrain = ytrain(:);
if size(Xtrain,1) ~= numel(ytrain)
    error('apce:SampleCountMismatch', ...
        'Xtrain rows must equal the number of ytrain values.');
end

basis = apce.fitBasis(Xmoment, order, options);
Phi = apce.evaluateBasis(basis, Xtrain);
if size(Phi,1) < size(Phi,2)
    error('apce:UnderdeterminedFit', ...
        'At least %d training samples are required for this basis.', size(Phi,2));
end
coefficient = Phi \ ytrain;
residual = ytrain - Phi*coefficient;

model = struct('basis',basis, 'coefficient',coefficient, ...
    'trainingSampleCount',size(Xtrain,1), ...
    'trainingRMSE',sqrt(mean(residual.^2)), ...
    'designReciprocalCondition',rcond(Phi.'*Phi));
end
