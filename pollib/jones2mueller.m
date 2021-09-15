%JONES2MUELLER   Convert a Jones matrix into a Mueller matrix.
%   [M] = JONES2MUELLER(J) computes the Mueller matrix M corresponding to
%   the Jones matrix J.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [M] = jones2mueller(J)
[s1, s2, s3] = pauli();
I = eye(2);
P = [I(:), s1(:), s2(:), s3(:)];
B = [
    reshape(J'*J, 4, 1), ...
    reshape(J'*s1*J, 4, 1), ...
    reshape(J'*s2*J, 4, 1), ...
    reshape(J'*s3*J, 4, 1) ...
    ];
M = 1/sqrt(2)*transpose(((1/sqrt(2))*P)'*B);
maximag = max(abs(imag(M(:))));
allclose(maximag, 0);
M = real(M);
end
