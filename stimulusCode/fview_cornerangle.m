function [  ] = fview_cornerangle( evaluation_list )

    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
    [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 1, cnum, gridsize, stimsize );
    [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params;
    
    
    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
        case 'fview-cornerangle'
            disp(evaluation_list{e});
            mkdir(['dataset_blocks' '/' evaluation_list{e}]);
            evaluation_conditions{e}={'default'};
            cornerangles=[15,30,45,75,105,135,180];
            evaluation_values{e}=cornerangles;
            types=fliplr(types); %lower angle creates more contrast
            
            for c=1:numel(evaluation_conditions{e})
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                    switch evaluation_conditions{e}{c}
                        case 'default'
                            
                            Icorner=mat2gray(imread(['stimulusCode/corners/' num2str(v) '.jpg']));
                            Imask=mat2gray(imread(['stimulusCode/corners/masks4/' num2str(v) '.png']));
                            if size(Imask,3)>1
                                Imask=rgb2gray(Imask);
                            end
			                               
                            jitter_x=randi([-floor((N-337)/2) floor((N-337)/2)],1 );

                            %original coords
                            %xcoord=[263,250,741,350,181,643,640];
                            %if xcoord(v)<round(N/2)
                            %   jitter_x=(-1) * abs(round(N/2)-xcoord(v));
                            %else
                            %    jitter_x=abs(round(N/2)-xcoord(v));
                            %end
                            
                            [I,mask]=image_corner(Icorner,Imask,M,N,jitter_x);
                    end
                    Iout=I;
                    imwrite(Iout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                    imwrite(Iout,['dataset' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                    Imaskout=mask;
                    imwrite(Imaskout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                    imwrite(Imaskout,['dataset' '/' 'masks' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                    
                  %imagesc(imfuse(Iout,Imaskout));

                    %colorparams={repmat(contrast_bw(1),3,1),repmat(background_bw,3,1),repmat(contrast_bw(2),3,1),0,1};
                    %save(['dataset/extra/colorparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'colorparams');

                    %coordparams={a_rand(c,v),b_rand(c,v),y_rand(c,v),x_rand(c,v)};
                    %save(['dataset/extra/coordparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'coordparams');
                end
            end
        
        
    end
    
    
    end

end








        
