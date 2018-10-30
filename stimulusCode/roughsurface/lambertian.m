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