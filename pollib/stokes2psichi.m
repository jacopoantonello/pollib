%STOKES2PSICHI   Convert normalised Stokes vectors to PSI and CHI.
%   [PSI, CHI] = STOKES2PSICHI(STOKES) converts a series of Stokes vectors
%   into the corresponding spherical angles PSI and CHI. STOKES is an 3xM
%   matrix represented three-elements Stokes vectors. The angles are in the
%   ranges 0 <= 2*PSI < 2*pi and -pi/2 <= 2*CHI < pi/2.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [psi, chi] = stokes2psichi(stokes)

siz1 = size(stokes, 1);
siz2 = size(stokes, 2);
siz3 = size(stokes, 3);

assert(siz1 == 3);

stokes2 = reshape(stokes, 3, siz2*siz3);

psi = atan2(stokes2(2, :), stokes2(1, :));
psi(psi < 0) = psi(psi < 0) + 2*pi;
psi = psi/2;

chi = asin(stokes2(3, :))/2;

map = isfinite(psi(:));
assert(min(2*psi(map)) >= 0);
assert(max(2*psi(map)) <= 2*pi);
assert(min(2*chi(map)) >= -pi/2);
assert(max(2*chi(map)) <= pi/2);

psi = reshape(psi, siz2, siz3);
chi = reshape(chi, siz2, siz3);

stokes3 = psichi2stokes(psi, chi);
map1 = isfinite(stokes);
err = abs(stokes - stokes3);
err = err(map1(:));
assert(max(err) < 1e-7);
end
