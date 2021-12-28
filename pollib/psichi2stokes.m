%PSICHI2STOKES   Convert angles PSI and CHI into normalised Stokes vectors.
%   [STOKES] = PSICHI2STOKES(PSI, CHI) converts a series of spherical
%   angles PSI and CHI into three-elements, normalised Stokes vectors
%   STOKES. STOKES is an 3xM matrix.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [stokes] = psichi2stokes(psi, chi)
s1 = size(psi, 1);
s2 = size(psi, 2);
chi = reshape(chi, 1, s1*s2);
psi = reshape(psi, 1, s1*s2);
stokes = [
        cos(2*chi).*cos(2*psi);
        cos(2*chi).*sin(2*psi);
        sin(2*chi);
        ];
stokes = reshape(stokes, 3, s1, s2);
end
