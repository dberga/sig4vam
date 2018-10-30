function [ outfig ] = plot_BTD( background_rgb,target_rgb,distractor_rgb , color_cond, colorspace)
if nargin < 5, colorspace='hsl'; end
if nargin < 4, color_cond='rT-wB'; end

    
    target_hsl=rgb2hsl(target_rgb)';
    background_hsl=rgb2hsl(background_rgb)';
    distractor_hsl=rgb2hsl(distractor_rgb);
    
    target_lsY=XYZ2lsY(sRGB2XYZ(target_rgb',true,[],2.2),'macleod-boynton1979');
    background_lsY=XYZ2lsY(sRGB2XYZ(background_rgb',true,[],2.2),'macleod-boynton1979');
    distractor_lsY=XYZ2lsY(sRGB2XYZ(distractor_rgb,true,[],2.2),'macleod-boynton1979');
    
    
    switch color_cond
       case 'rT-wB'
            color_str={'black','red','red'};
       case 'bT-wB'
            color_str={'black','blue','blue'};
       case 'rT-rrB'
            color_str={'red','red','red'};
       case 'bT-rrB'
            color_str={'red','blue','blue'};
    end
                
    
    switch colorspace
        case 'lsY'
            plot_BTD_lsY( background_lsY,target_lsY,distractor_lsY , color_str);
        case 'hsl'
            plot_BTD_hsl( background_hsl,target_hsl,distractor_hsl , color_str);
        case 'hsl&lsY'
            plot_BTD_hsl( background_hsl,target_hsl,distractor_hsl , color_str);
            
            switch color_str{3}
                case 'red'
                    %add l axis from lsY
                    add_axis(distractor_lsY(:,1), 'L Chromaticity, L/(L+M)');
                case 'blue'
                    %add s axis from lsY
                    add_axis(distractor_lsY(:,2), 'S Chromaticity, S/(L+M)');
            end
    end
    set(gcf,'units','points','position',[10,10,400,400]);
    
        
end

