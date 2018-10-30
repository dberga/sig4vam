function [ xfound,yfound ] = getjitterpos( imsize, hlen, xlocations, ylocations, jitter_pos, acent,bcent,surr_prob,sconj)
    xfound=[];
    yfound=[];
    xmin=imsize(1); xmax=imsize(3);
    ymin=imsize(2); ymax=imsize(4);
    hdist=(hlen*2)+jitter_pos(1);
    cdist=(hlen*2)+jitter_pos(end);
    xcent=xlocations(acent);
    ycent=ylocations(bcent);
    a=0;
    for x=xlocations
        a=a+1;
        b=0;
        for y=ylocations
            b=b+1;
            if a==acent && b==bcent
                if jitter_pos(end)
                    xval=0; 
                    yval=0; 
                    foundpos=0;
                    while (min(foundpos)==0) 
                        xval=fix(xmin+(xmax-xmin)*rand); 
                        yval=fix(ymin+(ymax-ymin)*rand);

                        cond=0;
                        cond(1)=~((xval-hlen)<xmin+1 || xval+hlen>xmax);
                        cond(2)=~((yval-hlen)<ymin+1 || yval+hlen>ymax);
                        cond(3)=1;
                        
                        for s=1:numel(xfound)
                            xin=(xval>=xfound(s)-cdist && xval<=xfound(s)+cdist);
                            yin=(yval>=yfound(s)-cdist && yval<=yfound(s)+cdist);
                            cond(3+s)=~( xin && yin );
                        end
                        foundpos=cond(:);
                    end
                    xcent=xval;
                    ycent=yval;
                    xfound=[xfound, xval];
                    yfound=[yfound, yval];
                else
                    xval=x;
                    yval=y; 
                    xfound=[xfound, x];
                    yfound=[yfound, y];
                    
                end
            else
                if sconj(a,b)<=surr_prob
                    if jitter_pos(1)
                        xval=0; 
                        yval=0; 
                        foundpos=0;
                        while (min(foundpos)==0) 
                            xval=fix(xmin+(xmax-xmin)*rand); 
                            yval=fix(ymin+(ymax-ymin)*rand);

                            cond=0;
                            cond(1)=~((xval-hlen)<xmin+1 || xval+hlen>xmax);
                            cond(2)=~((yval-hlen)<ymin+1 || yval+hlen>ymax);

                            xin=(xval>=xcent-cdist && xval<=xcent+cdist);
                            yin=(yval>=ycent-cdist && yval<=ycent+cdist);
                            cond(3)=~( xin && yin );

                            for s=1:numel(xfound)
                                xin=(xval>=xfound(s)-hdist && xval<=xfound(s)+hdist);
                                yin=(yval>=yfound(s)-hdist && yval<=yfound(s)+hdist);
                                cond(3+s)=~( xin && yin );

                            end
                            foundpos=cond(:);
                        end
                        xfound=[xfound, xval];
                        yfound=[yfound, yval];

                    else
                        xval=x;
                        yval=y; 
                        xfound=[xfound, x];
                        yfound=[yfound, y];
                    end
                end
            end
            
        end
    end
end

