%GET_MU_Q   Get Mu and q.
%   [Q1, MU1, Q2, MU2] = get_mu_q(A). Returns the eigenvectors Q1 and Q2
%   and the eigenvalues MU1 and MU2 of matrix A.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [q1, mu1, q2, mu2] = get_mu_q(A)
[V, D] = eig(A);
q1 = V(:, 1);
mu1 = D(1, 1);
q2 = V(:, 2);
mu2 = D(2, 2);
end
