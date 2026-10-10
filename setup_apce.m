function setup_apce()
%SETUP_APCE Add the package root, examples, and tests to the MATLAB path.
root = fileparts(mfilename('fullpath'));
addpath(root);
addpath(fullfile(root,'examples'));
addpath(fullfile(root,'tests'));
fprintf('APCE package ready: %s\n',root);
end
