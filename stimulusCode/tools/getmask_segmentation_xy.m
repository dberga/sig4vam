function [ Imask ] = getmask_segmentation_xy( I,xcent,ycent,spacing)


[~,x_coords,y_coords]=getshape_xy(I,xcent,ycent,spacing);

C=size(I,3);
Imask=zeros(size(I,1), size(I,2),C);

for c=1:C    
    Imask(:,x_coords,c)=ones(numel(1:size(I,1)),numel(x_coords));
end


end

