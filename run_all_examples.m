function report = run_all_examples(mode, makePlots)
%RUN_ALL_EXAMPLES Run all six published structural-reliability benchmarks.
%   REPORT = RUN_ALL_EXAMPLES('quick',true) is a fast smoke/verification run.
%   REPORT = RUN_ALL_EXAMPLES('paper',true) uses the paper's replicate and
%   Monte Carlo counts (100x1e5 for strength cases; 10x1e6 for serviceability).
if nargin < 1, mode = 'quick'; end
if nargin < 2, makePlots = true; end
setup_apce();

functions = {@example01_noisy_limit_state, @example02_quadratic_limit_state, ...
    @example03_correlated_non_normal, @example04_multimodal_ishigami, ...
    @example05_mixed_support, @example06_offshore_extreme};
report = cell(numel(functions),1);
fprintf('\nRunning APCE examples in %s mode\n',upper(mode));
fprintf('%s\n',repmat('-',1,72));
for k = 1:numel(functions)
    started = tic;
    report{k} = functions{k}(mode,makePlots);
    fprintf('%-52s %s  (%6.1f s)\n',report{k}.name, ...
        passText(report{k}.passed),toc(started));
end
fprintf('%s\n',repmat('-',1,72));
fprintf('%d/%d checks passed.\n',sum(cellfun(@(x)x.passed,report)),numel(report));

resultDirectory = fullfile(fileparts(mfilename('fullpath')),'verification');
if ~exist(resultDirectory,'dir'), mkdir(resultDirectory); end
save(fullfile(resultDirectory,['latest_' lower(mode) '_results.mat']),'report','mode');
end

function text = passText(passed)
if passed, text = 'PASS'; else, text = 'CHECK'; end
end
