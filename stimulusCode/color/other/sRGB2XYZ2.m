function [ XYZ ] = sRGB2XYZ2( sRGB )

%D65
tmatrix=...
 [3.2404542 -1.5371385 -0.4985314
-0.9692660  1.8760108  0.0415560
 0.0556434 -0.2040259  1.0572252];
 

XYZ=sRGB*inv(tmatrix);


end

