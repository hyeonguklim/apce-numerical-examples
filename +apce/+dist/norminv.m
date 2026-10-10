function x = norminv(p)
%NORMINV Standard-normal inverse CDF without Statistics Toolbox.
if any(p(:) < 0 | p(:) > 1)
    error('apce:InvalidProbability','Probabilities must lie in [0,1].');
end
x = -sqrt(2) * erfcinv(2*p);
end
