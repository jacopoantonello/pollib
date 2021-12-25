clear;
clc;

restoredefaultpath();
addpath('../pollib');

%% draw the Poincare' sphere

pc.fig = 10;
pc.show_axes = 1;
pc.azim = 10.2971;
pc.elev = -8.8796;

sfigure(pc.fig);
clf();
draw_poincare(pc);

%% draw a random retarder

a = randn(2, 1) + 1j*randn(2, 1);
a = a/norm(a);

Q = randn(3, 1);
Q = Q/norm(Q);
th = randn();

% a = [1; 0];
% Q = [0; 1; 0];
% th = pi/2;

[U, b] = draw_retarder(Q, th, a);

hold on;

A = spinor2r(a);
plot3(A(1), A(2), A(3), 'Marker', '.', 'MarkerSize', 12);
B = spinor2r(b);
plot3(B(1), B(2), B(3), 'Marker', '.', 'MarkerSize', 12);
pts = 1.1*[Q, -Q];
plot3(pts(1, :), pts(2, :), pts(3, :));
pts = 1.1*Q;
text(pts(1, :), pts(2, :), pts(3, :), 'Q');

hold off;

