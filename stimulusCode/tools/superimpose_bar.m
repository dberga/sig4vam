function [ bar ] = superimpose_bar( bar, background_cropped )
threshold_png=0.01;
bar(bar<=threshold_png)=background_cropped(bar<=threshold_png);


end

