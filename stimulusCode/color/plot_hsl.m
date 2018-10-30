function [ outfig ] = plot_ls(  l,s,symbol,xLabel,yLabel,Legend,Title,plotparams )
    if nargin < 8, plotparams='filled'; end
    if nargin < 7, Title={}; end
    if nargin < 6, Legend={}; end
    if nargin < 5, xLabel={'Saturation'}; end
    if nargin < 4, yLabel={'Lightness'}; end
    if nargin < 3, symbol='o'; end
   
    sz=100;
    limits_l=[0,1];
    limits_s=[0,1];
    blackpoint_hsl=rgb2hsl([0 0 0]);
    whitepoint_hsl=rgb2hsl([1 1 1]);
    
    
    outfig=scatter(l',s',sz,symbol,plotparams);
    
    xlabel(xLabel);
    ylabel(yLabel);
    xlim(limits_s);
    ylim(limits_l);
    
    xticks(limits_s(1):(limits_s(2)-limits_s(1))/10:limits_s(2));
    
    xlim([limits_s(1)-0.1 limits_s(2)+0.1]);
    ylim([limits_l(1)-0.1 limits_l(2)+0.1]);
    
end

