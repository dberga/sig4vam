function [ outfig ] = plot_BTD_lsY( background_lsY,target_lsY,distractor_lsY , color_str)
    if nargin < 4, color_str={'black','red','red'}; end
    
    xLabel={'L Chromaticity, L/(L+M)'};
    yLabel={'S Chromaticity, S/(L+M)'};
    symbols={'d','s','o'};
    plotparams=color_str;
    Legend={'Background','Target','Distractors'};
    
    close all
    hold on
    
    outfig(1)=plot_lsY(background_lsY(:,1),background_lsY(:,2),symbols{1},xLabel,yLabel,Legend,{},plotparams{1});
    outfig(2)=plot_lsY(target_lsY(:,1),target_lsY(:,2),symbols{2},xLabel,yLabel,Legend,{},plotparams{2});
    outfig(3)=plot_lsY(distractor_lsY(:,1),distractor_lsY(:,2),symbols{3},xLabel,yLabel,Legend,{},plotparams{3});
    
    outfig(3).Parent.XAxis.TickValues=round(distractor_lsY(:,1),3);
    outfig(3).Parent.YAxis.TickValues=round(distractor_lsY(:,2),3);
    
    legend(Legend);
    
    hold off
        
end

