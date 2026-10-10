function x = sampleMixedNormalAtom(n, normalWeight, atomLocation)
%SAMPLEMIXEDNORMALATOM Draw from w*N(0,1)+(1-w)*delta(atomLocation).
x = atomLocation*ones(n,1);
continuous = rand(n,1) < normalWeight;
x(continuous) = randn(sum(continuous),1);
end
