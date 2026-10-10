function result = example06_offshore_extreme(mode, makePlot)
%EXAMPLE06_OFFSHORE_EXTREME Reproduce paper Example 6 / Figure 5.
%   Uses the authors' original 100,000-run truth-model dataset.  The bundled
%   Windows MEX file can regenerate trials when a compatible MATLAB/Windows
%   installation is available; precomputed data make verification portable.
if nargin < 1, mode = 'quick'; end %#ok<NASGU>
if nargin < 2, makePlot = true; end
root = fileparts(fileparts(mfilename('fullpath')));
data = load(fullfile(root,'data','example06','MCS_100000.mat'),'Q1','Q2','Z');
Q = [data.Q1(:),data.Q2(:)]; Z = data.Z(:);
X = benchmarks.mapEnvironmentalQ(Q);

order = 2; Ns = 3*nchoosek(2+order,order); replicates = 10;
thresholds = 0:0.1:8;
basisOptions = struct('chunkSize',25000,'regularization',1e-12);
apceCurve = zeros(replicates,numel(thresholds));
rmse = zeros(replicates,1);
rng(606,'twister');
for r = 1:replicates
    index = randperm(numel(Z),Ns);
    model = apce.fit(X(index,:),Z(index),order,X,basisOptions);
    estimate = apce.predict(model,X);
    apceCurve(r,:) = apce.exceedanceProbability(estimate,thresholds);
    rmse(r) = apce.rmse(Z,estimate);
end
truthCurve = apce.exceedanceProbability(Z,thresholds);
mask = truthCurve >= 1e-4;
logError = median(abs(log10(max(mean(apceCurve(:,mask),1),1e-8))-log10(truthCurve(mask))));
result = struct('name','Example 6: offshore long-term extreme response', ...
    'order',order,'trainingSamples',Ns,'thresholds',thresholds, ...
    'truthCurve',truthCurve,'apceCurve',apceCurve,'rmse',rmse, ...
    'truthModelSamples',numel(Z),'medianLog10CurveError',logError, ...
    'passed',logError<0.75);
if makePlot
    figure('Name','APCE paper Example 6'); hold on
    semilogy(thresholds,apceCurve.','Color',[1.00 0.78 0.78],'LineStyle','--');
    h1=semilogy(thresholds,truthCurve,'b-','LineWidth',2);
    h2=semilogy(thresholds,mean(apceCurve,1),'r--','LineWidth',2);
    grid on; xlim([0 8]); ylim([1e-5 1]); xlabel('z (m)'); ylabel('P[Z_T>z]');
    legend([h1 h2],{'MCS','Mean of APCE'},'Location','southwest');
    title(sprintf('Example 6: offshore extreme, p=%d, N_s=%d',order,Ns));
end
end
