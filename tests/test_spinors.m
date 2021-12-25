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


