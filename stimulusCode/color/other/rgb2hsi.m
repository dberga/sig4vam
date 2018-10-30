function [ hsi ] = rgb2hsi( rgb )
 
R=rgb(1);
G=rgb(2);
B=rgb(3);

%Hue
numi=1/2*((R-G)+(R-B));
denom=((R-G).^2+((R-B).*(G-B))).^0.5;

%To avoid divide by zero exception add a small number in the denominator
H=acosd(numi./(denom+0.000001));

%If B>G then H= 360-Theta
H(B>G)=360-H(B>G);

%Normalize to the range [0 1]
H=H/360;

%Saturation
S=1- (3./(sum(rgb)+0.000001)).*min(rgb);


%Intensity
I=sum(rgb)./3;


%HSI
hsi(1)=H;
hsi(2)=S;
hsi(3)=I;

end

