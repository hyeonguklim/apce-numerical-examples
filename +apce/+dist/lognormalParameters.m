function [muLog, sigmaLog] = lognormalParameters(meanValue, covValue)
%LOGNORMALPARAMETERS Convert physical mean/COV to log-space parameters.
sigmaLog = sqrt(log(1 + covValue.^2));
muLog = log(meanValue) - 0.5*sigmaLog.^2;
end
