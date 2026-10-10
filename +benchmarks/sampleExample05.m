function X = sampleExample05(n)
%SAMPLEEXAMPLE05 Independent mixed continuous/atomic variables.
X = zeros(n,3);
for j = 1:3
    X(:,j) = apce.dist.sampleMixedNormalAtom(n,0.7,2.0);
end
end
