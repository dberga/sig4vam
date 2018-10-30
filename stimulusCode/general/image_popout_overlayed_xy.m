function [I,xcent,ycent,xfound,yfound]=image_popout_overlayed_xy(gridsize,len,wid,spacing,angle,contrast,backgnd,jitter_pos,jitter_ang,acent,bcent,sconj,xfound,yfound)
%draw uniform texture with a single element at a different orientation,
%overlayed with a second texture in which elements can have alternating
%orientation
if nargin<6, contrast=0.5*ones(size(angle)); end
if nargin<7, backgnd=0.5; end
if nargin<8, jitter_pos=0; end
if nargin<9, jitter_ang=0; end

bar=define_bar(len,wid);
[I,~,xlocations,ylocations]=define_blank_image(gridsize,len,spacing,backgnd);
imsize=[1 1 size(I,1) size(I,2)];

if nargin<10, acent=ceil(length(xlocations)/2); bcent=ceil(length(ylocations)/2); end
if nargin<11, bcent=ceil(length(ylocations)/2); end
if nargin<12, sconj=getsconj( gridsize, surr_prob ); end
if nargin<13, [ xfound,yfound ] = getjitterpos( imsize, hlen, xlocations, ylocations, jitter_pos, acent,bcent,surr_prob,sconj); end

hlen=fix((size(bar,1))/2); 

coo=0;
a=0;
for x=xlocations
  a=a+1;
  b=0;
  if sconj(a,b)<=surr_prob || (a==acent && b==bcent)
        coo=coo+1;
        xval=xfound(coo);
        yval=yfound(coo);
    end
	angleval=angle+(2*jitter_ang*rand)-jitter_ang;
	if a==acent && b==bcent
	  I=draw_bar(I,xval,yval,bar,angleval(1),contrast(1),backgnd);
	  xcent=xval;
	  ycent=yval;
	else
	  I=draw_bar(I,xval,yval,bar,angleval(2),contrast(2),backgnd);	  
	end
	if rem(a,2)==rem(b,2)
	  I=draw_bar(I,xval,yval,bar,angleval(3),contrast(3),backgnd);
	else 	  
	  I=draw_bar(I,xval,yval,bar,angleval(4),contrast(4),backgnd);	  
	end
  end
end
