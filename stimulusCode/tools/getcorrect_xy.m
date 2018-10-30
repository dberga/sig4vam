function [ I ] = getcorrect_xy( I, correct_size )
if nargin<2, correct_size=size(I); end

I=cutvals(I);
I=imresize(I,correct_size,'nearest');
C=size(I,3);
if C==1, I(:,:,2)=I(:,:,1); I(:,:,3)=I(:,:,1); end
I=im2uint8(I);

end

