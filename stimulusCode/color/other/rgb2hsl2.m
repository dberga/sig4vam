function [hsl]=rgb2hsl(rgb)


R=rgb(1);
G=rgb(2);
B=rgb(3);

Cmax = max(rgb);
Cmin = min(rgb);
Cdiff = Cmax - Cmin;



%Light calculation
L=(Cmax+Cmin)/2;


%saturation calculation
if Cdiff==0
	S=0;
else
	S=Cdiff/(1-abs(2*L-1));
end

%hue calculation
if Cdiff==0
	H=0;
else
	switch (Cmax)
		case R
			H=60*((G-B)/Cdiff);
		case G
			H=60*(((B-R)/Cdiff)+2);
		case B
			H=60*(((R-G)/Cdiff)+4);
    end
end


hsl=[H, S, L];
 

end

