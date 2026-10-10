# Verification targets

The paper's tabulated APCE targets are:

| Example | APCE order | Truth evaluations | Published mean Pf | Published SD(Pf) | Published APCE RMSE |
|---|---:|---:|---:|---:|---:|
| 1 — noisy limit state | 1 | 21 | 1.23e-2 | 3.28e-4 | 2.10e-3 |
| 2 — quadratic limit state | 2 | 45 | 5.57e-2 | 6.89e-4 | 6.90e-16 |

For Examples 3–6, the publication reports exceedance-probability plots rather
than numeric tables. Verification therefore checks curve agreement over the
plotted range and exact polynomial recovery where applicable:

- Example 3: order 1, 9 truth evaluations, thresholds 70–100.
- Example 4: order 7, 360 truth evaluations, thresholds 10–50.
- Example 5: order 2, 30 truth evaluations, thresholds 40–120.
- Example 6: order 2, 18 truth evaluations, thresholds 0–8 m, compared with
  the original 100,000-run offshore truth dataset.

Monte Carlo results vary slightly by platform and seed implementation. The
automated checks use tolerances appropriate to the selected run size. Use
`paper` mode for the publication's replicate and MCS counts.

Example 3 specifies marginals and Pearson correlation but does not uniquely
specify a joint distribution. This package states the missing assumption
explicitly: a Gaussian copula/Nataf model calibrated to Pearson correlation
0.5. The APCE linear reproduction itself is insensitive to this choice; the
tail curve is not.
