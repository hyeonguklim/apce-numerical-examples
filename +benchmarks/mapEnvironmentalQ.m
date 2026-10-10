function X = mapEnvironmentalQ(Q)
%MAPENVIRONMENTALQ Rosenblatt map [Q1,Q2] -> [Hs,Tp].
%   Implements Eqs. (3.9)-(3.11) in Lim's dissertation, which define the
%   North Sea environment used by the paper's offshore Example 6.
if size(Q,2) ~= 2
    error('apce:DimensionMismatch','Q must have two columns.');
end

zetaHs = 0.6565; lambdaHs = 0.77;
gammaShape = 1.503; rhoScale = 2.691; switchHeight = 2.90;
u = min(max(apce.dist.normcdf(Q(:,1)),realmin),1-eps);
switchProbability = apce.dist.normcdf((log(switchHeight)-lambdaHs)/zetaHs);
Hs = zeros(size(u));
lower = u <= switchProbability;
Hs(lower) = exp(lambdaHs + zetaHs*apce.dist.norminv(u(lower)));
Hs(~lower) = rhoScale*(-log(1-u(~lower))).^(1/gammaShape);

zetaConditional = sqrt(0.005 + 0.120*exp(-0.455*Hs));
lambdaConditional = 1.134 + 0.892*Hs.^0.225;
Tp = exp(lambdaConditional + zetaConditional.*Q(:,2));
X = [Hs,Tp];
end
