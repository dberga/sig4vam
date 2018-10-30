function [ xcent, ycent ] = getcoords_xy( gridsize, len, wid, spacing, acent, bcent )

% bar=define_bar(len,wid);
[I,~,xlocations,ylocations]=define_blank_image(gridsize,len,spacing,0);
% hlen=fix((size(bar,1))/2); 

ycent=xlocations(acent);
xcent=ylocations(bcent);

end

