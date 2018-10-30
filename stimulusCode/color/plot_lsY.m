function [ outfig ] = plot_lsY(  l,s,symbol,xLabel,yLabel,Legend,Title,plotparams )
    if nargin < 8, plotparams='filled'; end
    if nargin < 7, Title={}; end
    if nargin < 6, Legend={}; end
    if nargin < 5, xLabel={'L Chromaticity, L/(L+M)'}; end
    if nargin < 4, yLabel={'S Chromaticity, S/(L+M)'}; end
    if nargin < 3, symbol='o'; end
   
    sz=100;
    gammavalue=2.2;
    blackpoint_lsY=XYZ2lsY(sRGB2XYZ([0 0 0],true,[],gammavalue),'macleod-boynton1979');
    whitepoint_lsY=XYZ2lsY(sRGB2XYZ([1 1 1],true,[],gammavalue),'macleod-boynton1979');
    
    
    outfig=scatter(l',s',sz,symbol,plotparams);
    
    xlabel(xLabel);
    ylabel(yLabel);
    
%     xlim(limits_l);
%     ylim(limits_s);
    
end

