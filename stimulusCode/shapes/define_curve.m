function I=define_curve(len,wid,curve);
maxdiam=odd(len,1);
offset=(curve-len)/2;
[x y]=meshgrid(offset-1:maxdiam+offset,fix(-maxdiam/2)-1:fix(maxdiam/2)+1);
radius=sqrt(x.^2+y.^2);

I=exp((-(radius-(curve/2)).^2)./(0.5*wid.^2));

maxlen=odd(len,1);
minlen=odd(len,0);
cent=ceil((maxlen+2)/2);
valid=zeros(size(I));
lenval=(len-max(0,minlen));
if minlen>=1; lenval=lenval/2; end

hlen=floor(maxlen/2);
valid(cent-hlen:cent+hlen,cent-hlen:cent+hlen)=lenval;
hlen=floor(minlen/2);
valid(cent-hlen:cent+hlen,cent-hlen:cent+hlen)=1;
I=I.*valid;