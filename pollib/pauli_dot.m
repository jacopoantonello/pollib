%PAULI_DOT   Evaluate the dot product of Q with Pauli matrices.
%   [J] = PAULI_DOT(Q).
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [J] = pauli_dot(Q)
[s1, s2, s3] = pauli();
J = s1*Q(1) + s2*Q(2) + s3*Q(3);
end
