%generate absence target from an input popout stimulus
function [I,ycoord,xcoord]=image_absence(I,xcoord,ycoord,spacing,backgnd)

[~,x_coords,y_coords]=getshape_xy(I,xcoord,ycoord,spacing);

C=size(I,3);
for c=1:C
    I(y_coords,x_coords,c)=backgnd(c,:);
end

end
