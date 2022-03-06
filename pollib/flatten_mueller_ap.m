%FLATTEN_MUELLER_AP   Flatten a Mueller matrices aperture.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [m] = flatten_mueller_ap(p)
s1 = size(p, 3);
s2 = size(p, 4);
m = zeros(4*s1, 4*s2);
for i=1:4
    for j=1:4
        m((1 + (i - 1)*s1):(i*s1), (1 + (j - 1)*s2):(j*s2)) = ...
            reshape(p(i, j, :), s1, s2);
    end
end
end
