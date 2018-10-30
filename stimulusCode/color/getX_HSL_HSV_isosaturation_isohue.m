function [ X_HSL, theta, Ldiff ] = getX_HSL_HSV_isosaturation_isohue( B_HSL, T_HSL, contrast )
    
    X_H=repmat(T_HSL(1),numel(contrast),1);
    X_S=repmat(T_HSL(2),numel(contrast),1);
    
    alpha=atand(T_HSL(2)./T_HSL(3)); if isnan(alpha), alpha=0, end;
    beta=(90-alpha)*(1-contrast);
    theta=(90-alpha)*(contrast);
    
    %lightness diff between distractor and background
    Ldiff=(X_S./tand(beta)); 
    
    if T_HSL(3)>B_HSL(3)
        X_L=T_HSL(3)-Ldiff;
    else
        X_L=B_HSL(3)-Ldiff;
    end
    
    X_HSL=[X_H,X_S,X_L];

end


