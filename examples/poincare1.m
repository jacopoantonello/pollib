clear;
clc;

restoredefaultpath();
addpath('../pollib');

%%

pc.fig = 10;
pc.show_axes = 1;
pc.azim = 10.2971;
pc.elev = -8.8796;

sfigure(pc.fig);
clf();
draw_poincare(pc);



