function [ I ] = define_toroid( len,wid )

maxlen=odd(len,1);
maxwid=odd(wid,1);

res=[1024 1024]; %resolution
bindex=0.1;
boundary=[bindex 1-bindex];
radius=0.5*((boundary(2)*res(1))-(boundary(1)*res(1)));
radius2=radius*0.7;
t=linspace(0, 2*pi, res(1));

%outer circle
x=round(radius*cos(t))+res(1)*boundary(1)+radius;
y=round(radius*sin(t))+res(1)*boundary(1)+radius;
Irec=poly2mask(x,y,res(1),res(2));

%inner circle
x2=round(radius2*cos(t))+res(1)*boundary(1)+radius;
y2=round(radius2*sin(t))+res(1)*boundary(1)+radius;
Irec2=poly2mask(x2,y2,res(1),res(2));

Irec=Irec-Irec2;

I=imresize(Irec,[max(maxlen,maxwid)+2 max(maxlen,maxwid)+2],'nearest');

end

