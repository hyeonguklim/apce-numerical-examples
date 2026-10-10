function latentCorrelation = gaussianCopulaLatentCorrelation(targetCorrelation)
%GAUSSIANCOPULALATENTCORRELATION Match Corr(Uniform,Exponential).
%   The paper specifies the marginals and Pearson correlation for Example 3
%   but not a unique copula.  This function uses the conventional Gaussian
%   copula/Nataf construction and calibrates its latent correlation by
%   deterministic Gauss-Hermite quadrature.

validateattributes(targetCorrelation,{'numeric'},{'scalar','>',-0.95,'<',0.95});
[node,weight] = gaussHermiteNormal(28);
[z,e] = ndgrid(node,node);
w = weight*weight.';

correlation = @(rho) transformedCorrelation(rho,z,e,w);
latentCorrelation = fzero(@(rho) correlation(rho)-targetCorrelation,[-0.99,0.99]);
end

function value = transformedCorrelation(rho,z,e,w)
z2 = rho*z + sqrt(1-rho^2)*e;
uniform = apce.dist.normcdf(z);
u2 = min(apce.dist.normcdf(z2),1-eps);
exponential = -log(1-u2);
value = sum(sum(w .* (uniform-0.5) .* (exponential-1))) / sqrt(1/12);
end

function [z,w] = gaussHermiteNormal(n)
% Golub-Welsch nodes/weights for expectations under N(0,1).
offDiagonal = sqrt((1:n-1)/2);
[V,D] = eig(diag(offDiagonal,1)+diag(offDiagonal,-1));
[x,index] = sort(diag(D));
V = V(:,index);
z = sqrt(2)*x;
w = V(1,:).^2;
w = w(:);
end
