%R2SPINOR   Convert a normalised Stokes vector into a Jones vector.
%   [S] = R2SPINOR(R) returns S, one of the two-elements complex-valued Jones
%   vectors corresponding to the three-elements real-valued Stokes vector
%   R.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [s] = r2spinor(r)
r = r(:)/norm(r);
X = pauli_dot(r);
[s1, mu1, s2, mu2] = get_mu_q(X);

allclose(abs(mu1), 1);
allclose(abs(mu2), 1);
allclose(mu1*mu2, -1);

if norm(mu1 - 1) < 1e-9
    s = s1;
else
    assert(norm(mu2 - 1) < 1e-9);
    s = s2;
end
