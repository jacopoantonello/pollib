%MUELLER2JONES   Convert a Mueller matrix into a Jones matrix.
%   [J] = MUELLER2JONES(M, VARARGIN) computes one of the Jones matrices
%   associated to the Mueller matrix M.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [J] = mueller2jones(M, varargin)

p = inputParser;
addRequired(p, 'M');
addOptional(p, 'check', 1);
parse(p, M, varargin{:});

[s1, s2, s3] = pauli();
I = eye(2);
P = [I(:), s1(:), s2(:), s3(:)];
Pp = (1/sqrt(2))*P;
K = Pp*transpose(M)*Pp';
R = complex(zeros(size(K)));
for i=1:4
    u = zeros(2, 2);
    u(i) = 1;
    m = logical(kron(u, ones(2, 2)));
    R(i, :) = K(m);
end
[Ub, Sb, ~] = svd(R);
sv = diag(Sb);
if p.Results.check
    allclose(norm(sv(2:end)), 0);
end
Jt = reshape(sqrt(sv(1))*Ub(:, 1), 2, 2);
J = transpose(Jt);
Mt = jones2mueller(J);
if p.Results.check
    allclose(Mt, M);
end
end
