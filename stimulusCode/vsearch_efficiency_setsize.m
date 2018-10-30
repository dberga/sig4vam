function [  ] = vsearch_efficiency_setsize( evaluation_list )

    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
    [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 4, cnum, gridsize, stimsize );
    [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params;
    
    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
            case 'vsearch-efficiency-setsize'
                disp(evaluation_list{e});
                mkdir(['dataset_blocks' '/' evaluation_list{e}]);
                evaluation_conditions{e}={'feature','conjunctive','feature-absent','conjunctive-absent'};
                min_prob=(2/(gridsize(1)*gridsize(2)));
                prob_values=(1-psycontrast)*surr_prob+min_prob;
                values=(prob_values); %prob
                evaluation_values{e}=round((gridsize(1)*gridsize(2)-1)*(prob_values));

                for c=1:numel(evaluation_conditions{e})
                    mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                    mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                    %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                    for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                        switch evaluation_conditions{e}{c}
                            case 'feature'
    %                             [~,~,spacing,~]=standard_image_param_values(imsizefac,crop,1);
                                background_rgb=[1;1;1];
                                target_rgb=[1; 0; 0];
                                distractor_rgb=[0; 1; 0];
                                contrast_rgb=[target_rgb,distractor_rgb];
                                [I,ycoord,xcoord]=image_popout_color_xy(gridsize,barlen,barwid,spacing,[45,45],contrast_rgb,background_rgb,jitter_pos,jitter_angle,values(v),a,b);
                            case 'feature-absent'
    %                             [~,~,spacing,~]=standard_image_param_values(imsizefac,crop,1);
                                background_rgb=[1;1;1];
                                target_rgb=[1; 0; 0];
                                distractor_rgb=[0; 1; 0];
                                contrast_rgb=[target_rgb,distractor_rgb];
                                [I,ycoord,xcoord]=image_popout_color_xy(gridsize,barlen,barwid,spacing,[45,45],contrast_rgb,background_rgb,jitter_pos,jitter_angle,values(v),a,b);
                                [I,ycoord,xcoord]=image_absence(I,xcoord,ycoord,spacing,background_rgb);
                            case 'conjunctive'
    %                             [~,~,spacing,~]=standard_image_param_values(imsizefac,crop,1);
                                background_rgb=[1;1;1];
                                target_rgb=[1; 0; 0];
                                distractor_rgb=[0; 1; 0];
                                distractor2_rgb=[1; 0; 0];
                                contrast_rgb=[target_rgb,distractor_rgb,distractor2_rgb];
                                [I,ycoord,xcoord]=image_popout_conjunctive_color_xy(gridsize,barlen,barwid,spacing,[45,45,-45],contrast_rgb,background_rgb,0,0,values(v),0.5,a,b);
                            case 'conjunctive-absent'
    %                             [~,~,spacing,~]=standard_image_param_values(imsizefac,crop,1);
                                background_rgb=[1;1;1];
                                target_rgb=[1; 0; 0];
                                distractor_rgb=[0; 1; 0];
                                distractor2_rgb=[1; 0; 0];
                                contrast_rgb=[target_rgb,distractor_rgb,distractor2_rgb];
                                [I,ycoord,xcoord]=image_popout_conjunctive_color_xy(gridsize,barlen,barwid,spacing,[45,45,-45],contrast_rgb,background_rgb,0,0,values(v),0.5,a,b);
                                [I,ycoord,xcoord]=image_absence(I,xcoord,ycoord,spacing,background_rgb);
                            end
                        Iout=getcorrect_xy(I,[M N]);
                        imwrite(Iout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                        imwrite(Iout,['dataset' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                        if strfind(evaluation_conditions{e}{c},'absent')>0
                            Imask=getmask_xy(I,xcoord,ycoord,0); 
                        else
                            Imask=getmask_xy(I,xcoord,ycoord,spacing); 
                        end
                        Imaskout=getcorrect_xy(Imask,[M N]);
                        imwrite(Imaskout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);     
                        imwrite(Imaskout,['dataset' '/' 'masks' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c},strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);

%                   imagesc(imfuse(Iout,Imaskout));


                %colorparams={target_rgb,background_rgb,distractor_rgb,0,0};
                %save(['dataset/extra/colorparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'colorparams');
                
                %coordparams={a_rand(c,v),b_rand(c,v),y_rand(c,v),x_rand(c,v)};
                %save(['dataset/extra/coordparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'coordparams');
                end
            end
        end
    end

end





