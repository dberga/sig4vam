function rgb=hsl2rgb(hsl)

H=hsl(1);
S=hsl(2);
L=hsl(3);

C=(1-abs(2*L-1))*S;
X=C*(1-abs((H/60)-1));
m=L-(C/2);

if H < 360 && H >= 300
	hR=C;
	hG=X;
	hB=0;
elseif H < 300 && H >= 240
	hR=X;
	hG=C;
	hB=0;
elseif H < 240 && H >= 180
	hR=0;
	hG=C;
	hB=X;
elseif H < 180 && H >= 120
	hR=0;
	hG=X;
	hB=C;
elseif H  < 120 && H >= 60
	hR=X;
	hG=0;
	hB=C;
elseif H < 60 && H >= 0
	hR=C;
	hG=0;
	hB=X;	
end

R=hR+m;
G=hG+m;
B=hB+m;

rgb=[R, G, B];

end

