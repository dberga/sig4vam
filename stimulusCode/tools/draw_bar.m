function I=draw_bar(I,x,y,bar,angle,contrast,backgnd)
%if nargin<6, contrast=1; end
%if nargin<7, backgnd=0.5; end

%norm=sum(sum(bar));
bar=imrotate(bar,angle,'bilinear','crop'); 
%bar=bar.*(norm./sum(sum(bar)));


len=size(bar,1);
hlen=fix((len-1)/2);

if size(bar,3) ~= size(I,3) %size(bar,3)>1 && size(I,3)==1
    if size(bar,3)>size(I,3)
        bar=rgb2gray(bar);
    else
        bar(:,:,2)=bar(:,:,1);
        bar(:,:,3)=bar(:,:,1);
    end
end
        
if size(bar,3)==3 && size(I,3)==3 %numel(backgnd)>3 %real images
   
        
        
        I(x-hlen:x+hlen,y-hlen:y+hlen,:)=superimpose_bar(bar,I(x-hlen:x+hlen,y-hlen:y+hlen,:));
        
else %psychophysical images
    
    if contrast>0
        try
            bar=(bar.*contrast)+backgnd;
        catch
            bar=(bar.*contrast)+backgnd(1);
        end
    end
    
    if contrast>=0
        %   I(x-hlen:x+hlen,y-hlen:y+hlen)=max(I(x-hlen:x+hlen,y-hlen:y+hlen),bar);
          I(x-hlen:x+hlen,y-hlen:y+hlen)=max(I(x-hlen:x+hlen,y-hlen:y+hlen),bar);
        else
        %   I(x-hlen:x+hlen,y-hlen:y+hlen)=min(I(x-hlen:x+hlen,y-hlen:y+hlen),bar);
          I(x-hlen:x+hlen,y-hlen:y+hlen)=min(I(x-hlen:x+hlen,y-hlen:y+hlen),1-bar);
    end

end
    

    


    
    

end
