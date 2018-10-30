function I=define_anyshape(len,wid,Ishape);
maxlen=odd(len,1);
maxwid=odd(wid,1);
M=max(odd(maxlen),odd(maxwid))+2;
N=max(odd(maxlen),odd(maxwid))+2;

I=imresize(Ishape,[M N]);

