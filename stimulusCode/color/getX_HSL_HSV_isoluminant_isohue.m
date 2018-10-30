function [ X_HSL, theta , Sdiff] = getX_HSL_HSV_isoluminant_isohue( B_HSL, T_HSL, contrast )
    
    X_H=repmat(T_HSL(1),numel(contrast),1);
    X_L=repmat(T_HSL(3),numel(contrast),1);
    
    
    alpha=atand(T_HSL(3)./T_HSL(2)); if isnan(alpha), alpha=0, end;
    beta=(90-alpha)*(1-contrast);
    theta=(90-alpha)*(contrast);
    
    %Sdiff(B,X)=set for 0 or 1
    Sdiff=X_L.*tand(beta); %Sdiff(D,T)=abs(0-Sdiff(B,X))
    
    
    
    if T_HSL(2)>B_HSL(2)
        X_S=T_HSL(2)-Sdiff;
    else
        X_S=B_HSL(2)-Sdiff;
    end
    
    X_HSL=[X_H,X_S,X_L];
    


end














