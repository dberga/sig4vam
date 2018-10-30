function [condcontrast_c1, condcontrast_c2 ] = get_condcontrast_multiangle( values, distractors_angle )

            %difference between farthest and closest distractors angle
            angle_diffs=[];
            for m=1:size(distractors_angle,1)
                angle_diffs=[angle_diffs; distractors_angle(m,1)-distractors_angle(m,2)];
            end
            
            %calculate angle distance between target and closest(c1) or farthest(c2)
            condcontrast_c1=[];
            condcontrast_c2=[];
            for m=1:size(distractors_angle,1)
                condcontrast_c1=[condcontrast_c1;abs(min(180-values-0,values+0))];
                condcontrast_c2=[condcontrast_c2;abs(min(180-values-angle_diffs(m),values+angle_diffs(m)))];
            end
            
            

end

