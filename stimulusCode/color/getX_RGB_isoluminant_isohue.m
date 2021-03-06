function [ X_RGB, theta , Sdiff ] = getX_RGB_isoluminant_isohue( B_RGB, T_RGB, contrast )
    colorspace='hsl'; %can be calculated either hsv or hsl

    if strcmp(colorspace,'hsl')
        B_HSL=rgb2hsl(B_RGB);
        T_HSL=rgb2hsl(T_RGB);

        [X_HSL, theta, Sdiff]=getX_HSL_HSV_isoluminant_isohue(B_HSL,T_HSL,contrast');

        X_RGB=hsl2rgb(X_HSL)';
    else
        B_HSV=rgb2hsv(B_RGB');
        T_HSV=rgb2hsv(T_RGB');

        [X_HSV, theta, Sdiff]=getX_HSL_HSV_isoluminant_isohue(B_HSV,T_HSV,contrast');

        X_RGB=hsv2rgb(X_HSV)';
    end

end


