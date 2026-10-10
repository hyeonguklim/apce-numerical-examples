function run_tests(level)
%RUN_TESTS Core unit tests and optional end-to-end smoke tests.
if nargin < 1, level = 'core'; end
setup_apce();

expected = [0 0;1 0;0 1;2 0;1 1;0 2];
assert(isequal(apce.multiIndex(2,2),expected),'Multi-index ordering failed.');

rng(77,'twister');
Xmoment = [randn(30000,1), 0.6*randn(30000,1)+0.8*randn(30000,1)];
basis = apce.fitBasis(Xmoment,3);
Phi = apce.evaluateBasis(basis,Xmoment);
orthogonalityError = norm((Phi.'*Phi)/size(Phi,1)-eye(size(Phi,2)),'fro');
assert(orthogonalityError < 1e-6,'Empirical APCE basis is not orthonormal.');

Xtrain = Xmoment(1:100,:);
ytrain = 2 + 3*Xtrain(:,1)-Xtrain(:,2)+0.5*Xtrain(:,1).*Xtrain(:,2)+Xtrain(:,2).^2;
model = apce.fit(Xtrain,ytrain,2,Xmoment);
Xtest = Xmoment(101:1000,:);
ytest = 2 + 3*Xtest(:,1)-Xtest(:,2)+0.5*Xtest(:,1).*Xtest(:,2)+Xtest(:,2).^2;
assert(apce.rmse(ytest,apce.predict(model,Xtest)) < 1e-10, ...
    'APCE did not recover an exact quadratic response.');

fprintf('Core APCE tests passed. Basis orthogonality error: %.3g\n',orthogonalityError);
if strcmpi(level,'full')
    report = run_all_examples('quick',false);
    assert(all(cellfun(@(x)x.passed,report)),'One or more example checks failed.');
    fprintf('All end-to-end example checks passed.\n');
end
end
