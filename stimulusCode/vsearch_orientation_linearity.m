function [  ] = vsearch_orientation_linearity( evaluation_list )

    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
     [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 4, cnum, gridsize, stimsize );
     [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params('full');
    
    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
        case 'vsearch-orientation-linearity'
            disp(evaluation_list{e});
            mkdir(['dataset_blocks' '/' evaluation_list{e}]);
            evaluation_conditions{e}={'linear','nonlinear10','nonlinear20','nonlinear90'};
            angle_contrast=psycontrast;
            values=asind(angle_contrast); %angle with respect horizontal
            evaluation_values{e}=values;
            
            for c=1:numel(evaluation_conditions{e})
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                    switch evaluation_conditions{e}{c}
                        case 'linear'
                            %lin
                            [I,ycoord,xcoord]=image_popout_nonlinear_xy(gridsize,barlen,barwid,spacing,[values(v),0,0],contrast_bw,background_bw,jitter_pos,0,1,a,b);
                            
                        case 'nonlinear10'
                            [I,ycoord,xcoord]=image_popout_nonlinear_xy(gridsize,barlen,barwid,spacing,[values(v)+((10.*a)+(10.*b)),0,10],contrast_bw,background_bw,jitter_pos,0,1,a,b);
                            
                        case 'nonlinear20'
                            [I,ycoord,xcoord]=image_popout_nonlinear_xy(gridsize,barlen,barwid,spacing,[values(v)+((20.*a)+(20.*b)),0,20],contrast_bw,background_bw,jitter_pos,0,1,a,b);
                            
                        case 'nonlinear90'
                            target_bw=[0];
                            background_bw=[1];
                            distractor_bw=[0];
                            contrast_bw=[target_bw,distractor_bw]-background_bw;
                            jitter_pos=0;
                            [I,ycoord,xcoord]=image_popout_nonlinear_xy(gridsize,barlen,barwid,spacing,[values(v)+((90.*a)+(90.*b)),0,90],contrast_bw,background_bw,jitter_pos,0,1,a,b);
                            
            %                 imagesc(I);
                    end
                    Iout=getcorrect_xy(I,[M N]);
                    imwrite(Iout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                    imwrite(Iout,['dataset' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                    Imask=getmask_xy(I,xcoord,ycoord,spacing);
                    Imaskout=getcorrect_xy(Imask,[M N]);
                    imwrite(Imaskout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);     
                    imwrite(Imaskout,['dataset' '/' 'masks' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);

                    
%                   imagesc(imfuse(Iout,Imaskout));                    
                    
                    %colorparams={repmat(contrast_bw(1),3,1),repmat(background_bw,3,1),repmat(contrast_bw(2),3,1),0,1};
                    %save(['dataset/extra/colorparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'colorparams');

%                     coordparams={a_rand(c,v),b_rand(c,v),y_rand(c,v),x_rand(c,v)};
%                     save(['dataset/extra/coordparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'coordparams');
                end
            end
    end

end

