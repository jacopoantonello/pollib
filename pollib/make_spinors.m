%MAKE_SPINORS   Make a Jones vector of a set of Jones vectors.
%
%   This file is part of the PolLib library. See also POLLIB_VERSION.
function [ji] = make_spinors(jis, xx, yy)
if ischar(jis)
    if strcmp(jis, 'H')
        ji = [1; 0];
    elseif strcmp(jis, 'V')
        ji = [0; 1];
    elseif strcmp(jis, '+45')
        ji = [1; 1]/sqrt(2);
    elseif strcmp(jis, '-45')
        ji = [1; -1]/sqrt(2);
    elseif strcmp(jis, 'RC')
        ji = [1; -1j]/sqrt(2);
    elseif strcmp(jis, 'LC')
        ji = [1; 1j]/sqrt(2);
    elseif strcmp(jis, 'radial')
        th = atan2(yy, xx);
        ji = [reshape(cos(th), 1, []); reshape(sin(th), 1, [])];
    elseif strcmp(jis, 'azimuthal')
        th = atan2(yy, xx);
        ji = [reshape(-sin(th), 1, []); reshape(cos(th), 1, [])];
    else
        throw(MException('VerifyOutput:IllegalInput', ...
            ['Choose from H, V, +45, -45, RC, LC, radial, or azimuthal, ' ...
            'not ', jis]));
    end
else
    allclose(numel(jis), 2);
    ji = jis(:)/norm(jis);
end

if exist('xx', 'var') && numel(ji) == 2
    ji = repmat(ji, [1, numel(xx)]);
end
end

