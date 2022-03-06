%MKR   Make a rotation matrix.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [R] = mkR(th)
R = [
    cos(th), -sin(th);
    sin(th), cos(th)
    ];
end
