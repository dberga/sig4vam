function [ I ] = define_rectangle( len,wid )

maxlen=odd(len,1);
maxwid=odd(wid,1);

res=[1024 1024];
bindex=0.10;
boundary=[bindex 1-bindex];
x=round([res(1)*boundary(1) res(1)*boundary(2) res(1)*boundary(2) res(1)*boundary(1)]);
y=round([res(2)*boundary(1) res(2)*boundary(1) res(2)*boundary(2) res(2)*boundary(2)]);
Irec=poly2mask(x,y,res(1),res(2));


I=imresize(Irec,[max(maxlen,maxwid)+2 max(maxlen,maxwid)+2],'nearest');

end

