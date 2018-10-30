function [  ] = folder2smi( folder_path )

%%%%%%%README

%NOTE: Basic images should appear: Introduction.png, Calibration.png, Fin.png, Transition.png

%%%%%%%%%%%%%

%read task folders
if nargin < 1
    %For each session, choose 1 or 2 of each block to fill the session (8 and 10)
    %bloc0
    t=1; 
    tasks{t+0}='test';
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
else
    tasks=listpath_dir(folder_path);
end
%tasks=unsort_cell(tasks);

for t=1:numel(tasks)
    media_names{t}=listpath(['.' '\' tasks{t}]);
end
for t=1:numel(tasks)
    aoicoords{t}={};
    for m=1:numel(media_names{t})
        aoicoords{t}{m}=getaoicoords(imread([tasks{t} '\' 'masks' '\' media_names{t}{m}]));
    end
end

for t=1:numel(tasks)
    parsed_tasks{t}=nameparser(tasks{t});
    for m=1:numel(media_names{t})
        parsed_media_names{t}{m}=nameparser(media_names{t}{m});
    end
end

experiment_name='ExperimentoFinal';
author_name='david.berga';
width='1280';
height='1024';
description='Experimento Saliency';
source_folder=['C:\Program Files (x86)\SMI\Experiment Suite 360\Experiment Center 2\Experiments\' experiment_name];
intro_name='Introduction';
calib_name='Calibracion';
transition_name='Transition';
fin_name='Fin';
instruction_rtime='manual';
instruction_dtime='-1';
transition_rtime='2000';
transition_dtime='2000';
media_rtime='manual';
media_dtime='-1';
media_rtime_fview='5000';
media_dtime_fview='5000';
media_kept='true';
vsearch_tag='vsearch';
test_tag='test';
fview_tag='fview';
aoitime='1000';

%convert folder and images to xml

docNode = com.mathworks.xml.XMLUtils.createDocument('Experiment');
docRootNode = docNode.getDocumentElement; 
docRootNode.setAttribute('xsi','http://www.w3.org/2001/XMLSchema-instance'); %xmlns:xsi
docRootNode.setAttribute('xsd','http://www.w3.org/2001/XMLSchema'); %xmlns:xsd

CalibrationArea=docNode.createElement('CalibrationArea');
    Width=docNode.createElement('Width');
    Width.appendChild(docNode.createTextNode(width));
    CalibrationArea.appendChild(Width);
    Height=docNode.createElement('Height');
    Height.appendChild(docNode.createTextNode(height));
    CalibrationArea.appendChild(Height);
docRootNode.appendChild(CalibrationArea);

CurrentObjIdx=docNode.createElement('CurrentObjIdx');
CurrentObjIdx.appendChild(docNode.createTextNode('-1'));
docRootNode.appendChild(CurrentObjIdx);

DefaultBackColor=docNode.createElement('DefaultBackColor');
    A=docNode.createElement('A');
    A.appendChild(docNode.createTextNode('255'));
    DefaultBackColor.appendChild(A);
    R=docNode.createElement('R');
    R.appendChild(docNode.createTextNode('192'));
    DefaultBackColor.appendChild(R);
    G=docNode.createElement('G');
    G.appendChild(docNode.createTextNode('192'));
    DefaultBackColor.appendChild(G);
    B=docNode.createElement('B');
    B.appendChild(docNode.createTextNode('192'));
    DefaultBackColor.appendChild(B);
    ScA=docNode.createElement('ScA');
    ScA.appendChild(docNode.createTextNode('1'));
    DefaultBackColor.appendChild(ScA);
    ScR=docNode.createElement('ScR');
    ScR.appendChild(docNode.createTextNode('0.5271151'));
    DefaultBackColor.appendChild(ScR);
    ScG=docNode.createElement('ScG');
    ScG.appendChild(docNode.createTextNode('0.5271151'));
    DefaultBackColor.appendChild(ScG);
    ScB=docNode.createElement('ScB');
    ScB.appendChild(docNode.createTextNode('0.5271151'));
    DefaultBackColor.appendChild(ScB);
docRootNode.appendChild(DefaultBackColor);

Description=docNode.createElement('Description');
Description.appendChild(docNode.createTextNode(description));
docRootNode.appendChild(Description);

Name=docNode.createElement('Name');
Name.appendChild(docNode.createTextNode('ExperimentoFinal'));
docRootNode.appendChild(Name);

VersionString=docNode.createElement('VersionString');
VersionString.appendChild(docNode.createTextNode('3.0.77.0'));
docRootNode.appendChild(VersionString);

AnnotationTemplateCollection=docNode.createElement('AnnotationTemplateCollection');
docRootNode.appendChild(AnnotationTemplateCollection);

IsLocked=docNode.createElement('IsLocked');
IsLocked.appendChild(docNode.createTextNode('false'));
docRootNode.appendChild(IsLocked);

PropertyList=docNode.createElement('PropertyList');
        SubjectProperty=docNode.createElement('SubjectProperty');
            Text=docNode.createElement('Text');
            Text.appendChild(docNode.createTextNode('SubjectName'));
            SubjectProperty.appendChild(Text);
        PropertyList.appendChild(SubjectProperty);
        SubjectProperty=docNode.createElement('SubjectProperty');
            Text=docNode.createElement('Text');
            Text.appendChild(docNode.createTextNode('Age'));
            SubjectProperty.appendChild(Text);
        PropertyList.appendChild(SubjectProperty);
        SubjectProperty=docNode.createElement('SubjectProperty');
            Text=docNode.createElement('Text');
            Text.appendChild(docNode.createTextNode('Gender'));
            SubjectProperty.appendChild(Text);
        PropertyList.appendChild(SubjectProperty);
        SubjectProperty=docNode.createElement('SubjectProperty');
            Text=docNode.createElement('Text');
            Text.appendChild(docNode.createTextNode('VisualProblems'));
            SubjectProperty.appendChild(Text);
        PropertyList.appendChild(SubjectProperty);
docRootNode.appendChild(PropertyList);


TaskList=docNode.createElement('TaskList');
    for t=1:numel(tasks)
        ExperimentTask=docNode.createElement('ExperimentTask');
        IsActive=docNode.createElement('IsActive');
        IsActive.appendChild(docNode.createTextNode('true'));
        ExperimentTask.appendChild(IsActive);
        TaskName=docNode.createElement('Name');
        TaskName.appendChild(docNode.createTextNode(['Task' int2str(t)]));
        ExperimentTask.appendChild(TaskName);
        TaskList.appendChild(ExperimentTask);
    end
docRootNode.appendChild(TaskList);



count=1;
SlideShowList=docNode.createElement('SlideShowList');
TrialTaskHistory=docNode.createElement('TrialTaskHistory');

    %introduction
    copyfile([intro_name '.png'], [source_folder '\' intro_name '.png']);
    [MediaObject,TrialTaskInfo ]=trial2tag(docNode,[intro_name '.png'],instruction_rtime,instruction_dtime, [source_folder '\' intro_name '.png'],'false');
    SlideShowList.appendChild(MediaObject);
    TrialTaskHistory.appendChild(TrialTaskInfo);
    
    %calib introduction
    copyfile([calib_name '.png'], [source_folder '\' calib_name '.png']);
    [MediaObject,TrialTaskInfo ]=trial2tag(docNode,[calib_name '.png'],instruction_rtime,instruction_dtime, [source_folder '\' calib_name '.png'],'false');
    SlideShowList.appendChild(MediaObject);
    TrialTaskHistory.appendChild(TrialTaskInfo);
    
    %calibration
    MediaObject=calibrationtag(docNode);
    SlideShowList.appendChild(MediaObject);
    
    %trials
    for t=1:numel(tasks)
            
            
            
            %append instruction task
            copyfile([tasks{t} '.png'], [source_folder '\' parsed_tasks{t} '.png']);
            [MediaObject,TrialTaskInfo ]=trial2tag(docNode,[parsed_tasks{t} '.png'],instruction_rtime,instruction_dtime, [source_folder '\' parsed_tasks{t} '.png'],'false', ['Task' int2str(t)]);
            SlideShowList.appendChild(MediaObject);
            TrialTaskHistory.appendChild(TrialTaskInfo);
            
            
        for m=1:numel(media_names{t})
            %append transition
            copyfile([transition_name '.png'], [source_folder '\' transition_name int2str(count) '.png']);
            [MediaObject,TrialTaskInfo ]=trial2tag(docNode,[transition_name int2str(count) '.png'],'500','500', [source_folder '\' transition_name int2str(count) '.png'],'false' ,['Task' int2str(t)] ,['Group' int2str(t)]);
            SlideShowList.appendChild(MediaObject);
            TrialTaskHistory.appendChild(TrialTaskInfo);
            count=count+1;
            copyfile([transition_name '.png'], [source_folder '\' transition_name int2str(count) '.png']);
            [MediaObject,TrialTaskInfo ]=trial2tag(docNode,[transition_name int2str(count) '.png'],transition_rtime,transition_dtime, [source_folder '\' transition_name int2str(count) '.png'],'true' ,['Task' int2str(t)] ,['Group' int2str(t)]);
            SlideShowList.appendChild(MediaObject);
            TrialTaskHistory.appendChild(TrialTaskInfo);
            count=count+1;
            
            %append image
            copyfile([tasks{t} '\' media_names{t}{m}], [source_folder '\' parsed_media_names{t}{m}]);
            if strfind(media_names{t}{m},vsearch_tag)>0 | strfind(media_names{t}{m},test_tag)>0
                [MediaObject,TrialTaskInfo ]=trial2tag(docNode,[parsed_media_names{t}{m}],media_rtime,media_dtime, [source_folder '\' parsed_media_names{t}{m}], media_kept, ['Task' int2str(t)] ,['Group' int2str(t)],aoicoords{t}{m},aoitime);
            else
                [MediaObject,TrialTaskInfo ]=trial2tag(docNode,[parsed_media_names{t}{m}],media_rtime_fview,media_dtime_fview, [source_folder '\' parsed_media_names{t}{m}], media_kept,['Task' int2str(t)] ,['Group' int2str(t)]);
            end
            
            SlideShowList.appendChild(MediaObject);
            TrialTaskHistory.appendChild(TrialTaskInfo);
        end
        
    end
    
%fin
copyfile([fin_name '.png'], [source_folder '\' fin_name '.png']);
[MediaObject,TrialTaskInfo ]=trial2tag(docNode,[fin_name '.png'],instruction_rtime,instruction_dtime, [source_folder '\' fin_name '.png'],'false');
SlideShowList.appendChild(MediaObject);
TrialTaskHistory.appendChild(TrialTaskInfo);
    
docRootNode.appendChild(TrialTaskHistory);
docRootNode.appendChild(SlideShowList);




xmlFileName = [source_folder,'\',experiment_name,'.exp'];
xmlwrite(xmlFileName,docNode);
fr = fopen(xmlFileName,'r');
s=fread(fr,'*char')';
fclose(fr);

s = strrep(s,'xsi','xmlns:xsi');
s = strrep(s,'xsd','xmlns:xsd');
s = strrep(s,'type','xsi:type');
fw = fopen(xmlFileName,'w');
fprintf(fw,'%s',s);
fclose(fw);
type(xmlFileName);


docNode = com.mathworks.xml.XMLUtils.createDocument('MetaDataExperiment');
docRootNode = docNode.getDocumentElement; 
docRootNode.setAttribute('xsi','http://www.w3.org/2001/XMLSchema-instance'); %xmlns:xsi
docRootNode.setAttribute('xsd','http://www.w3.org/2001/XMLSchema'); %xmlns:xsd

    Name=docNode.createElement('Name');
    Name.appendChild(docNode.createTextNode(experiment_name));
    docRootNode.appendChild(Name);
    Description=docNode.createElement('Description');
    Description.appendChild(docNode.createTextNode(experiment_name));
    docRootNode.appendChild(Description);
    CreatedBy=docNode.createElement('CreatedBy');
    CreatedBy.appendChild(docNode.createTextNode(author_name));
    docRootNode.appendChild(CreatedBy);
    LastSaved=docNode.createElement('LastSaved');
    LastSaved.appendChild(docNode.createTextNode('16/05/2017 3:01:26'));
    docRootNode.appendChild(LastSaved);
    
xmlFileName = [source_folder,'\',experiment_name,'.mtd'];
xmlwrite(xmlFileName,docNode);
fr = fopen(xmlFileName,'r');
s=fread(fr,'*char')';
fclose(fr);

s = strrep(s,'xsi','xmlns:xsi');
s = strrep(s,'xsd','xmlns:xsd');
s = strrep(s,'type','xsi:type');
fw = fopen(xmlFileName,'w');
fprintf(fw,'%s',s);
fclose(fw);
type(xmlFileName);

end














