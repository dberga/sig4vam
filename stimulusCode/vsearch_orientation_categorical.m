function [  ] = vsearch_orientation_categorical( evaluation_list)

    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
    [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 3, cnum, gridsize, stimsize );
    [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params('full');
    
    
    
    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
        case 'vsearch-orientation-categorical'
            disp(evaluation_list{e});
            mkdir(['dataset_blocks' '/' evaluation_list{e}]);
            evaluation_conditions{e}={'steep','steepest','steep-right'};
            angle_contrast=psycontrast;
            values=asind(angle_contrast);

            %original coords
%             a_rand=[7,5,4,8,3,7,3;6,3,6,6,8,8,2;3,8,5,4,6,6,3];
%             b_rand=[5,9,10,6,4,11,2;6,9,7,3,2,8,6;9,4,9,8,2,2,7];
            
            [c1c2_maxcontrast]=get_maxcontrast_multiangle( values, [50,-50;70,-30;80,-20] );
            
            %adjust to maximum contrast angle
            values=values*(c1c2_maxcontrast/90); 
            evaluation_values{e}=values;
            
            
            [condcontrast_c1,condcontrast_c2]=get_condcontrast_multiangle( values, [50,-50;70,-30;80,-20] );
            
            
            
            for c=1:numel(evaluation_conditions{e})
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                    switch evaluation_conditions{e}{c}

                        case 'steep'
                            %steep
                            surr_prob=[1 0.5];
                            [I,ycoord,xcoord]=image_popout_flanking_xy(gridsize,barlen,barwid,spacing,[90-50-values(v),90,-50,50],contrast_bw,background_bw,jitter_pos,jitter_angle,surr_prob,a,b);

                        case 'steepest'
                            %steepest
                            surr_prob=[1 0.5];
                            [I,ycoord,xcoord]=image_popout_flanking_xy(gridsize,barlen,barwid,spacing,[90-70-values(v),90,-30,70],contrast_bw,background_bw,jitter_pos,jitter_angle,surr_prob,a,b);

                        case 'steep-right'
                            %steep-right
                            surr_prob=[1 0.5];
                            [I,ycoord,xcoord]=image_popout_flanking_xy(gridsize,barlen,barwid,spacing,[90-80-values(v),90,-20,80],contrast_bw,background_bw,jitter_pos,jitter_angle,surr_prob,a,b);

                    end
                    Iout=getcorrect_xy(I,[M N]);
                    imwrite(Iout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                    imwrite(Iout,['dataset' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                    Imask=getmask_xy(I,xcoord,ycoord,spacing);
                    Imaskout=getcorrect_xy(Imask,[M N]);
                    imwrite(Imaskout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);     
                    imwrite(Imaskout,['dataset' '/' 'masks' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                
%                     imagesc(imfuse(Iout,Imaskout));

                    %colorparams={repmat(contrast_bw(1),3,1),repmat(background_bw,3,1),repmat(contrast_bw(2),3,1),0,1};
                    %save(['dataset/extra/colorparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'colorparams');

%                     coordparams={a_rand(c,v),b_rand(c,v),y_rand(c,v),x_rand(c,v)};
%                     save(['dataset/extra/coordparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'coordparams');
                end
            end
        end
    end
end

    
        
