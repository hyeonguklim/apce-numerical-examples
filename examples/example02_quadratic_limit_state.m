function result = example02_quadratic_limit_state(mode, makePlot)
%EXAMPLE02_QUADRATIC_LIMIT_STATE Reproduce paper Example 2 and Table 4.
if nargin < 1, mode = 'quick'; end
if nargin < 2, makePlot = true; end
opt = apce.paperOptions(mode);
rng(202,'twister');
Xmoment = benchmarks.sampleExample02(opt.momentSamples);
order = 2; termCount = nchoosek(4+order,order); Ns = 3*termCount;

pfTruth = zeros(opt.strengthReplicates,1);
pfAPCE = zeros(opt.strengthReplicates,1);
rmse = zeros(opt.strengthReplicates,1);
for r = 1:opt.strengthReplicates
    Xtrain = benchmarks.sampleExample02(Ns);
    model = apce.fit(Xtrain,benchmarks.evaluateExample02(Xtrain),order,Xmoment,opt.basis);
    Xtest = benchmarks.sampleExample02(opt.strengthMCS);
    truth = benchmarks.evaluateExample02(Xtest);
    estimate = apce.predict(model,Xtest);
    pfTruth(r) = mean(truth < 0);
    pfAPCE(r) = mean(estimate < 0);
    rmse(r) = apce.rmse(truth,estimate);
end

result = struct('name','Example 2: quadratic limit state', 'order',order, ...
    'trainingSamples',Ns, 'pfTruth',pfTruth, 'pfAPCE',pfAPCE, 'rmse',rmse, ...
    'published',struct('meanPf',5.57e-2,'stdPf',6.89e-4,'rmseAPCE',6.90e-16), ...
    'passed',abs(mean(pfAPCE)-5.57e-2)<8e-3 && mean(rmse)<1e-9);

if makePlot
    figure('Name','APCE paper Example 2');
    count = min(3000,numel(truth));
    scatter(truth(1:count),estimate(1:count),10,'filled'); hold on
    limits = [min(truth),max(truth)]; plot(limits,limits,'k--','LineWidth',1.2);
    xlabel('Truth g(X)'); ylabel('APCE g(X)'); grid on; axis equal
    title(sprintf('Example 2: p=%d, N_s=%d, RMSE=%.3g',order,Ns,mean(rmse)));
end
end
