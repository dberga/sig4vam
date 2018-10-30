function [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,which)
if which==1
  barlen=(1.2*imsizefac);
  barwid=(0.12*imsizefac);
  spacing=round(1.6*imsizefac);
else
  barlen=(1.5*imsizefac);
  barwid=(0.15*imsizefac);
  spacing=round(2.5*imsizefac);
end
%Odd grid size appropriate for feature search. 
%For texture segmentation subtract 1 to get even grid size.
