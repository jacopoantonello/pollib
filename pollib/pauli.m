%PAULI   Get the Pauli matrices S1, S2, and S3.
%   [S1, S2, S3] = PAULI().
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [s1, s2, s3] = pauli()
s1 = [1, 0; 0, -1];
s2 = [0, 1; 1, 0];
s3 = [0, 1j; -1j, 0];
end
