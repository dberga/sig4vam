function [I,xcent,ycent,xfound,yfound]=image_popout_anyshape_multiple_color_xy(gridsize,len,wid,spacing,angle,contrast,backgnd,jitter_pos,jitter_ang,surr_prob,shape_cell,acent,bcent,sconj,xfound,yfound)
%draw a uniform texture with a single element at a different orientation
%and/or contrast
if nargin<6, contrast=0.5*ones(size(angle)); end
if nargin<7, backgnd=0.5.*ones(size(contrast,1)); end
if nargin<8, jitter_pos=0; end
if nargin<9, jitter_ang=0; end
if nargin<10, surr_prob=1; end
if nargin<11, shape_cell={define_bar(len,wid),define_bar(len,wid)}; end

bar1=define_anyshape(len,wid,shape_cell{1});
bar2=define_anyshape(len,wid,shape_cell{2});
[I,~,xlocations,ylocations]=define_blank_image(gridsize,len,spacing,backgnd(1));
hlen=fix((size(shape,1))/2); 
%for color/brightess experiments, avoid screen luminosity gradient by drawing stimulus outside up and down margins
xmargin=floor(0.15*size(I,1));
ymargin=0;
imsize=[1+xmargin 1+ymargin size(I,1)-xmargin size(I,2)-ymargin];

if nargin<12, acent=ceil(length(xlocations)/2); bcent=ceil(length(ylocations)/2); end
if nargin<13, bcent=ceil(length(ylocations)/2); end
if nargin<14, sconj=getsconj( gridsize, surr_prob ); end
if nargin<15, [ xfound,yfound ] = getjitterpos( imsize, hlen, xlocations, ylocations, jitter_pos, acent,bcent,surr_prob,sconj); end


C=size(contrast,1);
for c=1:C
I(:,:,c)=zeros(size(I(:,:,1)));
[I(:,:,c),xcent,ycent,xfound,yfound]=image_popout_anyshape_multiple_xy(gridsize,len,wid,spacing,angle,contrast(c,:)-backgnd(c,:),backgnd(c,:),jitter_pos,jitter_ang,surr_prob,shape_cell,acent,bcent,sconj,xfound,yfound);
end
end

