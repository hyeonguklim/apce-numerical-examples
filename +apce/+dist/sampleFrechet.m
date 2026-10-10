function x = sampleFrechet(n, meanValue, covValue)
%SAMPLEFRECHET Draw Type-II extreme-value (Frechet) samples.
%   Shape and scale are solved from the physical mean and COV.
objective = @(shape) sqrt(gamma(1-2./shape)./gamma(1-1./shape).^2 - 1) - covValue;
shape = fzero(objective,[2.001, 100]);
scale = meanValue / gamma(1-1/shape);
u = min(max(rand(n,1),realmin),1-eps);
x = scale * (-log(u)).^(-1/shape);
end
