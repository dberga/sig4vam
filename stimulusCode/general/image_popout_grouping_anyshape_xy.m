function [I,xcent,ycent,xfound,yfound]=image_popout_grouping_anyshape_xy(gridsize,len,wid,spacing,angle,contrast,backgnd,jitter_pos,jitter_ang,surr_prob,dist_factor,shape,acent,bcent,sconj,xfound,yfound)
%draw a uniform texture with a single element at a different orientation
%and/or contrast
if nargin<6, contrast=0.5*ones(size(angle)); end
if nargin<7, backgnd=0.5; end
if nargin<8, jitter_pos=0; end
if nargin<9, jitter_ang=0; end
if nargin<10, surr_prob=[0.5 0.5]; end
if nargin<11, dist_factor=[2 2]; end
if nargin<12, shape={define_bar(len,wid)}; end

bar=define_anyshape(len,wid,shape);
[I,~,xlocations,ylocations]=define_blank_image(gridsize,len,spacing,backgnd);
hlen=fix((size(bar,1))/2); 
imsize=[1 1 size(I,1) size(I,2)];
maxdist=[dist_factor(1)*spacing (dist_factor(2))*spacing];

if nargin<13, acent=ceil(length(xlocations)/2); bcent=ceil(length(ylocations)/2); end
if nargin<14, bcent=ceil(length(ylocations)/2); end
if nargin<15, sconj=getsconj( gridsize, surr_prob(1) ); end
if nargin<16, [ xfound,yfound ] = getjitterpos( imsize, hlen, xlocations, ylocations, jitter_pos, acent,bcent,surr_prob,sconj,maxdist); end




coo=0;
a=0;
for x=xlocations
  a=a+1;
  b=0;
  for y=ylocations
    b=b+1;
    
    angleval=angle+(2*jitter_ang*rand)-jitter_ang;
    if pdist2([x y],[xlocations(acent) ylocations(bcent)]) <= maxdist(1)
        if sconj(a,b)<=surr_prob(end)
            coo=coo+1;
            xval=xfound(coo);
            yval=yfound(coo);
        end
         if sconj(a,b)<=surr_prob(end)
           I=draw_bar(I,xval,yval,bar,angleval(1),contrast(1),backgnd);
         end
         
         xcent=xlocations(acent);
         ycent=ylocations(bcent);
    else
        if sconj(a,b)<=surr_prob(1)
            coo=coo+1;
            xval=xfound(coo);
            yval=yfound(coo);
        end
          if sconj(a,b)<=surr_prob(1)
           I=draw_bar(I,xval,yval,bar,angleval(2),contrast(2),backgnd);
          end
    end

  end
    
end
  


end
