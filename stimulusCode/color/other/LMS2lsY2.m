function [ lsY ] = LMS2lsY( LMS )

L=LMS(1);
M=LMS(2);
S=LMS(3);

l=L/(L+M);
s=S/(L+M);
Y=L+M;

lsY=[l,s,Y];

end

