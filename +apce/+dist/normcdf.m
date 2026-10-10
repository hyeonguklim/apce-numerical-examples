function p = normcdf(x)
%NORMCDF Standard-normal CDF without Statistics Toolbox.
p = 0.5 * erfc(-x ./ sqrt(2));
end
