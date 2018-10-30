function [ shape ] = load_anyshape( path )

Ishape=mat2gray(imread(path));

C=size(Ishape,3);
if C>1
%     for c=1:C
%         shape(:,:,c)=imcomplement(rgb2gray(Ishape)); 
%     end
    shape=imcomplement(rgb2gray(Ishape));
else
    shape=imcomplement(Ishape);
end

shape=cutvals(shape);

end

