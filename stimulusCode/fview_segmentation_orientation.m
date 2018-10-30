function [  ] = fview_segmentation_orientation( evaluation_list )

    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
    [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 2, cnum, gridsize, stimsize );
    [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params('full');
    
    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
        case 'fview-segmentation-orientation'
            disp(evaluation_list{e});
            mkdir(['dataset_blocks' '/' evaluation_list{e}]);
            evaluation_conditions{e}={'crossed90-single','crossed90-superimposed'};
            angle_contrast=psycontrast;
            values=asind(angle_contrast); %angle with respect horizontal
            a1=repmat(90,1,length(psycontrast));
            a2=values+90;
            a3=a1+45;
            a4=a2+45;
            contrast_segment1segment2=abs(a1-a2);
            contrast_supersegment1segment2=abs(a2-a3);
            evaluation_values{e}=contrast_segment1segment2;
            
	    %original coords
        %a_rand=[4,8,2,6,7,7,2;6,7,7,3,7,4,2];
        %b_rand=[10,11,4,8,3,2,5;5,7,10,5,6,4,2];
        a_rand_rot=b_rand;
        b_rand_rot=a_rand;
        
            for c=1:numel(evaluation_conditions{e})
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                    switch evaluation_conditions{e}{c}
                        case 'crossed90-single'
                            [I,ycoord,xcoord]=image_border_xy(gridsize,barlen,barwid,spacing,[90,values(v)+90],[contrast_bw,contrast_bw],background_bw,jitter_pos,jitter_angle,a,b);
                            I=imrotate(I,90);
                            [~,~,xloc,yloc]=define_blank_image(gridsize,barlen,spacing,background_bw);
                            ycoord=yloc(a_rand_rot(c,v));
                            xcoord=xloc(b_rand_rot(c,v));
%                         case 'crossed45-single'
%                             [I,ycoord,xcoord]=image_border_xy(gridsize,barlen,barwid,spacing,[45,values(v)+45],[contrast_bw,contrast_bw],background_bw,jitter_pos,jitter_angle,a,b);
%                             I=imrotate(I,90);
%                             ycoord=yloc(a_rand_rot(c,v));
%                             xcoord=xloc(b_rand_rot(c,v));
                        case 'crossed90-superimposed'
                            [I,ycoord,xcoord]=image_border_overlayed_xy(gridsize,barlen,barwid,spacing,[90,90+values(v),90+45,90+values(v)+45],[contrast_bw,contrast_bw],background_bw,jitter_pos,jitter_angle,a,b);
                            I=imrotate(I,90);
                            [~,~,xloc,yloc]=define_blank_image(gridsize,barlen,spacing,background_bw);
                            ycoord=yloc(a_rand_rot(c,v));
                            xcoord=xloc(b_rand_rot(c,v));
%                         case 'crossed45-superimposed'
%                             [I,ycoord,xcoord]=image_border_overlayed_xy(gridsize,barlen,barwid,spacing,[45,45+values(v),45+45,45+values(v)+45],[contrast_bw,contrast_bw],background_bw,jitter_pos,jitter_angle,a,b);
%                             I=imrotate(I,90);
%                             ycoord=yloc(a_rand_rot(c,v));
%                             xcoord=xloc(b_rand_rot(c,v));

                    end
                        
                        Iout=getcorrect_xy(I,[M N]);
                        imwrite(Iout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                        imwrite(Iout,['dataset' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                        Imask=getmask_segmentation_xy(I,round(xcoord+spacing*0.5),ycoord,spacing*2);
                        Imaskout=getcorrect_xy(Imask,[M N]);
                        imwrite(Imaskout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);     
                        imwrite(Imaskout,['dataset' '/' 'masks' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                        
%                       imagesc(imfuse(Iout,Imaskout));
                        
                    %colorparams={repmat(contrast_bw(1),3,1),repmat(background_bw,3,1),repmat(contrast_bw(2),3,1),0,1};
                    %save(['dataset/extra/colorparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'colorparams');

                    %coordparams={a_rand_rot(c,v),b_rand_rot(c,v),y_rand(c,v),x_rand(c,v)};
                    %save(['dataset/extra/coordparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'coordparams');
                    
                end
            end 

    end
end

