function [ X_HSL, theta, Ldiff ] = getX_HSL_HSV_achromatic( B_HSL, T_HSL, contrast )

    
    theta=0;
    
    if T_HSL(3)>B_HSL(3)
        Ldiff=abs(T_HSL(3)-B_HSL(3))*(1-contrast);
        X_L=T_HSL(3)-Ldiff;
    else
        Ldiff=abs(T_HSL(3)-B_HSL(3))*contrast;
        X_L=B_HSL(3)-Ldiff;
    end
    
    X_HSL=[0 0 X_L];
end

