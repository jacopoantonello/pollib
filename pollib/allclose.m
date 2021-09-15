%ALLCLOSE   Check for approximate equality.
%   ALLCLOSE(A, B) triggers an assertion error if A is not approximately
%   equal to B.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [] = allclose(a, b)
assert(norm(a(:) - b(:)) < 1e-10);
end
