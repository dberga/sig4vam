function [I,xcent,ycent]=image_roughness_xy(gridsize,len,wid,spacing,angle,beta,RMS,acent,bcent)
if nargin<6, beta = 1.6; end
if nargin<7, RMS = 1.1; end


bar=define_bar(len,wid);
[I,~,xlocations,ylocations]=define_blank_image(gridsize,len,spacing,0);
hlen=fix((size(bar,1))/2);
bar=imrotate(bar,angle,'bilinear','crop'); 

 if nargin<8, acent=ceil(length(xlocations)/2); bcent=ceil(length(ylocations)/2); end
 if nargin<9, bcent=ceil(length(ylocations)/2); end

N = max(size(I));

a=0;
for x=xlocations
  a=a+1;
  b=0;
  for y=ylocations
    b=b+1;
    if a==acent && b==bcent
      %I=draw_bar(I,x,y,bar,angle(1),contrast(1),backgnd);
      xcent=x;
      ycent=y;
    end
  end
end


seed = 0;
rand('state',seed);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Defect Properties
% a, b, c define the size of the ellipsoid used to generate the indent
% vol defines how large the indent should be.
% x,y specify the indent's location
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a = 10; b = 10; c = 2;
%a = 20; b = 5; c = 2;
%  vol = 50;
a=10; b=10; c=2;
vol=50;
D = GenerateEllipsoidDefect(a, b, c); %this ellipsoid has aprox. double spacing as original (half size)
D=imresize(D,[spacing spacing]);
% r = ceil(200.*rand(1,2))-100;
% x = 256-r(1); y = 256-r(2);
        

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Illumination Properties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
slant = 60; tilt = 90;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create texture, add indent, then render
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x=xcent;
y=ycent;

T = GenerateFractalHeightMap(N, beta, RMS, seed);
[T mask] = AddDefect2Surface(T, D, vol, x, y, c);
R = lambertian(T, slant, tilt, N);
R = (R>0).*R;

%R=imresize(R,size(I));
%mask=imresize(mask,size(I));
I=R(1:size(I,1),1:size(I,2));
	
end



