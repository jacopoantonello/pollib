%PAULI_DOT   Evaluate the dot product of Q with Pauli matrices.
%   [J] = PAULI_DOT(Q). See Eq. (4) in [1].
%
%   [1] He, Chao, Jacopo Antonello, and Martin J. Booth. "Vectorial adaptive
%   optics." arXiv preprint arXiv:2110.02606 (2021).
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [J] = pauli_dot(Q)
[s1, s2, s3] = pauli();
J = s1*Q(1) + s2*Q(2) + s3*Q(3);
end
