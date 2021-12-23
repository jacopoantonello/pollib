%PAULI   Get the Pauli matrices S1, S2, and S3.
%   [S1, S2, S3] = PAULI(). See Eq. (4) in [1].
%
%   [1] He, Chao, Jacopo Antonello, and Martin J. Booth. "Vectorial adaptive
%   optics." arXiv preprint arXiv:2110.02606 (2021).
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [s1, s2, s3] = pauli()
s1 = [1, 0; 0, -1];
s2 = [0, 1; 1, 0];
s3 = [0, 1j; -1j, 0];
end
