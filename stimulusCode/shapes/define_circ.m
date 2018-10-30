function [ I ] = define_circ( len,wid )

maxlen=odd(len,1);
maxwid=odd(wid,1);

res=[1024 1024]; %resolution
bindex=0.10;
boundary=[bindex 1-bindex];
radius=0.5*((boundary(2)*res(1))-(boundary(1)*res(1)));
t=linspace(0, 2*pi, res(1));
x=round(radius*cos(t))+res(1)*boundary(1)+radius;
y=round(radius*sin(t))+res(1)*boundary(1)+radius;
Irec=poly2mask(x,y,res(1),res(2));


I=imresize(Irec,[max(maxlen,maxwid)+2 max(maxlen,maxwid)+2],'nearest');

end

