function [ shape ] = load_anyshape( path, flag_grayscale )
if nargin<2, flag_grayscale=0; end

Ishape=mat2gray(imread(path));
shape=Ishape;

C=size(Ishape,3);
if C>1 && flag_grayscale==true
%     for c=1:C
%         shape(:,:,c)=imcomplement(rgb2gray(Ishape)); 
%     end
    shape=imcomplement(rgb2gray(Ishape));
else
%     shape=imcomplement(Ishape);
end

shape=cutvals(shape);

end

