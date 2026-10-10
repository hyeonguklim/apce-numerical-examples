function result = example05_mixed_support(mode, makePlot)
%EXAMPLE05_MIXED_SUPPORT Reproduce paper Example 5 / Figure 3.
if nargin < 1, mode = 'quick'; end
if nargin < 2, makePlot = true; end
opt = apce.paperOptions(mode);
rng(505,'twister');
Xmoment = benchmarks.sampleExample05(opt.momentSamples);
order = 2; Ns = 3*nchoosek(3+order,order);
thresholds = 40:2:120;
truthCurve = zeros(opt.serviceReplicates,numel(thresholds));
apceCurve = zeros(size(truthCurve));
rmse = zeros(opt.serviceReplicates,1);
for r = 1:opt.serviceReplicates
    Xtrain = benchmarks.sampleExample05(Ns);
    model = apce.fit(Xtrain,benchmarks.demandExample05(Xtrain),order,Xmoment,opt.basis);
    Xtest = benchmarks.sampleExample05(opt.serviceMCS);
    truth = benchmarks.demandExample05(Xtest);
    estimate = apce.predict(model,Xtest);
    truthCurve(r,:) = apce.exceedanceProbability(truth,thresholds);
    apceCurve(r,:) = apce.exceedanceProbability(estimate,thresholds);
    rmse(r) = apce.rmse(truth,estimate);
end
result = struct('name','Example 5: mixed discrete-continuous support', ...
    'order',order,'trainingSamples',Ns,'thresholds',thresholds, ...
    'truthCurve',truthCurve,'apceCurve',apceCurve,'rmse',rmse, ...
    'passed',max(abs(truthCurve(:)-apceCurve(:)))<5e-4 && mean(rmse)<1e-9);
if makePlot
    figure('Name','APCE paper Example 5'); hold on
    semilogy(thresholds,truthCurve.','Color',[0.70 0.80 1.00]);
    semilogy(thresholds,apceCurve.','Color',[1.00 0.75 0.75],'LineStyle','--');
    h1=semilogy(thresholds,mean(truthCurve,1),'b-','LineWidth',2);
    h2=semilogy(thresholds,mean(apceCurve,1),'r--','LineWidth',2);
    grid on; ylim([1e-5 1]); xlabel('Threshold b'); ylabel('P[h(X)>b]');
    legend([h1 h2],{'MCS mean','APCE mean'},'Location','southwest');
    title(sprintf('Example 5: mixed support, p=%d',order));
end
end
