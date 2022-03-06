%DIMAGESC   Imagesc for circular apertures.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [] = dimagesc(xx, yy, what, titl)
map = sqrt(xx.^2 + yy.^2) <= 1;
tmp = what;
tmp(~map) = nan;
imagesc(xx(1, :), yy(:, 1), tmp);
ax_ = gca;
ax_.YDir = 'normal';
mm1_ = min(tmp(map));
mm2_ = max(tmp(map));
dd_ = mm2_ - mm1_;
axis image; title(sprintf('%s [%4.1f %4.1f] %4.1f', ...
    titl, mm1_, mm2_, dd_));
colorbar();
end
