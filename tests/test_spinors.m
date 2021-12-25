clear;
clc;

restoredefaultpath();
addpath('../pollib');

%% random spinor

s0 = randn(2, 1) + 1j*randn(2, 1);
s0 = s0/norm(s0);

%% tests

s1 = r2spinor(spinor2r(s0));

allclose(spinor2r(s0), spinor2r(s1));

alpha = angle(s1(1)./s0(1));
allclose(s0*exp(1j*alpha), s1);

%% test canonical spinors

s = make_spinors('H');
allclose(s, [1; 0]);
allclose(spinor2r(s), [1; 0; 0]);

s = make_spinors('V');
allclose(s, [0; 1]);
allclose(spinor2r(s), [-1; 0; 0]);

s = make_spinors('+45');
allclose(s, [1; 1]/sqrt(2));
allclose(spinor2r(s), [0; 1; 0]);

s = make_spinors('-45');
allclose(s, [1; -1]/sqrt(2));
allclose(spinor2r(s), [0; -1; 0]);

s = make_spinors('RC');
allclose(s, [1; -1j]/sqrt(2));
allclose(spinor2r(s), [0; 0; 1]);

s = make_spinors('LC');
allclose(s, [1; 1j]/sqrt(2));
allclose(spinor2r(s), [0; 0; -1]);

