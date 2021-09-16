%R2SPINOR   Convert a Stokes vector to a Jones vector.
%   [S] = R2SPINOR(R) returns one of the two-elements complex-valued Jones
%   vectors S corresponding to the three-elements real-valued Stokes vector
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
