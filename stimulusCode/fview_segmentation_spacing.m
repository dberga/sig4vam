function [  ] = fview_segmentation_spacing( evaluation_list )

    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
    [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 1, cnum, gridsize, stimsize );
    [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params('full');

    
    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
        case 'fview-segmentation-spacing'
            disp(evaluation_list{e});
            mkdir(['dataset_blocks' '/' evaluation_list{e}]);
            evaluation_conditions{e}={'default'};
            percstim_values=psycontrast_updown;
            values=round(spacing.*percstim_values); %perc
            %evaluation_values{e}=percstim_values.*stimsize./pxva;
            
            %update spacing because of rescaling and rotation
            for v=1:numel(values)
                sizefacs(v)=size(define_blank_image(gridsize,barlen,values(v),background_bw),1)./M;
            end
            
            barlen_dmod=barlen-(barlen-(barlen*cosd(45))); %consider diagonal spacing bar draw spacing
            values_pos=(values-barlen_dmod)>0;
            values_correct=(values-barlen_dmod); %diagonal spacing between distractors
            horiz_dist=(values_correct.*values_pos)./sizefacs.*(N/M); %to visual angle
            
            horiz_dist_dva=horiz_dist./pxva;
            barlengths=(barlen./sizefacs)./pxva;
                    
            evaluation_values{e}=horiz_dist_dva;
            
            types=fliplr(types); %lower space creates more contrast

            %original coords
            %a_rand=[3,6,4,4,4,6,2];
            %b_rand=[10,2,10,5,5,2,11];
            a_rand_rot=b_rand;
            b_rand_rot=a_rand;
            
            for c=1:numel(evaluation_conditions{e})
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                    switch evaluation_conditions{e}{c}
                        case 'default'
                            [I,ycoord,xcoord]=image_border_xy(gridsize,barlen,barwid,values(v),[45,-45],contrast_bw,background_bw,jitter_pos,jitter_angle,a,b);
                            I=imrotate(I,90);
                            [~,~,xloc,yloc]=define_blank_image(gridsize,barlen,values(v),background_bw);
                            ycoord=yloc(a_rand_rot(c,v));
                            xcoord=xloc(b_rand_rot(c,v));
                            
                    end
                        
                        
                        Iout=getcorrect_xy(I,[M N]);
                        imwrite(Iout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                        imwrite(Iout,['dataset' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                        Imask=getmask_segmentation_xy(I,xcoord+round(values(v)*0.5),ycoord,values(v)*2);
                        Imaskout=getcorrect_xy(Imask,[M N]); 
                        imwrite(Imaskout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);     
                        imwrite(Imaskout,['dataset' '/' 'masks' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                        
                    %imagesc(imfuse(Iout,Imaskout));

                    %colorparams={repmat(contrast_bw(1),3,1),repmat(background_bw,3,1),repmat(contrast_bw(2),3,1),0,1};
                    %save(['dataset/extra/colorparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'colorparams');

                    %coordparams={a_rand_rot(c,v),b_rand_rot(c,v),y_rand(c,v),x_rand(c,v)};
                    %save(['dataset/extra/coordparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'coordparams');
                end
            end 
        
        
    end
    
    
    end

end








        
