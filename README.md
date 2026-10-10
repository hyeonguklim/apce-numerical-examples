# APCE structural reliability examples

This package reproduces the six numerical examples in Lim and Manuel (2021),
*Distribution-Free Polynomial Chaos Expansion Surrogate Models for Efficient
Structural Reliability Analysis*. It includes a reusable APCE implementation,
the published limit-state functions and distributions, paper-scale scripts,
automated checks, and the original offshore truth-model data.

## Run it

Use MATLAB R2019b or newer. Base MATLAB is sufficient for the five analytic
benchmarks and for verification with the bundled offshore data.

```matlab
cd('path/to/APCE_Structural_Reliability')
setup_apce

% Fast first run: all six examples, plots, and checks
report = run_all_examples('quick',true);

% Publication-scale Monte Carlo and replicate counts
report = run_all_examples('paper',true);
```

`quick` mode is intended for a first verification. `paper` mode uses 100
replicates of 100,000 MCS samples for Examples 1–2 and 10 replicates of one
million samples for Examples 3–5, matching the paper. Example 6 always uses
the authors' original 100,000-run offshore dataset.

Run unit tests with:

```matlab
run_tests('core')   % APCE basis and exact-polynomial tests
run_tests('full')   % also runs every example in quick mode
```

## Package organization

- `+apce/` — multi-index generation, joint-moment basis construction,
  regression, prediction, empirical reliability utilities, and toolbox-free
  probability helpers.
- `+benchmarks/` — the published input models and performance functions.
- `examples/` — one commented runner for each of the six paper examples.
- `data/example06/` — original offshore MCS data and optional Windows MEX
  truth solver from the authors' companion repository.
- `tests/` — core and end-to-end checks.
- `verification/EXPECTED_RESULTS.md` — published targets and tolerances.

## Method implemented

For all total-degree monomials through order `p`, the code estimates the joint
raw-moment Gram matrix from unlabeled input samples. A Cholesky form of
Gram–Schmidt creates an empirical orthonormal basis, and ordinary least squares
fits the APCE coefficients to the expensive truth-model evaluations. Inputs
are centered and scaled before moment construction for numerical stability;
this affine change preserves the polynomial space.

The truth-evaluation count follows the paper's `Ns = 3*nchoosek(d+p,p)` rule.
Moment samples are unlabeled and do not require truth-model calls.

## Reproduction notes

- Examples 1 and 2 check the paper's tabulated failure-probability and RMSE
  values. Examples 3–6 check the published exceedance curves.
- Example 3's marginals and Pearson correlation do not uniquely define a
  joint law. The package uses a stated Gaussian-copula/Nataf completion,
  calibrated to correlation 0.5.
- Example 6 maps the stored normal coordinates to physical `Hs` and `Tp` with
  the environmental model given in the authors' dissertation, fits ten
  order-2 APCE models with 18 response evaluations each, and compares them
  against the bundled 100,000-run response dataset.
- APCE tail estimates are Monte Carlo quantities. Small numerical differences
  across MATLAB releases are expected; the random seeds are fixed.

## References

- The primary paper DOI is <https://doi.org/10.1016/j.ress.2020.107256>.
- The authors' APCE implementation (simpler version for independent variables) is at <https://github.com/hyeonguklim/aPCE>
- The offshore dataset and executable are from <https://github.com/hyeonguklim/longterm-extreme>.
- Their MIT licenses are included under `licenses/`.
