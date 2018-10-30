function [Td mask]= AddDefect2Surface(T, D, V, x, y, c)

n = size(D);
%if stimulus has been rescaled, apply proportion to step and V
% step=0.1;
step = 0.1*(V/max(n)); 
V=V/(V/max(n));
 
Td = T;
mask=zeros(size(T));
 localmaxheight = max(max(T(x:x+n(1), y:y+n(2))));
%localmaxheight = max(max(T(x:x+floor(n(1)/2), y:y+floor(n(2)/2)))); %circle in middle of D
height = c+localmaxheight;
D = height - D;
vol = 0;
while vol<V
    % add defect to texture
    for i = 1:n(1)
        for j = 1:n(2)
            if D(i,j) ~= D(1,1)
                Td(i+x-floor(n(1)/2), j+y-floor(n(2)/2)) = min(Td(i+x-floor(n(1)/2), j+y-floor(n(2)/2)), D(i,j));
                mask(i+x-floor(n(1)/2), j+y-floor(n(2)/2)) = 255;
            end
        end
    end
    % check difference
    vol = sum(sum(T - Td));
    D = D - step;
end

end