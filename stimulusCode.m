function [ ] = stimulusCode( )


addpath(genpath('stimulusCode'));

%if exist('dataset_blocks','file'), rmdir('dataset_blocks','s'); end
%if exist('dataset','file'), rmdir('dataset','s'); end
mkdir('dataset_blocks');
mkdir('dataset');
mkdir('dataset/masks');
%mkdir('dataset/smaps');
mkdir('dataset/extra');


evaluation_list = {...
      'fview-cornerangle',...
      'fview-segmentation-orientation',...
      'fview-segmentation-spacing',...
      'fview-contourintegration'...
      'fview-perceptualgrouping',...
      'vsearch-efficiency-setsize',... 
      'vsearch-efficiency-scale',... 
      'vsearch-roughsurface',... 
      'vsearch-asymmetry-color',...
      'vsearch-asymmetry-brightness',...
      'vsearch-similarity-size',...
      'vsearch-similarity-orientation',...
      'vsearch-orientation-heterogeneity',...
      'vsearch-orientation-linearity',...
      'vsearch-orientation-categorical',...    
};



%% FREE VIEWING
% corner angle
fview_cornerangle(evaluation_list);
% %segmentation
fview_segmentation_orientation(evaluation_list);
fview_segmentation_spacing(evaluation_list);
%contour integration and proximity discrepancies in grouping
fview_perceptualgrouping(evaluation_list);
fview_contourintegration(evaluation_list);

%% VISUAL SEARCH
%efficiency (number of distractors, scale of distractors, surface/noise)
vsearch_efficiency_setsize(evaluation_list);
vsearch_efficiency_scale(evaluation_list);
vsearch_roughsurface(evaluation_list);
%similarity between target and distractors
vsearch_similarity_size(evaluation_list);
vsearch_similarity_orientation(evaluation_list);
%search asymmetries produced by distractor-target luminance/color
vsearch_asymmetry_brightness(evaluation_list);
vsearch_asymmetry_color(evaluation_list);
%search asymmetries produced by categorization, heterogeneity and linearity
vsearch_orientation_categorical(evaluation_list);
vsearch_orientation_heterogeneity(evaluation_list);
vsearch_orientation_linearity(evaluation_list);


end

