function [I] = Simpson(x,y)
% 1/3 Simpson's Rule / By : Oscar Swartz
% ------------------------------------------------------------------------
% This MATLab function uses the 1/3 Sim
if length(x) ~= length(y)
    error('Vectors need to be the same size.')
end
if nargin < 2
    error('Need 2 input variables.')
end
if length(x) < 2
    error('Need at least 2 variables in a Vector.')
end
spacing = diff(x);
spacing_sum = sum(spacing);
spacing_avg = spacing_sum / length(spacing);
if spacing_avg ~= spacing(1)
    error('Spacing between x variables is not equal.')
end
oddoreven = length(spacing)/2;
oddoreven_rounded = round(oddoreven);
if length(spacing) == 1
    disp('Simpsons rule can not be used with 2 variables, trapazoidal rule will be used instead.')
    I = (spacing_avg)*((y(1)+y(2))/2);
elseif oddoreven_rounded == oddoreven
    I = (spacing_avg/3)*(y(1)+4*(sum(y(2:2:end-1)))+2*(sum(y(3:2:end-2)))+y(end));
else
    I_trap = (spacing_avg/3)*(y(1)+4*(sum(y(2:2:end-2)))+2*(sum(y(3:2:end-3)))+y(end-1));
    I = I_trap+(spacing_avg)*((y(end-1)+y(end))/2);
    disp('For an even number of variables one instance of trapazoidal rule must be used.')
end


