function GenerateTextureWithIndent


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A. Clarke & M. Chantler &  K.Emrith
% Texture Lab
% School of Mathematics and Computer Science
% Heriot-Watt University
% Edinburgh
% Scotland
% 2008
% http://www.macs.hw.ac.uk/texturelab
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Function to create a 1/f^beta, random phase surface texture with a small
% indent.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Surface Properties
% N defines the size of hte output texture
% beta defines the magnitude spectra frequency fall-off
% RMS defines the required RMS-roughness
% seed is used to control the random number generator
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = 512;
beta = 1.6;
RMS = 0.9;
seed = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Defect Properties
% a, b, c define the size of the ellipsoid used to generate the indent
% vol defines how large the indent should be.
% x,y specify the indent's location
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = 10; b = 10; c = 2;
%a = 20; b = 5; c = 2;
vol = 50;
x = 256; y = 256;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Illumination Properties
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
slant = 60; tilt = 90;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create texture, add indent, then render
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = GenerateFractalHeightMap(N, beta, RMS, seed);
D = GenerateEllipsoidDefect(a, b, c);
T = AddDefect2Surface(T, D, vol, x, y, c);
R = lambertian(T, slant, tilt, N);
R = (R>0).*R;
imwrite(R, 'output.png');
end


function ht = GenerateFractalHeightMap(n, beta, RMS, seed)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to generate a fractal surface of n x n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rand('state',seed);
nq=n/2;
V=-repmat((-nq:nq-1)', 1,2*nq);
U=repmat((-nq:nq-1), 2*nq,1);
f=sqrt(U.*U+V.*V);
theta=rand(n,n)*2*pi; % Generate random phase
mag=power(f,-beta); % Generate magnitude
mag=ifftshift(mag);  mag(1,1)=0; %shift & zero d.c.
[x,y]=pol2cart(theta,mag); F=x+i*y; %convert to cartesian
ht=ifft2(F, 'symmetric');
% adjust so mean is 0
ht = ht - mean(ht(:));
% set RMS to desired value
ht = ht./RMSroughness(double(ht));
ht = RMS.*ht;
end

function D = GenerateEllipsoidDefect(a,b,c)
a2 = a.*a; b2 = b.*b; c2 = c.*c;
for row=-2*a:2*a
    row_e=row+2*a+1;
    for col=-2*b:2*b
        col_e=col+2*b+1;
        x_dash=row;
        y_dash=col;
        sqr=c2*(1-(x_dash*x_dash/a2+y_dash*y_dash/b2));
        if sqr>0
            D(row_e, col_e)=sqrt(sqr);
        else
            D(row_e, col_e)=0;
        end
    end
end
B= [0 1 0; 1 2 1; 0 1 0];
D = filter2(B, D)./6;
end

function Td = AddDefect2Surface(T, D, V, x, y, c)
step = 0.1;
n = size(D);
Td = T;
localmaxheight = max(max(T(x:x+n(1), y:y+n(2))));
height = c+localmaxheight;
D = height - D;
vol = 0;
while vol<V
    % add defect to texture
    for i = 1:n(1)
        for j = 1:n(2)
            if D(i,j) ~= D(1,1)
                Td(i+x-floor(n(1)/2), j+y-floor(n(2)/2)) = min(Td(i+x-floor(n(1)/2), j+y-floor(n(2)/2)), D(i,j));
            end
        end
    end
    % check difference
    vol = sum(sum(T - Td));
    D = D - step;
end
end


function Out = lambertian(In, slant, tilt, n)
%In is the input matrix to be rendered
%s denotes the slant 
%t denotes the tilt
%Author: K.Emrith
%Texture Lab - Heriot Watt University
%Date: 22/10/2004
%ver:1.0

%transform the angle in radians
deg2rad = pi/180;
%convert slant
slant = slant*deg2rad;
%convert tilt
tilt = tilt*deg2rad;

%Assume incident light strength be gStren
gStren =1; %500.0;%
%Assume albedo of surface to be ro
ro = 0.8; %      1000.0;%
In1 = [In(2:n,:); In(1,:)];
dy = In1-In;
In1 = [In(:,2:n) In(:,1)];
dx = In1-In;
% dy=diff(In,1,1); dy=dy(:,1:end-1);
% dx=diff(In,1,2); dx=dx(1:end-1,:);
L = [-cos(tilt)*sin(slant)  -sin(tilt)*sin(slant)   cos(slant)]'; 

Out= cos(tilt)*sin(slant)*dx + sin(tilt)*sin(slant)*dy + cos(slant);
Out=Out./sqrt((1+dx.^2+dy.^2));
Out = Out.*gStren*ro;
end

function  Sq  = RMSroughness(T)

T = T -mean(T(:));
n=size(T(:),1);
T = T.^2;
Sq = sqrt(sum(sum(T))./n);
end