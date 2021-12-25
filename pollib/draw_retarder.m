%DRAW_RETARDER   Draw a retarder path in the Poincare' sphere.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [U, s1] = draw_retarder(Q, thmax, s0)

scale = 1;
ths = linspace(0, thmax, 50);
pts = zeros(3, numel(ths));
for i=1:numel(ths)
    U = SU2(Q, ths(i));
    s1 = U*s0;
    S1 = spinor2r(s1);
    S1 = S1/norm(S1);
    pts(:, i) = scale*S1;
end
U = SU2(Q, thmax);
s1 = U*s0;

ln2 = 6;

hold on;
plot3(pts(1, :), pts(2, :), pts(3, :), 'LineWidth', ln2);
hold off;

end
