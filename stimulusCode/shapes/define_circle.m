function I=define_circle(len,wid);
maxdiam=odd(len,1);
[x y]=meshgrid(-fix(maxdiam/2)-1:fix(maxdiam/2)+1,fix(-maxdiam/2)-1:fix(maxdiam/2)+1);
radius=sqrt(x.^2+y.^2);

I=exp((-(radius-(len/2)).^2)./(0.5*wid.^2));

