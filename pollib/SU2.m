%SU2   Create an SU2 matrix.
%   U = SU2(Q, THETA) returns an SU2 matrix U associated with a rotation of
%   an angle THETA about the axis Q.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [U] = SU2(Q, theta)
U = cos(theta/2)*eye(2) + 1j*sin(theta/2)*pauli_dot(Q);
end
