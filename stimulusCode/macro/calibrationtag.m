function [ MediaObject ] = calibrationtag(docNode )
    MediaObject=docNode.createElement('MediaObject');
    MediaObject.setAttribute('type','CalibrationObject'); %xsi:type
        BackgroundColor=docNode.createElement('BackgroundColor');
            A=docNode.createElement('A');
            A.appendChild(docNode.createTextNode('255'));
            BackgroundColor.appendChild(A);
            R=docNode.createElement('R');
            R.appendChild(docNode.createTextNode('192'));
            BackgroundColor.appendChild(R);
            G=docNode.createElement('G');
            G.appendChild(docNode.createTextNode('192'));
            BackgroundColor.appendChild(G);
            B=docNode.createElement('B');
            B.appendChild(docNode.createTextNode('192'));
            BackgroundColor.appendChild(B);
            ScA=docNode.createElement('ScA');
            ScA.appendChild(docNode.createTextNode('1'));
            BackgroundColor.appendChild(ScA);
            ScR=docNode.createElement('ScR');
            ScR.appendChild(docNode.createTextNode('0.5271151'));
            BackgroundColor.appendChild(ScR);
            ScG=docNode.createElement('ScG');
            ScG.appendChild(docNode.createTextNode('0.5271151'));
            BackgroundColor.appendChild(ScG);
            ScB=docNode.createElement('ScB');
            ScB.appendChild(docNode.createTextNode('0.5271151'));
            BackgroundColor.appendChild(ScB);
        MediaObject.appendChild(BackgroundColor);
        RandomizableDuration=docNode.createElement('RandomizableDuration');
        RandomizableDuration.appendChild(docNode.createTextNode('manual'));
        MediaObject.appendChild(RandomizableDuration);
        Duration=docNode.createElement('Duration');
        Duration.appendChild(docNode.createTextNode('-1'));
        MediaObject.appendChild(Duration);
        RecordData=docNode.createElement('RecordData');
        RecordData.appendChild(docNode.createTextNode('true'));
        MediaObject.appendChild(RecordData);
        ShortFileName=docNode.createElement('ShortFileName');
        MediaObject.appendChild(ShortFileName);
        QualityCheck=docNode.createElement('QualityCheck');
        QualityCheck.appendChild(docNode.createTextNode('Validation'));
        MediaObject.appendChild(QualityCheck);
        Target=docNode.createElement('Target');
        Target.appendChild(docNode.createTextNode('standard'));
        MediaObject.appendChild(Target);
        Verification=docNode.createElement('Verification');
        Verification.appendChild(docNode.createTextNode('false'));
        MediaObject.appendChild(Target);


end

