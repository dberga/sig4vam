function [ Imask ] = getmask_contour_xy( I,gridsize, len, spacing, clen , acent, bcent)

[xcent,ycent]=getcoords_xy( gridsize, len, 0, spacing, acent, bcent );

[~,x_coords,y_coords]=getshape_xy(I,xcent,ycent,spacing);


bleft=max(1,bcent-clen);
bright=min(gridsize(2),bcent+clen);

[ xleft, ~ ] = getcoords_xy( gridsize, len, 0, spacing, acent, bleft );
[ xright, ~ ] = getcoords_xy( gridsize, len, 0, spacing,  acent, bright );

xleft=xleft-round(len*0.5);
xright=xright+round(len*0.5);

x_coords=[xleft:min(x_coords), x_coords];
x_coords=[x_coords, max(x_coords):xright];

C=size(I,3);
Imask=zeros(size(I,1), size(I,2),C);

for c=1:C    
    Imask(y_coords,x_coords,c)=ones(numel(y_coords),numel(x_coords));
end

end

