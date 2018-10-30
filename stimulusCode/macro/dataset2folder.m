function [  ] = dataset2folder( dataset_path )

t=1;
%bloc1
tasks{t+1}='vsearch-efficiency-setsize';
tasks{t+2}='vsearch-efficiency-scale_circlebar-circle';
tasks{t+3}='vsearch-efficiency-scale_circle-circlebar';
%bloc2
tasks{t+4}='fview-cornerangle';
tasks{t+5}='fview-perceptualgrouping';
%bloc3
tasks{t+6}='vsearch-similarity-orientation';
tasks{t+7}='vsearch-similarity-size';
%bloc4
tasks{t+8}='vsearch-asymmetry-brightness_wT-hB';
tasks{t+9}='vsearch-asymmetry-brightness_wT-bB';
%bloc5
tasks{t+10}='fview-contourintegration';
tasks{t+11}='vsearch-roughsurface';
%bloc6
tasks{t+12}='vsearch-asymmetry-color_rT';
tasks{t+13}='vsearch-asymmetry-color_bT';
%bloc7
tasks{t+14}='fview-segmentation-orientation';
tasks{t+15}='fview-segmentation-spacing';
%bloc8
tasks{t+16}='vsearch-orientation-categorical';
tasks{t+17}='vsearch-orientation-heterogeneity';
tasks{t+18}='vsearch-orientation-linearity';


for t=1:numel(tasks)
   mkdir(tasks{t}); 
   mkdir([tasks{t} '\' 'masks']); 
end

media_all=listpath(dataset_path);

for t=1:numel(tasks)
    for m=1:numel(media_all)
        if strfind(media_all{m},tasks{t})
            copyfile([dataset_path '\' media_all{m}],[tasks{t} '\' media_all{m}]);
            copyfile([dataset_path '\' 'masks' '\' media_all{m}],[tasks{t} '\' 'masks' '\' media_all{m}]);
        end
    end
end
    
    
    
end

