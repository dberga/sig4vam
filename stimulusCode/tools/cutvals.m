function [ I ] = cutvals( I, min, max )
if nargin<3, max=1; end
if nargin<2, min=0; end

I(I < min) = min;
I(I > max) = max;

end

