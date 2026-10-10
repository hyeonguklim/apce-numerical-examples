function [z, probability] = empiricalCCDF(values)
%EMPIRICALCCDF Toolbox-free empirical complementary CDF.
z = sort(values(:));
n = numel(z);
probability = (n:-1:1).' / n;
end
