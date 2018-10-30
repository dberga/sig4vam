function [   ] = vsearch_asymmetry_brightness( evaluation_list)

    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
    [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 2, cnum, gridsize, stimsize );
    [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params;
    
    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
        case 'vsearch-asymmetry-brightness'
            disp(evaluation_list{e});
            mkdir(['dataset_blocks' '/' evaluation_list{e}]);
            evaluation_conditions{e}={'wT-hB','wT-bB'};
            luminance_contrast_values=psycontrast;
            values=1-luminance_contrast_values; %perc
            evaluation_values{e}=luminance_contrast_values;
            
            %barwid=barlen;
            for c=1:numel(evaluation_conditions{e})
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                    switch evaluation_conditions{e}{c}
                        case 'wT-hB'
                            target_rgb=[0.5 0.5 0.5]';
                            background_rgb=[0 0 0]';
                            [distractor_rgb,theta(v),Ldiff(v)]=getX_RGB_achromatic(background_rgb,target_rgb,values(v));
                            contrast_rgb=[target_rgb,distractor_rgb];
                            shape=define_circ(spacing,spacing);
                             [I,ycoord,xcoord]=image_popout_anyshape_color_xy(gridsize,barlen,barwid,spacing,[0,0],contrast_rgb,background_rgb,jitter_pos,jitter_angle,surr_prob,shape,a,b);
                        case 'wT-bB'
                            target_rgb=[0.5 0.5 0.5]';
                            background_rgb=[1 1 1]';
                            [distractor_rgb,theta(v),Ldiff(v)]=getX_RGB_achromatic(background_rgb,target_rgb,values(v));
                            contrast_rgb=[target_rgb,distractor_rgb];
                            shape=define_circ(spacing,spacing);
                            [I,ycoord,xcoord]=image_popout_anyshape_color_xy(gridsize,barlen,barwid,spacing,[0,0],contrast_rgb,background_rgb,jitter_pos,jitter_angle,surr_prob,shape,a,b);
                    end
                    
                    Iout=getcorrect_xy(I,[M N]);
                    imwrite(Iout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                    imwrite(Iout,['dataset' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                    Imask=getmask_xy(I,xcoord,ycoord,spacing);
                    Imaskout=getcorrect_xy(Imask,[M N]);
                    imwrite(Imaskout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);      
                    imwrite(Imaskout,['dataset' '/' 'masks' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                    
%                   imagesc(imfuse(Iout,Imaskout));                    

                    target_lsY=XYZ2lsY(sRGB2XYZ(target_rgb'),'macleod-boynton1979');
                    background_lsY=XYZ2lsY(sRGB2XYZ(background_rgb'),'macleod-boynton1979');
                    distractor_lsY=XYZ2lsY(sRGB2XYZ(distractor_rgb'),'macleod-boynton1979');
                
                    %colorparams={target_rgb,background_rgb,distractor_rgb,theta(v),Ldiff,target_lsY,background_lsY,distractor_lsY};
                    %save(['dataset/extra/colorparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'colorparams');
                    
                    %coordparams={a_rand(c,v),b_rand(c,v),y_rand(c,v),x_rand(c,v)};
                    %save(['dataset/extra/coordparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'coordparams');
                
                end
            end
    end
end
end

