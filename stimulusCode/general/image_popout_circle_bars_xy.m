function [I,xcent,ycent,xfound,yfound]=image_popout_circle_bars_xy(gridsize,len,wid,spacing,angle,contrast,backgnd,jitter_pos,jitter_ang,surr_prob,cent_gap,acent,bcent,sconj,xfound,yfound)
%draw a uniform texture with a single element at a different orientation
%and/or contrast
if nargin<6, contrast=0.5*ones(size(angle)); end
if nargin<7, backgnd=0.5; end
if nargin<8, jitter_pos=0; end
if nargin<9, jitter_ang=0; end
if nargin<10, surr_prob=1; end
if nargin<11, cent_gap=1; end

[I,~,xlocations,ylocations]=define_blank_image(gridsize,len,spacing,backgnd);
circle=define_toroid(len*2/3,wid);
bar=define_bar(len*2/3,wid);
blank=define_bar(len,wid).*0;
[a,b]=size(blank);
diam=size(circle,1);
circ_bar=draw_bar(blank,ceil(a/2),fix((diam+1)/2),circle,0,1,0);
circ_bar=draw_bar(circ_bar,ceil(a/2),floor(2*b/3)-(floor(2*b/3)*0.05),bar,0,1,0);
circle=draw_bar(blank,ceil(a/2),fix((diam+1)/2)+1,circle,0,1,0);
hlen=fix((size(circle,1))/2); 
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
	  if cent_gap
		  I=draw_bar(I,xval,yval,circ_bar,angleval(1),contrast(1),backgnd);
		else
		  I=draw_bar(I,xval,yval,circle,angleval(1),contrast(1),backgnd);
	  end
	  xcent=xval;
	  ycent=yval;
	else
	  if sconj(a,b)<=surr_prob
		if cent_gap		
		  I=draw_bar(I,xval,yval,circle,angleval(2),contrast(2),backgnd);
		else
		  I=draw_bar(I,xval,yval,circ_bar,angleval(2),contrast(2),backgnd);
		end
	  end
	end
  end
end
