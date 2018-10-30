function [ outfig ] = plot_BTD_lsY( background_hsl,target_hsl,distractor_hsl , color_str)
    if nargin < 4, color_str={'black','red','red'}; end
    
    xLabel={'Saturation'};
    yLabel={'Lightness'};
    symbols={'d','s','o'};
    plotparams=color_str;
    Legend={'Background','Target','Distractors'};
    
    close all
    hold on
    
    outfig(1)=plot_hsl(background_hsl(:,2),background_hsl(:,3),symbols{1},xLabel,yLabel,Legend,{},plotparams{1});
    outfig(2)=plot_hsl(target_hsl(:,2),target_hsl(:,3),symbols{2},xLabel,yLabel,Legend,{},plotparams{2});
    outfig(3)=plot_hsl(distractor_hsl(:,2),distractor_hsl(:,3),symbols{3},xLabel,yLabel,Legend,{},plotparams{3});
    outfig(3).Parent.XAxis.TickValues=round(distractor_hsl(:,2),3);
    legend(Legend);
    hold off
        
end

