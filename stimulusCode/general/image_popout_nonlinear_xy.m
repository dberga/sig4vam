function [I,xcent,ycent]=image_popout_nonlinear_xy(gridsize,len,wid,spacing,angle,contrast,backgnd,jitter_pos,jitter_ang,surr_prob,acent,bcent,sconj,xfound,yfound)
%draw a uniform texture with a single element at a different orientation
%and/or contrast
if nargin<6, contrast=0.5*ones(size(angle)); end
if nargin<7, backgnd=0.5; end
if nargin<8, jitter_pos=0; end
if nargin<9, jitter_ang=0; end
if nargin<10, surr_prob=1; end

bar=define_bar(len,wid);
[I,~,xlocations,ylocations]=define_blank_image(gridsize,len,spacing,backgnd);
hlen=fix((size(bar,1)-1)/2);
imsize=[1 1 size(I,1) size(I,2)];

if nargin<11, acent=ceil(length(xlocations)/2); bcent=ceil(length(ylocations)/2); end
if nargin<12, bcent=ceil(length(ylocations)/2); end
if nargin<13, sconj=getsconj( gridsize, surr_prob ); end
if nargin<14, [ xfound,yfound ] = getjitterpos( imsize, hlen, xlocations, ylocations, jitter_pos, acent,bcent,surr_prob,sconj); end

hlen=fix((size(bar,1))/2); 

coo=0;
a=0;
for x=xlocations
  angleval1=angle(3).*a+(2*jitter_ang*rand)-jitter_ang;
  a=a+1;
  b=0;
  for y=ylocations
    angleval2=angle(3).*b+angleval1;
    b=b+1;
    if sconj(a,b)<=surr_prob || (a==acent && b==bcent)
        coo=coo+1;
        xval=xfound(coo);
        yval=yfound(coo);
    end
    if a==acent && b==bcent
      I=draw_bar(I,xval,yval,bar,angle(1),contrast(1),backgnd);
      xcent=xval;
      ycent=yval;
    else
      if sconj(a,b)<=surr_prob
        I=draw_bar(I,xval,yval,bar,angleval2,contrast(2),backgnd);
      end
      
    end
  end
  
end

