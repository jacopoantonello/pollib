clear;
clc;

restoredefaultpath();
addpath('../pollib');

% GRIN lens profile

% kk = 180/pi; units = '[deg]';
kk = 1/(2*pi); units = '[wav]';

nsamp = 64;
max_ret = pi;
ret_profile = @(r) max_ret*r.^2;

% input 4-Stokes vector
S4in = [1; 1; 0; 0];

%% plot retardance profiles

dd1 = linspace(-1, 1, nsamp);
[xx, yy] = meshgrid(dd1, dd1);
[th, rh] = cart2pol(xx, yy);
rr = sqrt(xx.^2 + yy.^2);
map = rr <= 1;
ret = ret_profile(rr);

mm = 2;
nn = 2;

sfigure(1);
clf();
subplot(mm, nn, 1);
dimagesc(xx, yy, kk*ret, ['ret ', units]);
subplot(mm, nn, 2);
dimagesc(xx, yy, kk*th, ['\theta1 (slow; ne) ', units]);
subplot(mm, nn, 3);
dimagesc(xx, yy, kk*(th + pi/2), ['\theta2 (fast; no) ', units]);
subplot(mm, nn, 4);
r1 = linspace(0, 1, 200);
plot(r1, kk*ret_profile(r1));
grid on;
xlabel('radius');
legend('retardance');
ylabel(units);

%% make Jones and Mueller matrices

siz1 = size(xx);
Ms = zeros([4, 4, siz1]);
Js = complex(zeros([2, 2, siz1]));
for i=1:numel(map)
    if map(i)
        R = mkR(th(i));
        Ji = R*diag([exp(1j*ret(i)), 1])*R';
        Js(:, :, i) = Ji;
        Ms(:, :, i) = jones2mueller(Ji);
    end
end

%% plot Mueller aperture profile

sfigure(2);
plot_mueller_ap(Ms);

%% compute output 3-Stokes vectors after the GRIN lens

stokes = -inf*ones([3, prod(siz1)]);
for i=1:numel(map)
    if map(i)
        S4out = Ms(:, :, i)*S4in;
        stokes(:, i) = S4out(2:end);
    end
end
stokes = reshape(stokes, [3, siz1]);

%% plot 3-Stokes field

sfigure(3);
plot_stokes_ellipses(stokes, xx, yy, 'fill', 1);
title('Stokes field');



