function ht = GenerateFractalHeightMap(n, beta, RMS, seed)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function to generate a fractal surface of n x n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%rand('state',seed);
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