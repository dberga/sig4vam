function bar=define_bar(len,wid);
%draw a bar with maximum intensity=1 against a background with intensity=0.

maxlen=odd(len,1);
minlen=odd(len,0);
maxwid=odd(wid,1);
minwid=odd(wid,0);

bar=zeros(max(maxlen,maxwid)+2);
cent=ceil((max(maxlen,maxwid)+2)/2);

lenval=(len-max(0,minlen));
if minlen>=1; lenval=lenval/2; end
widval=(wid-max(0,minwid));
if minwid>=1; widval=widval/2; end

hlen=floor(maxlen/2);
hwid=floor(maxwid/2);
bar(cent-hwid:cent+hwid,cent-hlen:cent+hlen)=lenval*widval;

hlen=floor(maxlen/2);
hwid=floor(minwid/2);
bar(cent-hwid:cent+hwid,cent-hlen:cent+hlen)=lenval;

hlen=floor(minlen/2);
hwid=floor(maxwid/2);
bar(cent-hwid:cent+hwid,cent-hlen:cent+hlen)=widval;

hlen=floor(minlen/2);
hwid=floor(minwid/2);
bar(cent-hwid:cent+hwid,cent-hlen:cent+hlen)=1;

