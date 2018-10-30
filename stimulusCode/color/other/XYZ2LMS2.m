function [ LMS ] = XYZ2LMS( XYZ )

%MCLEOD&BOYNTON
fmatrix=...
    [0.15516, 0.54307, -0.03287;...
    -0.15516, 0.45692, 0.03287;...
    0, 0, 0.059];

LMS=XYZ*fmatrix;

end

