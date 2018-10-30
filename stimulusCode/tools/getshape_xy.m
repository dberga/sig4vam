function [Ishape, x_coords, y_coords ] = getshape_xy(I,xcent,ycent,spacing)

if mod(spacing,2) %odd
    hlen=fix(spacing/2);
    y_coords=ycent-hlen:ycent+hlen;
    x_coords=xcent-hlen:xcent+hlen;
else %even
    hlen=fix(spacing/2)-1;
    y_coords=ycent-hlen:ycent+hlen+1;
    x_coords=xcent-hlen:xcent+hlen+1;
end
%len=round(hlen/1.2); %1.5

ydiff=(size(I,1))-(ycent+hlen+1);
xdiff=(size(I,2))-(xcent+hlen+1);
if ydiff<=0
    y_coords=size(I,1)-numel(y_coords)+1:size(I,1);
end
if xdiff<=0
    x_coords=size(I,2)-numel(x_coords)+1:size(I,2);
end
yzdiff=ycent-(hlen+1);
xzdiff=xcent-(hlen+1);
if yzdiff<=0
    y_coords=1:numel(y_coords);
end
if xzdiff<=0
    x_coords=1:numel(x_coords);
end


Ishape=I(y_coords,x_coords,:);


end

