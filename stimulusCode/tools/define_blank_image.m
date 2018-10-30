function [I,gridsize,xlocations,ylocations]=define_blank_image(gridsize,len,spacing,backgnd)
gridsize=(gridsize(1:2)-1)*spacing+2+odd(len);
I=zeros(gridsize(1:2))+backgnd;

hlen=ceil(odd(len)/2);
%create regular texture
spacing=round(spacing);
xlocations=1+hlen:spacing:gridsize(1)-hlen;
ylocations=1+hlen:spacing:gridsize(2)-hlen;