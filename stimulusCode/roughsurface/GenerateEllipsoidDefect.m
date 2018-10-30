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