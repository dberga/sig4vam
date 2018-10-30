function I=draw_bar(I,x,y,bar,angle,contrast,backgnd)
%if nargin<6, contrast=1; end
%if nargin<7, backgnd=0.5; end

%norm=sum(sum(bar));
bar=imrotate(bar,angle,'bilinear','crop'); 
%bar=bar.*(norm./sum(sum(bar)));
bar=(bar.*contrast)+backgnd;
len=size(bar,1);
hlen=fix((len-1)/2);
if contrast>=0;
  I(x-hlen:x+hlen,y-hlen:y+hlen)=max(I(x-hlen:x+hlen,y-hlen:y+hlen),bar);
else
  I(x-hlen:x+hlen,y-hlen:y+hlen)=min(I(x-hlen:x+hlen,y-hlen:y+hlen),bar);
end