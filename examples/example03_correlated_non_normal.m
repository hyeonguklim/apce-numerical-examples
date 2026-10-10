function result = example03_correlated_non_normal(mode, makePlot)
%EXAMPLE03_CORRELATED_NON_NORMAL Reproduce paper Example 3 / Figure 1.
if nargin < 1, mode = 'quick'; end
if nargin < 2, makePlot = true; end
opt = apce.paperOptions(mode);
rng(303,'twister');
latent = apce.dist.gaussianCopulaLatentCorrelation(0.5);
[Xmoment,~] = benchmarks.sampleExample03(opt.momentSamples,latent);
order = 1; Ns = 3*nchoosek(2+order,order);
thresholds = 70:1:100;
truthCurve = zeros(opt.serviceReplicates,numel(thresholds));
apceCurve = zeros(size(truthCurve));
rmse = zeros(opt.serviceReplicates,1);
for r = 1:opt.serviceReplicates
    Xtrain = benchmarks.sampleExample03(Ns,latent);
    model = apce.fit(Xtrain,benchmarks.demandExample03(Xtrain),order,Xmoment,opt.basis);
    Xtest = benchmarks.sampleExample03(opt.serviceMCS,latent);
    truth = benchmarks.demandExample03(Xtest);
    estimate = apce.predict(model,Xtest);
    truthCurve(r,:) = apce.exceedanceProbability(truth,thresholds);
    apceCurve(r,:) = apce.exceedanceProbability(estimate,thresholds);
    rmse(r) = apce.rmse(truth,estimate);
end

result = struct('name','Example 3: correlated non-normal variables', ...
    'order',order,'trainingSamples',Ns,'thresholds',thresholds, ...
    'truthCurve',truthCurve,'apceCurve',apceCurve,'rmse',rmse, ...
    'latentGaussianCorrelation',latent, ...
    'passed',max(abs(truthCurve(:)-apceCurve(:)))<5e-4 && mean(rmse)<1e-10);
if makePlot
    plotCurves(thresholds,truthCurve,apceCurve,'Example 3: P[X_1-X_2>b]');
end
end

function plotCurves(b,truthCurve,apceCurve,plotTitle)
figure('Name','APCE paper Example 3'); hold on
semilogy(b,truthCurve.','Color',[0.70 0.80 1.00]);
semilogy(b,apceCurve.','Color',[1.00 0.75 0.75],'LineStyle','--');
h1=semilogy(b,mean(truthCurve,1),'b-','LineWidth',2);
h2=semilogy(b,mean(apceCurve,1),'r--','LineWidth',2);
grid on; ylim([1e-5 1]); xlabel('Threshold b'); ylabel('P[h(X)>b]');
legend([h1 h2],{'MCS mean','APCE mean'},'Location','southwest'); title(plotTitle);
end
