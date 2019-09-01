function [ bar ] = superimpose_bar( bar, background_cropped )

%change the threshold depending on image, default is 0.01
threshold_png=0.01;

try
bar(bar<=threshold_png)=background_cropped(bar<=threshold_png);
catch
   disp('superimpose error'); 
end

end

