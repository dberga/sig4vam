function [ ] = fview_contourintegration( evaluation_list )

    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
    [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 2, cnum, gridsize, stimsize );
    [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params('full');
    
    %original coords
    a_rand=[5,5,4,8,2,4,8];
    b_rand=[10,10,8,6,4,10,10];

    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
        case 'fview-contourintegration'
            disp(evaluation_list{e});
            mkdir(['dataset_blocks' '/' evaluation_list{e}]);
            evaluation_conditions{e}={'default'};
            percgrid_values=psycontrast;
            values=floor((percgrid_values.*0.5.*(gridsize(2)-2)))+1; %clen
            evaluation_values{e}=values.*2+1; %desired values
            plus=intersect(find(values*2>gridsize(2)*0.5), find(b_rand~=floor(gridsize(2)*0.5)));
            evaluation_values{e}(plus)=evaluation_values{e}(plus)-1;    
            mindist=min([abs(b_rand);abs(b_rand-gridsize(2))]);
            evaluation_values{e}(plus)=evaluation_values{e}(plus)+fix(mindist(plus)-((evaluation_values{e}(plus)-1)*0.5)); %real values, according to contour outside gridsize
                        
            for c=1:numel(evaluation_conditions{e})
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                    switch evaluation_conditions{e}{c}
                        case 'default'
                            [I,ycoord,xcoord]=image_contour_xy(gridsize,barlen,barwid,spacing,[0],values(v),contrast_bw,background_bw,jitter_pos,jitter_angle,surr_prob,a,b);
                            %imagesc(I);
                    end
                    Iout=getcorrect_xy(I,[M N]);
                    imwrite(Iout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                    imwrite(Iout,['dataset' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                    Imask=getmask_contour_xy(I,gridsize, barlen, spacing,values(v),a,b);
                    Imaskout=getcorrect_xy(Imask,[M N]);
                    imwrite(Imaskout,['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks/' strrep(num2str(evaluation_values{e}(v)),'.','p') '.png']);
                    imwrite(Imaskout,['dataset' '/' 'masks' '/' types{1,v} '_' getname_dataset(evaluation_list{e}, evaluation_conditions{e}{c}, strrep(num2str(evaluation_values{e}(v)),'.','p'),'png')]);
                    
                    %colorparams={repmat(contrast_bw(1),3,1),repmat(background_bw,3,1),repmat(contrast_bw(2),3,1),0,1};
                    %save(['dataset/extra/colorparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'colorparams');

                    %imagesc(imfuse(Iout,Imaskout));
                    
                    %coordparams={a_rand(c,v),b_rand(c,v),y_rand(c,v),x_rand(c,v)};
                    %save(['dataset/extra/coordparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'coordparams');
                end
            end
    end
    
    
    end

end








        
