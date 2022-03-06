clear;
clc;

restoredefaultpath();
addpath('../pollib');

%% plot a uniform pupil

d1 = linspace(-2, 2, 32);
d2 = linspace(-1, 1, 16);
[xx, yy] = meshgrid(d1, d2);
jones = make_spinors('RC', xx, yy);
stokes = spinors2stokes(jones);

sfigure(1);
clf();
plot_stokes_ellipses(stokes, xx, yy, 'fill', 0, 'arrow', 2*pi);


