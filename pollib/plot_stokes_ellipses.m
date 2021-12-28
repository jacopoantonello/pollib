%PLOT_STOKES_ELLIPSES   Plot polarisation ellipses.
%   PLOT_STOKES_ELLIPSES(STOKES, XX, YY, VARARGIN) plots the polarisation
%   ellipses corresponding to the three-elements Stokes vectors specified
%   in STOKES.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [] = plot_stokes_ellipses(stokes, xx, yy, varargin)

p = inputParser;
addRequired(p, 'stokes');
addRequired(p, 'xx');
addRequired(p, 'yy');
addOptional(p, 'downsample', 16);
addOptional(p, 'absolutecmap', 1);
addOptional(p, 'scale', 1);
addOptional(p, 'cmap', parula(256));
addOptional(p, 'fill', 1);
addOptional(p, 'arrow', []);
addOptional(p, 'background', [0, 0, 0]);
addOptional(p, 'linewidth', 1);
addOptional(p, 'hsv', 0);
addOptional(p, 'alpha1', 1);
addOptional(p, 'alpha2', 1);
addOptional(p, 'arrowsize', 12);
addOptional(p, 'arrowmarker', '.');
parse(p, stokes, xx, yy, varargin{:});
downsample = p.Results.downsample;
scale1 = .45*p.Results.scale;
arrowSize = p.Results.arrowsize;
arrowMarker = p.Results.arrowmarker;

if p.Results.hsv && norm(p.Results.background) == 0
    back_colour = .92*ones(1, 3);
else
    back_colour = p.Results.background;
end

allclose(size(stokes, 1), 3);
allclose(size(stokes, 2), size(xx, 1));
allclose(size(stokes, 3), size(xx, 2));

Ncols = size(p.Results.cmap, 1);

arrow = p.Results.arrow;
if numel(arrow) == 1
    arrow = arrow*ones(size(stokes, 2), size(stokes, 3));
elseif numel(arrow) > 1
    assert(size(arrow, 1) == size(stokes, 2));
    assert(size(arrow, 2) == size(stokes, 3));
end

siz1 = size(xx);
if numel(downsample) == 1
    siz2 = size(stokes);
    siz2 = siz2(2:end);
    downsample = round(siz2/max(siz2(:))*downsample);
end

if ~isempty(downsample) && any(siz1 > downsample)
    s1 = squeeze(stokes(1, :, :));
    s2 = squeeze(stokes(2, :, :));
    s3 = squeeze(stokes(3, :, :));
    
    dd1 = linspace(xx(1, 1), xx(1, end), downsample(2));
    dd2 = linspace(yy(1, 1), yy(end, 1), downsample(1));
    [xx2, yy2] = meshgrid(dd1, dd2);
    
    s1q = interp2(xx, yy, s1, xx2, yy2);
    s2q = interp2(xx, yy, s2, xx2, yy2);
    s3q = interp2(xx, yy, s3, xx2, yy2);
    
    if numel(arrow) > 1
        arrow = interp2(xx, yy, arrow, xx2, yy2);
    end
    
    stokes2 = zeros([3, downsample]);
    stokes2(1, :, :) = s1q;
    stokes2(2, :, :) = s2q;
    stokes2(3, :, :) = s3q;
    for i=1:size(stokes2, 2)
        for j=1:size(stokes2, 3)
            stokes2(:, i, j) = stokes2(:, i, j)/norm(stokes2(:, i, j));
        end
    end
else
    xx2 = xx;
    yy2 = yy;
    stokes2 = stokes;
end

mask = squeeze(logical(sum(isfinite(stokes2), 1)));

Nsamp = 16;
omegat = (0:(Nsamp - 2))*(2*pi/Nsamp);
omegatfull = (0:(Nsamp - 1))*(2*pi/Nsamp);

dx = xx2(1, 2) - xx2(1, 1);
dy = yy2(2, 1) - yy2(1, 1);
lxx = xx2(:);
lyy = yy2(:);
heights = p.Results.cmap;
S3min = min(stokes2(3, :));
S3max = max(stokes2(3, :));
[psi1, chi1] = stokes2psichi(stokes2);
for i=1:numel(mask)
    if mask(i)
        x0 = lxx(i);
        y0 = lyy(i);
        
        S = stokes2(:, i);
        assert(all(isfinite(S(:))));
        psi = psi1(i);
        chi = chi1(i);
        
        R = [cos(psi), -sin(psi); sin(psi), cos(psi)];
        col = get_col(S);
        if p.Results.fill
            xyp = R*[
                dx*scale1*cos(chi)*cos(-omegatfull);
                dy*scale1*sin(chi)*sin(-omegatfull)
                ] + kron(ones(1, numel(omegatfull)), [x0; y0]);
            
            hold on;
            h = fill(xyp(1, :), xyp(2, :), col, ...
                'LineWidth', p.Results.linewidth, ...
                'FaceColor', col, ...
                'EdgeColor', col);
            hold off;
            h.EdgeAlpha = p.Results.alpha1;
            h.FaceAlpha = p.Results.alpha2;
        else
            xyp = R*[
                dx*scale1*cos(chi)*cos(-omegat);
                dy*scale1*sin(chi)*sin(-omegat)
                ] + kron(ones(1, numel(omegat)), [x0; y0]);
            
            hold on;
            plot(xyp(1, :), xyp(2, :), 'Color', ...
                [col, p.Results.alpha1], 'LineWidth', p.Results.linewidth);
            if ~isempty(arrow)
                xyp = R*[
                    dx*scale1*cos(chi)*cos(-arrow(i));
                    dy*scale1*sin(chi)*sin(-arrow(i))
                    ] + [x0; y0];
                plot(xyp(1), xyp(2), arrowMarker, 'Color', col, ...
                    'MarkerSize', arrowSize);
            end
            hold off;
        end
    end
end
set(gca, 'Color', back_colour, 'xcolor', back_colour, 'ycolor', back_colour);
axis equal;
span = 1.05;
ylim([-span, span]);
xlim([-span, span]);
set(gca, 'XTick', [], 'YTick', []);

    function [col_] = get_col(S_)
        if p.Results.hsv
            h_ = (atan2(S_(2), S_(1))/pi + 1)/2;
            s_ = 1 - (S_(3) > 0).*(abs(S_(3)).^(3/2));
            v_ = 1 - (S_(3) < 0).*(abs(S_(3)).^(3/2));
            col_ = hsv2rgb([h_, s_, v_]);
        else
            S3_ = S_(3);
            if p.Results.absolutecmap
                colind_ = round(Ncols*(S3_ + 1)/2);
            else
                delta_ = S3max - S3min;
                if delta_ > 1e-6
                    colind_ = round(Ncols*(S3_ - S3min)/delta_);
                else
                    colind_ = round(Ncols/2);
                end
            end
            colind_ = max([1, colind_]);
            colind_ = min([Ncols, colind_]);
            col_ = heights(colind_, :);
        end
        assert(all(isfinite(col_)));
    end
end
