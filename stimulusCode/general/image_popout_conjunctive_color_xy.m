function [I,xcent,ycent,xfound,yfound]=image_popout_conjunctive_color_xy(gridsize,len,wid,spacing,angle,contrast,backgnd,jitter_pos,jitter_ang,surr_prob,conj_prob,acent,bcent,rconj,sconj,xfound,yfound)
%draw a uniform texture with a single element at a different orientation
%and/or contrast
if nargin<6, contrast=0.5*ones(size(angle)); end
if nargin<7, backgnd=0.5*ones(size(contrast,1)); end
if nargin<8, jitter_pos=0; end
if nargin<9, jitter_ang=0; end
if nargin<10, surr_prob=1; end
if nargin<11, conj_prob=1; end

bar=define_bar(len,wid);
[I,~,xlocations,ylocations]=define_blank_image(gridsize,len,spacing,backgnd(1));
hlen=fix((size(bar,1))/2); 
imsize=[1 1 size(I,1) size(I,2)];

if nargin<12, acent=ceil(length(xlocations)/2); bcent=ceil(length(ylocations)/2); end
if nargin<13, bcent=ceil(length(ylocations)/2); end
if nargin<14, rconj=getsconj( gridsize, conj_prob ); end
if nargin<15, sconj=getsconj( gridsize, surr_prob ); end
if nargin<16, [ xfound,yfound ] = getjitterpos( imsize, hlen, xlocations, ylocations, jitter_pos, acent,bcent,surr_prob,sconj); end

C=size(contrast,1);
for c=1:C
 I(:,:,c)=zeros(size(I(:,:,1)));
 [I(:,:,c),xcent,ycent,xfound,yfound]=image_popout_conjunctive_xy(gridsize,len,wid,spacing,angle,contrast(c,:)-backgnd(c,:),backgnd(c,:),jitter_pos,jitter_ang,surr_prob,conj_prob,acent,bcent,rconj,sconj,xfound,yfound);
end

end
