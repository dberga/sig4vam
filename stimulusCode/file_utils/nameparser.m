function [ newname ] = nameparser( name )


evaluation_list = {...
    'fview-cornerangle',...
    'fview-segmentation-orientation',...
    'fview-segmentation-spacing',...
    'fview-contourintegration'...
    'fview-perceptualgrouping'...
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
evaluation_list_parsed = {...
    'fv1',...
    'fv2',...
    'fv3',...
    'fv4'...
    'fv5'...
    'vs1',... 
    'vs2',... 
    'vs3',...
    'vs4',...
    'vs5',...
    'vs6',...
    'vs7',...  
 	'vs8',...
    'vs9',...
    'vs10',...  
};
newname=name;
for e=1:numel(evaluation_list)
   if strfind(name,evaluation_list{e})>0
       [~,~,ext]=fileparts(name);
       name_noext=remove_extension(name);
       name_noext=strrep(name_noext,evaluation_list{e},evaluation_list_parsed{e});
       name_noext=strrep(name_noext,'_','B'); %barra
       name_noext=strrep(name_noext,'-','G'); %guion
       name_noext=strrep(name_noext,'easy','d1');
       name_noext=strrep(name_noext,'hard','d2');
       name_noext=strrep(name_noext,'.','p');
       newname=[name_noext ext];
   end
end



end

