%PLOT_MUELLER_AP   Plot a Mueller matrices aperture.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [merge] = plot_mueller_ap(M)
merge = flatten_mueller_ap(M);
imagesc(merge);
axis image;
axis off;
colorbar();
end
