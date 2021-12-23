%STOKES2PSICHI   Convert normalised Stokes vectors to the PSI and CHI angles.
%   [PSI, CHI] = STOKES2PSICHI(STOKES) converts a series of Stokes vectors
%   into the corresponding spherical angles PSI and CHI. STOKES is an 3xM
%   matrix represented three-elements Stokes vectors. The angles are in the
%   ranges 0 <= 2*PSI < 2*pi and -pi/2 <= 2*CHI < pi/2.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [psi, chi] = stokes2psichi(stokes)

assert(size(stokes, 1) == 3);
psi = atan2(stokes(2, :), stokes(1, :));
psi(psi < 0) = psi(psi < 0) + 2*pi;
psi = psi/2;

chi = asin(stokes(3, :))/2;

map = isfinite(psi(:));
assert(min(2*psi(map)) >= 0);
assert(max(2*psi(map)) <= 2*pi);
assert(min(2*chi(map)) >= -pi/2);
assert(max(2*chi(map)) <= pi/2);

stokes2 = psichi2stokes(psi, chi);
map1 = isfinite(stokes);
err = abs(stokes - stokes2);
err = err(map1(:));
assert(max(err) < 1e-7);
end
