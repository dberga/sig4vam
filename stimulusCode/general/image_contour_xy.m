function [I,xcent,ycent,xfound,yfound]=image_contour_xy(gridsize,len,wid,spacing,angle,clen,contrast,backgnd,jitter_pos,jitter_ang,surr_prob,acent,bcent,sconj,xfound,yfound)
if nargin<5, angle=0; end
if nargin<6, clen=gridsize(2); end
if nargin<7, contrast=[0.5,0.5]; end
if nargin<8, backgnd=0.5; end
if nargin<9, jitter_pos=0; end
if nargin<10, jitter_ang=0; end
if nargin<11, surr_prob=1; end

bar=define_bar(len,wid);
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
	if a==acent && b>=bcent-clen && b<=bcent+clen
	  I=draw_bar(I,xval,yval,bar,angleval,contrast(1),backgnd);
	else
	  I=draw_bar(I,xval,yval,bar,rand*180,contrast(2),backgnd);
	end
	if a==acent && b==bcent
	  xcent=xval;
	  ycent=yval;
	end
  end
end
