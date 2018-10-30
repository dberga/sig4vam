function [ xfound,yfound,xfoundinside,yfoundinside ] = getjitterpos_grouping( imsize, hlen, xlocations, ylocations, jitter_pos, acent,bcent,surr_prob,sconj,maxdist)
    xfound=[];
    yfound=[];
    xfoundinside=[];
    yfoundinside=[];
    xmin=imsize(1); xmax=imsize(3);
    ymin=imsize(2); ymax=imsize(4);
    hdist=(hlen*2)+jitter_pos(1); %calcular limite
    a=0;
    for x=xlocations
        a=a+1;
        b=0;
        for y=ylocations
            b=b+1;
            
            if pdist2([x y],[xlocations(acent) ylocations(bcent)]) <= maxdist(1)
            %inside of group
            if sconj(a,b)<=surr_prob(end)
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
                        cond(3)=pdist2([xval yval],[xlocations(acent) ylocations(bcent)]) <= maxdist(1);

                        for s=1:numel(xfound)
                            xin=(xval>=xfound(s)-hdist && xval<=xfound(s)+hdist);
                            yin=(yval>=yfound(s)-hdist && yval<=yfound(s)+hdist);
                            cond(3+s)=~( xin && yin );
                        end
                        foundpos=cond(:);
                    end
                    xfound=[xfound, xval];
                    yfound=[yfound, yval];
                    xfoundinside=[xfoundinside,xval];
                    yfoundinside=[yfoundinside,yval];
                    
                else
                    xval=x;
                    yval=y; 
                    xfound=[xfound, x];
                    yfound=[yfound, y];
%                     xfoundinside=[xfoundinside,xval];
%                     yfoundinside=[yfoundinside,yval];
               end
                end
            else
                %outside of group
                if sconj(a,b)<=surr_prob(1)
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
                            cond(3)=pdist2([xval yval],[xlocations(acent) ylocations(bcent)]) >= maxdist(2);
                            
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

