%resize/rescale target to new spacing (only target position)
function [I,ycoord,xcoord]=image_resizetarget(I,xcoord,ycoord,spacing,backgnd,factor,shape)


newspacing=size(imresize(zeros(spacing(1),spacing(end)),factor))+2;

[~,x_coords,y_coords]=getshape_xy(I,xcoord,ycoord,spacing(1));
[~,x_coords_new,y_coords_new]=getshape_xy(I,xcoord,ycoord,newspacing(1));
Icurrent=I(y_coords,x_coords,:);

C=size(I,3);
for c=1:C
    I(y_coords,x_coords,c)=backgnd(c,:).*ones(spacing,spacing);
end

if nargin < 7
    Inew=imresize(Icurrent,factor,'bicubic');
else
    Inew=imresize(imcomplement(shape),newspacing,'bicubic');
end

if factor >= 1
    if sum(Inew(:)) >= sum(sum(backgnd(c,:).*ones(newspacing(1))))
        I(y_coords_new,x_coords_new,:)=max(Inew,I(y_coords_new,x_coords_new,:));
    else
        I(y_coords_new,x_coords_new,:)=min(Inew,I(y_coords_new,x_coords_new,:));
    end
else
    I(y_coords_new,x_coords_new,:)=min(Inew,I(y_coords_new,x_coords_new,:));
end


% xcoord=xcoord-(xcoord-(spacing/2))+round(newspacing/2);
% ycoord=ycoord-(ycoord-(spacing/2))+round(newspacing/2);

end
