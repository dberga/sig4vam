function Correction = gammacorrection(Image,GammaValue)
% 
%    Function to calculate the Gamma Correction for a particular image
%
% Author: Pranam Janney                           02/11/2003    14:30
% Email : pranamjanney@yahoo.com
%
%
% Usage:
% Correction = gammacorrection(InputImage,GammaValue)
% Outputs:
%         Correction = gamma correction for the input image
% Inputs:
%         Image = input image file
%         GammaValue= gamma correction factor, if not specified gamma = 1
% 

Err = 0;
if nargin < 2
    GammaValue = 1;
    disp('Default value for gamma = 1');
else if nargin ==2 & GammaValue < 0
    GammaValue = 1;
    disp('GammaValue < 0, Default value considered, Gammavalue = 1');
else if nargin > 2
    disp('Error : Too many input parameters');
    Err = 1;
end
if Err == 1 
x = imread(Image);
x = double(x);
Correction = 255 * (x/255).^ GammaValue;
end;
