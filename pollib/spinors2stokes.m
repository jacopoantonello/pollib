%SPINORS2STOKES   Convert Jones to Stokes vectors.
%   [S] = SPINORS2STOKES(JS) converts an array of Jones vectors into
%   three-elements, normalised Stokes vectors.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [S] = spinors2stokes(js)
s1 = size(js, 2);
s2 = size(js, 3);
js = reshape(js, 2, s1*s2);
S = zeros(3, s1, s2);
for i=1:size(js, 2)
    S(:, i) = spinor2r(js(:, i));
end
S = reshape(S, 3, s1, s2);
end

