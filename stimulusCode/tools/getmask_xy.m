function [ Imask ] = getmask_xy( I,xcent,ycent,spacing, x_coords, y_coords)

if nargin < 5 
    [~,x_coords,y_coords]=getshape_xy(I,xcent,ycent,spacing); 
% else
%     if length(x_coords) < spacing || length(y_coords) < spacing
%         [~,x_coords,y_coords]=getshape_xy(I,xcent,ycent,spacing); 
%     end
end


C=size(I,3);
Imask=zeros(size(I,1), size(I,2),C);

for c=1:C    
    Imask(y_coords,x_coords,c)=ones(numel(y_coords),numel(x_coords));
end


end

