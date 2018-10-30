function [  ] = vsearch_similarity_size( evaluation_list )

    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
   [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 1, cnum, gridsize, stimsize );
    [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params;
    
    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
        case 'vsearch-similarity-size'
            disp(evaluation_list{e});
            mkdir(['dataset_blocks' '/' evaluation_list{e}]);
            evaluation_conditions{e}={'default'};
            percstim_values=psycontrast_updown;
            values=percstim_values; %perc
            scaling_param=percstim_values;
            size_param=percstim_values.*stimsize./pxva;
            evaluation_values{e}=size_param;
            
            for c=1:numel(evaluation_conditions{e})
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                    switch evaluation_conditions{e}{c}
                        case 'default'
                            %circles
                            jitter_pos(2)=(barlen*values(v))-(barlen+jitter_pos(1));
                            shape=define_circ(spacing,spacing);
                            h=max(odd(barlen),odd(barwid))+2;
                            [I,ycoord,xcoord]=image_popout_anyshape_xy(gridsize,barlen,barwid,spacing,[0,0],contrast_bw,background_bw,jitter_pos,jitter_angle,surr_prob,shape,a,b);
                            [I,ycoord,xcoord]=image_resizetarget(I,xcoord,ycoord,h,background_bw,values(v),shape);
%                           imagesc(I);
                    end 
                    Iout=getcorrect_xy(I,[M N]);
                    imwrite(Iout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                    imwrite(Iout,['dataset' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                    Imask=getmask_xy(I,xcoord,ycoord,spacing.*values(v));
                    Imaskout=getcorrect_xy(Imask,[M N]);
                    imwrite(Imaskout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);     
                    imwrite(Imaskout,['dataset' '/' 'masks' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                
%                    imagesc(imfuse(Iout,Imaskout));                    
                    
                    %colorparams={repmat(contrast_bw(1),3,1),repmat(background_bw,3,1),repmat(contrast_bw(2),3,1),0,1};
                    %save(['dataset/extra/colorparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'colorparams');

                    %coordparams={a_rand(c,v),b_rand(c,v),y_rand(c,v),x_rand(c,v)};
                    %save(['dataset/extra/coordparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'coordparams');
                end
            end
    end
    end




