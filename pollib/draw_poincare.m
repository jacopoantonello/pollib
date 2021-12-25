%DRAW_POINCARE   Draw the Poincare' sphere.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [] = draw_poincare(pc)

sfigure(pc.fig);

[x,y,z] = sphere(75);
surf(x,y,z);
hold on;
alpha .45;
axis equal;
shading interp;
grid on;
view(pc.azim, pc.elev);
box on;
axis off;

set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(gca, 'ZTick', []);

red = [0.6350, 0.0780, 0.1840];
green = [0.4660, 0.6740, 0.1880];
blue = [0, 0.4470, 0.7410];
ln = 1;
fs = 12;
scale = 1.3;

if pc.show_axes
    hold on;
    draw_axis([1, 0, 0], red);
    draw_axis([0, 1, 0], green);
    draw_axis([0, 0, 1], blue);
    draw_spinor([1; 0], 'H', red);
    draw_spinor([0; 1], 'V', red);
    draw_spinor([1; 1], '+45', green);
    draw_spinor([1; -1], '-45', green);
    draw_spinor([1; 1j], 'L', blue);
    draw_spinor([1; -1j], 'R', blue);
    hold off;
end

    function draw_axis(ax_, col_)
        rr_ = zeros(2, 3);
        rr_(2, :) = ax_;
        plot3(rr_(:, 1), rr_(:, 2), rr_(:, 3), 'Color', col_, 'LineWidth', ln);
        rr_ = zeros(2, 3);
        rr_(2, :) = -ax_;
        plot3(rr_(:, 1), rr_(:, 2), rr_(:, 3), 'Color', col_, 'LineWidth', ln);
    end
    function draw_spinor(s_, lab_, col_)
        t_ = spinor2r(s_/norm(s_(:)));
        t_ = scale*t_/norm(t_);
        text(t_(1), t_(2), t_(3), lab_, 'FontSize', fs, 'Color', col_);
    end
end
