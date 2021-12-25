%R2SPINOR   Convert a normalised Stokes vector into a Jones vector.
%   [S] = R2SPINOR(R) returns one of the two-elements complex-valued Jones
%   vectors S corresponding to the three-elements real-valued Stokes vector
%   R.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [Sin] = sample_sphere(nsamp)
theta = (0:(nsamp - 1))/nsamp*pi;
phi = (0:(nsamp - 1))/nsamp*(2*pi);
[tt, pp] = meshgrid(theta, phi);
xx = sin(tt).*cos(pp);
yy = sin(tt).*sin(pp);
zz = cos(tt);
Sin = [
    reshape(xx, 1, numel(xx));
    reshape(yy, 1, numel(xx));
    reshape(zz, 1, numel(xx));
    ];
end
