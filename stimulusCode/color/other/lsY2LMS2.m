function [ LMS ] = lsY2LMS( lsY )
    
    l=lsY(1);
    s=lsY(2);
    Y=lsY(3);
    
    S=s*Y;
    L=l*Y;
    M=Y-l*Y;
    
    LMS=[L,M,S];

end

