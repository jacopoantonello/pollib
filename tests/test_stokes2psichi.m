clear;
clc;

restoredefaultpath();
addpath('../pollib');

nsamp = 512;
S0 = sample_sphere(nsamp);
S0 = [eye(3), -eye(3), S0];
[psi, chi] = stokes2psichi(S0);
S1 = psichi2stokes(psi, chi);
allclose(S0, S1);



