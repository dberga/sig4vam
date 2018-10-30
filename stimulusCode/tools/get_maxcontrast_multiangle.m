function [maxcontrast ] = get_maxcontrast_multiangle( values, distractors_angle )
           
            %angle between quadrant and target
            dangle=90-distractors_angle;
            
            %angle between farthest distractor angle and target values
            tangle=[];
            for m=1:size(distractors_angle,1)
                tangle=[tangle; values-distractors_angle(m,2)];
            end
            
            %calculate maximum angle contrast considering all conditions for both quadrants
            min_angle=[];
            for m=1:size(distractors_angle,1)
                min_angle=[min_angle; min(abs([tangle(m,:)-dangle(m,:)';tangle(m,:)-dangle(m,:)'-90]))];
            end
            maxcontrast=max(max(min_angle));

end

