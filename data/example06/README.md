# Offshore Example 6 reference data

`MCS_100000.mat` contains the original 100,000 truth-model evaluations used
by the authors' public `longterm-extreme` MATLAB repository. It stores the
standard-normal environmental coordinates `Q1`, `Q2`, and the 30-minute
maximum surge response `Z` in metres.

`surge_max_mex.mexw64` is the companion 64-bit Windows MEX truth solver. It
is optional: `example06_offshore_extreme.m` uses the portable MAT data. On a
compatible Windows/MATLAB installation, the MEX call
`surge_max_mex(q1,q2,0)` generates an additional response realization.

Source: <https://github.com/hyeonguklim/longterm-extreme>, commit
`3d5c92fa2814897a68bfd8ca20cc9d03917c6d99`, under the MIT license copied to
`licenses/longterm-extreme-MIT-LICENSE.txt`.

SHA-256:

- `MCS_100000.mat`: `aa9f2411792fbb653e8b4d9abaf0d8efd5a028d352b4ddd06b7127a4fcff6e3c`
- `surge_max_mex.mexw64`: `3cd3e7ce528251cec19675d888c7731414103ac8cdfe195d789be8715657f3ae`
