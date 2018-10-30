function [ MediaObject, TrialTaskInfo ] = trial2tag( docNode, name, rduration,dduration, source, kept, task ,group, aoicoords, aoitime )
    
            MediaObject=docNode.createElement('MediaObject');
            MediaObject.setAttribute('type','ImageObject'); %xsi:type
                RandomizableDuration=docNode.createElement('RandomizableDuration');
                RandomizableDuration.appendChild(docNode.createTextNode(rduration));
                MediaObject.appendChild(RandomizableDuration);
                Duration=docNode.createElement('Duration');
                Duration.appendChild(docNode.createTextNode(dduration));
                MediaObject.appendChild(Duration);
                ShortFileName=docNode.createElement('ShortFileName');
                ShortFileName.appendChild(docNode.createTextNode([name]));
                MediaObject.appendChild(ShortFileName);
                SourceLocation=docNode.createElement('SourceLocation');
                SourceLocation.appendChild(docNode.createTextNode([source]));
                MediaObject.appendChild(SourceLocation);
                if nargin>6
                    Task=docNode.createElement('Task');
                    Task.appendChild(docNode.createTextNode(task));
                     MediaObject.appendChild(Task);
                end
                
                if nargin>7
                    GroupName=docNode.createElement('GroupName');
                    if strcmp(kept,'false')
                        GroupName.appendChild(docNode.createTextNode([group]));
                    else
                        GroupName.appendChild(docNode.createTextNode(['with previous']));
                    end
                     MediaObject.appendChild(GroupName);
                end
                AOIList=docNode.createElement('AOIList');
                if nargin>8 && size(aoicoords,1)>0
                    TriggerAoi=docNode.createElement('TriggerAoi');
                        AoiType=docNode.createElement('AoiType');
                        AoiType.appendChild(docNode.createTextNode('Rectangle'));
                        TriggerAoi.appendChild(AoiType);
                        Visibility=docNode.createElement('Visibility');
                        Visibility.appendChild(docNode.createTextNode('Visible'));
                        TriggerAoi.appendChild(Visibility);
                        Points=docNode.createElement('Points');
                            Point1=docNode.createElement('Point');
                                X1=docNode.createElement('X');
                                X1.appendChild(docNode.createTextNode(num2str(aoicoords(1))));
                                Point1.appendChild(X1);
                                Y1=docNode.createElement('Y');
                                Y1.appendChild(docNode.createTextNode(num2str(aoicoords(2))));
                                Point1.appendChild(Y1);
                            Points.appendChild(Point1);
                            Point2=docNode.createElement('Point');
                                X2=docNode.createElement('X');
                                X2.appendChild(docNode.createTextNode(num2str(aoicoords(3))));
                                Point2.appendChild(X2);
                                Y2=docNode.createElement('Y');
                                Y2.appendChild(docNode.createTextNode(num2str(aoicoords(4))));
                                Point2.appendChild(Y2);
                            Points.appendChild(Point2);
                        TriggerAoi.appendChild(Points);
                        FixationTime=docNode.createElement('FixationTime');
                        FixationTime.appendChild(docNode.createTextNode(aoitime));
                        TriggerAoi.appendChild(FixationTime);
                    AOIList.appendChild(TriggerAoi);
                end
                MediaObject.appendChild(AOIList);
                IsKeptWithPrevious=docNode.createElement('IsKeptWithPrevious');
                IsKeptWithPrevious.appendChild(docNode.createTextNode(kept));
                MediaObject.appendChild(IsKeptWithPrevious);
                AudioFile=docNode.createElement('AudioFile');
                    AudioFile_sub=docNode.createElement('AudioFile');
                    AudioFile.appendChild(AudioFile_sub);
                    AudioFileMode=docNode.createElement('AudioFileMode');
                    AudioFileMode.appendChild(docNode.createTextNode('Stop'));
                    AudioFile.appendChild(AudioFileMode);
                MediaObject.appendChild(AudioFile);
            
                TrialTaskInfo=docNode.createElement('TrialTaskInfo');
                Task=docNode.createElement('Task');
                if nargin>6, Task.appendChild(docNode.createTextNode(task)); end
               TrialTaskInfo.appendChild(Task); 
                Trialname=docNode.createElement('TrialName');
                Trialname.appendChild(docNode.createTextNode(name));
                TrialTaskInfo.appendChild(Trialname);
end

