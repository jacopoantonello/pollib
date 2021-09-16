%SPINOR2R   Convert a Jones vector to a Stokes vector.
%   [R] = SPINOR2R(S) returns the three-elements real-valued Stokes vector
%   R corresponding to the two-elements complex-valued Jones vector S.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [r] = spinor2r(s)
assert(size(s, 2) == 1);
assert(size(s, 1) == 2);
assert(numel(s) == 2);
[s1, s2, s3] = pauli();
r = [s'*s1*s; s'*s2*s; s'*s3*s];
end
