function [   ] = vsearch_efficiency_scale( evaluation_list )

    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
    [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 2, cnum, gridsize, stimsize );
    [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params('full');
    
    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
        case 'vsearch-efficiency-scale'
            disp(evaluation_list{e});
            mkdir(['dataset_blocks' '/' evaluation_list{e}]);
            evaluation_conditions{e}={'circlebar-circle','circle-circlebar'};
            percgrid_values=psycontrast_updown;
            values=percgrid_values; %perc
            
            scaling=percgrid_values.*stimsize./pxva;
            setsizes=round(gridsize(1)./values).*round(gridsize(2)./values);
            
            evaluation_values{e}=scaling;
            
            for c=1:numel(evaluation_conditions{e})
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                    switch evaluation_conditions{e}{c}
                        case 'circlebar-circle'
                            %lin
                            newimsizefac=((imsizefac*values(v))/1.6);
                            [newbarlen,newbarwid,newspacing]=standard_image_param_values(newimsizefac,crop,1);
                            newgridsize=round(gridsize./values(v));
                            newa=floor(newgridsize(1).*rand)+1;
                            newb=floor(newgridsize(2).*rand)+1;
%                             newgridsize(3)=round(surr_prob*(gridsize(1)./values(end)*gridsize(2)./values(end)));
                            [I,ycoord,xcoord]=image_popout_circle_bars_xy(newgridsize,newbarlen,newbarwid,newspacing,[-90,-90],contrast_bw,background_bw,jitter_pos,jitter_angle,surr_prob,1,newa,newb);
%                             imagesc(I); 
                        case 'circle-circlebar'
                            %lin
                            newimsizefac=((imsizefac*values(v))/1.6);
                            [newbarlen,newbarwid,newspacing]=standard_image_param_values(newimsizefac,crop,1);
                            newgridsize=round(gridsize./values(v));
                            newa=floor(newgridsize(1).*rand)+1;
                            newb=floor(newgridsize(2).*rand)+1;
%                             newgridsize(3)=round(surr_prob*(gridsize(1)./values(end)*gridsize(2)./values(end)));
                            [I,ycoord,xcoord]=image_popout_circle_bars_xy(newgridsize,newbarlen,newbarwid,newspacing,[-90,-90],contrast_bw,background_bw,jitter_pos,jitter_angle,surr_prob,0,newa,newb);
%                             imagesc(I); 
                    end
                    Iout=getcorrect_xy(I,[M N]);
                    imwrite(Iout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                    imwrite(Iout,['dataset' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                    Imask=getmask_xy(I,xcoord,ycoord,newspacing);
                    Imaskout=getcorrect_xy(Imask,[M N]);
                    imwrite(Imaskout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);     
                    imwrite(Imaskout,['dataset' '/' 'masks' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                    
%                   imagesc(imfuse(Iout,Imaskout));

                    %colorparams={repmat(contrast_bw(1),3,1),repmat(background_bw,3,1),repmat(contrast_bw(2),3,1),0,1};
                    %save(['dataset/extra/colorparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'colorparams');

                    %coordparams={a_rand(c,v),b_rand(c,v),y_rand(c,v),x_rand(c,v)};
                    %save(['dataset/extra/coordparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'coordparams');
                end
            end
        
        
    end
    
    
    end

end








        