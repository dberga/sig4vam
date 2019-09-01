function [  ] = fview_perceptualgrouping( evaluation_list )
    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
    [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 2, cnum, gridsize, stimsize );
    [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params;
    
    
    target_path='stimulusCode/shapes/objects/donut.png';
    distractors_path='stimulusCode/shapes/objects/cd.png';
    Ishapes_rgb{1}=invert_background(load_anyshape(target_path,0));
    Ishapes_rgb{2}=invert_background(load_anyshape(distractors_path,0));
    Ishapes{1}=invert_background(load_anyshape(target_path,0));
    Ishapes{2}=invert_background(load_anyshape(distractors_path,0));
    Ibackground=load_anyshape('stimulusCode/shapes/backgrounds/nature_25.png');
    
    %another example
    
    %target_path='stimulusCode/shapes/objects/elephant.png';
    %distractors_path='stimulusCode/shapes/objects/elephant.png';
    %Ishapes_rgb{1}=load_anyshape(target_path,1));
    %Ishapes_rgb{2}=load_anyshape(target_path,1));
    %Ishapes{1}=load_anyshape(target_path,1);
    %Ishapes{2}=load_anyshape(target_path,1));
    %Ibackground=load_anyshape('stimulusCode/shapes/backgrounds/nature_25.png');
    
    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
        case 'fview-perceptualgrouping',
            disp(evaluation_list{e});
            mkdir(['dataset_blocks' '/' evaluation_list{e}]);
            evaluation_conditions{e}={'proximity-similar','proximity-dissimilar'};
            percgrid_values=psycontrast;
            grouping_radius=floor(min(gridsize)*0.25);
            values=(percgrid_values)*grouping_radius+1;%clen of separation
            dist_distractors2groupcenter=values.*stimsize./pxva;
            evaluation_values{e}=dist_distractors2groupcenter;
            
            for c=1:numel(evaluation_conditions{e})
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                    switch evaluation_conditions{e}{c}
                        case 'proximity-similar'
                                 %group-lin
                                jitter_pos=[1 1];
                                shape_cell={define_rectangle(barlen,barwid),define_rectangle(barlen,barwid)};
                                [I,ycoord,xcoord,~,~,y_coords, x_coords]=image_popout_grouping_anyshape_multiple_xy(gridsize,barlen,barwid,spacing,[0,0],contrast_bw,background_bw,jitter_pos,jitter_angle,[0.25 0.75],[grouping_radius grouping_radius+values(v)],shape_cell,a,b);
                            
                        case 'proximity-dissimilar'
                                %group-lin
                                jitter_pos=[1 1];
                                shape_cell={define_rectangle(barlen,barwid),define_triangle(barlen,barwid)};
                                [I,ycoord,xcoord,~,~,y_coords, x_coords]=image_popout_grouping_anyshape_multiple_xy(gridsize,barlen,barwid,spacing,[0,0],contrast_bw,background_bw,jitter_pos,jitter_angle,[0.25 0.75],[grouping_radius grouping_radius+values(v)],shape_cell,a,b);
                           
                       end
                        Iout=getcorrect_xy(I,[M N]);
                        imwrite(Iout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                        imwrite(Iout,['dataset' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                        Imask=getmask_xy(I,xcoord,ycoord,(grouping_radius+1*2)*spacing,x_coords,y_coords);
                        Imaskout=getcorrect_xy(Imask,[M N]);
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
    
    

