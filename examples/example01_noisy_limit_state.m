function result = example01_noisy_limit_state(mode, makePlot)
%EXAMPLE01_NOISY_LIMIT_STATE Reproduce paper Example 1 and Table 2.
if nargin < 1, mode = 'quick'; end
if nargin < 2, makePlot = true; end
opt = apce.paperOptions(mode);
rng(101,'twister');
Xmoment = benchmarks.sampleExample01(opt.momentSamples);
order = 1; termCount = nchoosek(6+order,order); Ns = 3*termCount;

pfTruth = zeros(opt.strengthReplicates,1);
pfAPCE = zeros(opt.strengthReplicates,1);
rmse = zeros(opt.strengthReplicates,1);
for r = 1:opt.strengthReplicates
    Xtrain = benchmarks.sampleExample01(Ns);
    model = apce.fit(Xtrain,benchmarks.evaluateExample01(Xtrain),order,Xmoment,opt.basis);
    Xtest = benchmarks.sampleExample01(opt.strengthMCS);
    truth = benchmarks.evaluateExample01(Xtest);
    estimate = apce.predict(model,Xtest);
    pfTruth(r) = mean(truth < 0);
    pfAPCE(r) = mean(estimate < 0);
    rmse(r) = apce.rmse(truth,estimate);
end

result = struct('name','Example 1: noisy limit state', 'order',order, ...
    'trainingSamples',Ns, 'pfTruth',pfTruth, 'pfAPCE',pfAPCE, 'rmse',rmse, ...
    'published',struct('meanPf',1.23e-2,'stdPf',3.28e-4,'rmseAPCE',2.10e-3), ...
    'passed',abs(mean(pfAPCE)-1.23e-2)<4e-3 && mean(rmse)<6e-3);

if makePlot
    figure('Name','APCE paper Example 1');
    count = min(3000,numel(truth));
    scatter(truth(1:count),estimate(1:count),10,'filled'); hold on
    limits = [min(truth),max(truth)]; plot(limits,limits,'k--','LineWidth',1.2);
    xlabel('Truth g(X)'); ylabel('APCE g(X)'); grid on; axis equal
    title(sprintf('Example 1: p=%d, N_s=%d, RMSE=%.3g',order,Ns,mean(rmse)));
end
end
