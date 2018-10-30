function [I,xcent,ycent, xfound, yfound]=image_popout_anyshape_xy(gridsize,len,wid,spacing,angle,contrast,backgnd,jitter_pos,jitter_ang,surr_prob,shape,acent,bcent,sconj,xfound,yfound)
%draw a uniform texture with a single element at a different orientation
%and/or contrast
if nargin<6, contrast=0.5*ones(size(angle)); end
if nargin<7, backgnd=0.5; end
if nargin<8, jitter_pos=0; end
if nargin<9, jitter_ang=0; end
if nargin<10, surr_prob=1; end
if nargin<11, shape=define_bar(len,wid); end

bar=define_anyshape(len,wid,shape);
[I,~,xlocations,ylocations]=define_blank_image(gridsize,len,spacing,backgnd);
hlen=fix((size(bar,1))/2); 
imsize=[1 1 size(I,1) size(I,2)];

if nargin<12, acent=ceil(length(xlocations)/2); bcent=ceil(length(ylocations)/2); end
if nargin<13, bcent=ceil(length(ylocations)/2); end
if nargin<14, sconj=getsconj( gridsize, surr_prob ); end
if nargin<15, [ xfound,yfound ] = getjitterpos( imsize, hlen, xlocations, ylocations, jitter_pos, acent,bcent,surr_prob,sconj); end


coo=0;
a=0;
for x=xlocations
  a=a+1;
  b=0;
  for y=ylocations
    b=b+1;
    if sconj(a,b)<=surr_prob || (a==acent && b==bcent)
        coo=coo+1;
        xval=xfound(coo);
        yval=yfound(coo);
    end
    angleval=angle+(2*jitter_ang*rand)-jitter_ang;
    if a==acent && b==bcent
      I=draw_bar(I,xval,yval,bar,angle(1),contrast(1),backgnd);
      xcent=xval;
      ycent=yval;
    else
      if sconj(a,b)<=surr_prob
        I=draw_bar(I,xval,yval,bar,angleval(2),contrast(2),backgnd);
      end
    end
  end
end
end


