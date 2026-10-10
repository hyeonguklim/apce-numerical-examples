# Independent numerical and syntax check

The package was checked against a separate NumPy/SciPy implementation of the
same equations before delivery. With one million independent truth samples:

- Example 1 failure probability: `0.012259` (paper: `0.0123`).
- Example 2 failure probability: `0.055730` (paper: `0.0557`).
- Example 4, three order-7 fits: RMSE `0.00750`–`0.01330`; maximum absolute
  exceedance-curve error no greater than `3e-5` in 200,000-sample checks.
- Example 6, ten order-2 fits using 18 responses each: mean RMSE `0.287 m`;
  median log10 error between the mean APCE curve and original MCS curve
  `0.445` over probabilities at or above `1e-4`.

All 39 MATLAB source files were also parsed with the tree-sitter MATLAB grammar
with zero syntax failures. A MATLAB runtime was not available in the build
environment, so `run_tests('full')` remains the definitive release-specific
execution check on the user's MATLAB installation.
