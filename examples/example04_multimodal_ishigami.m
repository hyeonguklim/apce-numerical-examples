function result = example04_multimodal_ishigami(mode, makePlot)
%EXAMPLE04_MULTIMODAL_ISHIGAMI Reproduce paper Example 4 / Figure 2.
if nargin < 1, mode = 'quick'; end
if nargin < 2, makePlot = true; end
opt = apce.paperOptions(mode);
rng(404,'twister');
Xmoment = benchmarks.sampleExample04(opt.momentSamples);
order = 7; Ns = 3*nchoosek(3+order,order);
thresholds = 10:1:50;
truthCurve = zeros(opt.serviceReplicates,numel(thresholds));
apceCurve = zeros(size(truthCurve));
rmse = zeros(opt.serviceReplicates,1);
for r = 1:opt.serviceReplicates
    Xtrain = benchmarks.sampleExample04(Ns);
    model = apce.fit(Xtrain,benchmarks.demandExample04(Xtrain),order,Xmoment,opt.basis);
    Xtest = benchmarks.sampleExample04(opt.serviceMCS);
    truth = benchmarks.demandExample04(Xtest);
    estimate = apce.predict(model,Xtest);
    truthCurve(r,:) = apce.exceedanceProbability(truth,thresholds);
    apceCurve(r,:) = apce.exceedanceProbability(estimate,thresholds);
    rmse(r) = apce.rmse(truth,estimate);
end
mask = mean(truthCurve,1) >= 1e-4;
curveError = max(abs(mean(truthCurve(:,mask),1)-mean(apceCurve(:,mask),1)));
result = struct('name','Example 4: multimodal modified Ishigami', ...
    'order',order,'trainingSamples',Ns,'thresholds',thresholds, ...
    'truthCurve',truthCurve,'apceCurve',apceCurve,'rmse',rmse, ...
    'passed',curveError<1.5e-2);
if makePlot
    figure('Name','APCE paper Example 4'); hold on
    semilogy(thresholds,truthCurve.','Color',[0.70 0.80 1.00]);
    semilogy(thresholds,apceCurve.','Color',[1.00 0.75 0.75],'LineStyle','--');
    h1=semilogy(thresholds,mean(truthCurve,1),'b-','LineWidth',2);
    h2=semilogy(thresholds,mean(apceCurve,1),'r--','LineWidth',2);
    grid on; ylim([1e-5 1]); xlabel('Threshold b'); ylabel('P[h(X)>b]');
    legend([h1 h2],{'MCS mean','APCE mean'},'Location','southwest');
    title(sprintf('Example 4: multimodal variables, p=%d',order));
end
end
