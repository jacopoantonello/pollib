%SPINOR2R   Convert a Jones vector to a normalised Stokes vector.
%   [R] = SPINOR2R(S) returns the three-elements real-valued Stokes vector R
%   corresponding to the two-elements complex-valued Jones vector S. See Eq.
%   (5) in [1].
%
%   [1] He, Chao, Jacopo Antonello, and Martin J. Booth. "Vectorial adaptive
%   optics." arXiv preprint arXiv:2110.02606 (2021).
%
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [r] = spinor2r(s)
assert(size(s, 2) == 1);
assert(size(s, 1) == 2);
assert(numel(s) == 2);
[s1, s2, s3] = pauli();
r = [s'*s1*s; s'*s2*s; s'*s3*s];
end
