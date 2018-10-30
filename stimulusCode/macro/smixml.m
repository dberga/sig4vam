function [  ] = smixml( names )

docNode = com.mathworks.xml.XMLUtils.createDocument('SlideShowList');
docRootNode = docNode.getDocumentElement;
for i=1:numel(names)
    MediaObject = docNode.createElement('MediaObject'); 
    MediaObject.setAttribute('type','ImageObject');
    
        RandomizableDuration=docNode.createElement('RandomizableDuration');
        RandomizableDuration.appendChild(docNode.createTextNode('manual'));
        MediaObject.appendChild(RandomizableDuration);
        
        ShortFileName=docNode.createElement('ShortFileName');
        ShortFileName.appendChild(docNode.createTextNode(names{i}));
        MediaObject.appendChild(ShortFileName);
        
        SourceLocation=docNode.createElement('SourceLocation');
        SourceLocation.appendChild(docNode.createTextNode(['C:\Program Files (x86)\SMI\Experiment Suite 360\Experiment Center 2\Experiments\exp_bueno2\' names{i}]));
        MediaObject.appendChild(SourceLocation);
        
    docRootNode.appendChild(MediaObject);
    
    MediaObject_fondo = docNode.createElement('MediaObject'); 
    MediaObject_fondo.setAttribute('type','ImageObject');
    
        RandomizableDuration=docNode.createElement('RandomizableDuration');
        RandomizableDuration.appendChild(docNode.createTextNode('2000'));
        MediaObject_fondo.appendChild(RandomizableDuration);
        
        ShortFileName=docNode.createElement('ShortFileName');
        ShortFileName.appendChild(docNode.createTextNode(['fondo' int2str(i) '.png']));
        MediaObject_fondo.appendChild(ShortFileName);
        
        SourceLocation=docNode.createElement('SourceLocation');
        SourceLocation.appendChild(docNode.createTextNode(['C:\Program Files (x86)\SMI\Experiment Suite 360\Experiment Center 2\Experiments\exp_bueno2\' 'fondo' int2str(i) '.png']));
        MediaObject_fondo.appendChild(SourceLocation);
        
    docRootNode.appendChild(MediaObject_fondo);
end
xmlFileName = ['file','.xml'];
xmlwrite(xmlFileName,docNode);
type(xmlFileName);


end


    
