clear;
clc;

restoredefaultpath();
addpath('../pollib');

%% create an arbitrary rotator in the Poincare' sphere

Q = randn(3, 1);
Q = Q/norm(Q);
th = randn();

%% Compute the Jones and Mueller matrices from Q and th

J1 = SU2(Q, th);
M1 = jones2mueller(J1);

%% Compute the Jones and Mueller matrices from M1

J2 = mueller2jones(M1);
M2 = jones2mueller(J2);

%% tests

allclose(M1, M2);

a = randn(2, 1) + 1j*randn(2, 1);
a = a/norm(a);

allclose(spinor2r(J1*a), spinor2r(J2*a));





