function [  ] = vsearch_asymmetry_color( evaluation_list)


    %default parameters
    [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values;
    [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown cnum,types] = psicometric_param_values;
    [barlen,barwid,spacing]=standard_image_param_values(imsizefac,crop,1);
    [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( 4, cnum, gridsize, stimsize );
    [jitter_pos,jitter_angle,surr_prob,background_bw,contrast_bw]=displacement_params;
    
    %experiment
    for e=1:numel(evaluation_list)
        switch evaluation_list{e}
        case 'vsearch-asymmetry-color'
            disp(evaluation_list{e});
            mkdir(['dataset_blocks' '/' evaluation_list{e}]);
            evaluation_conditions{e}={'rT-wB','bT-wB','rT-rrB','bT-rrB'};
            values=psycontrast; 
            evaluation_values{e}=psycontrast;
            theta=zeros(numel(psycontrast),1); %angle
            for c=1:numel(evaluation_conditions{e})
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c}]);
                mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'masks']);
                %mkdir(['dataset_blocks' '/' evaluation_list{e} '/' evaluation_conditions{e}{c} '/' 'smaps']);
                for v=1:numel(evaluation_values{e}), a=a_rand(c,v); b=b_rand(c,v);
                    switch evaluation_conditions{e}{c}
                        case 'rT-wB'
                        %more contrast=more red
                        target_rgb=[1 0.5 0.5]';
                        background_rgb=[0.5 0.5 0.5]';
                        [distractor_rgb,theta(v),Sdiff(v)]=getX_RGB_isoluminant_isohue(background_rgb,target_rgb,values(v));
                        contrast_rgb=[target_rgb,distractor_rgb];
                        shape=define_circ(barlen,barwid);
                        [I,ycoord,xcoord]=image_popout_anyshape_color_xy(gridsize,barlen,barwid,spacing,[0,0],contrast_rgb,background_rgb,jitter_pos,jitter_angle,surr_prob,shape,a,b);

                       case 'bT-wB'
                        %more contrast=more red
                        target_rgb=[0.5 0.5 1]';
                        background_rgb=[0.5 0.5 0.5]';
                        [distractor_rgb,theta(v),Sdiff(v)]=getX_RGB_isoluminant_isohue(background_rgb,target_rgb,values(v));
                        contrast_rgb=[target_rgb,distractor_rgb];
                        shape=define_circ(spacing,spacing);
                        [I,ycoord,xcoord]=image_popout_anyshape_color_xy(gridsize,barlen,barwid,spacing,[0,0],contrast_rgb,background_rgb,jitter_pos,jitter_angle,surr_prob,shape,a,b);

                       case 'rT-rrB'
                        %more contrast=less blue
                        target_rgb=[1 0.5 0.5]';
                        background_rgb=[1 0 0]';
                        [distractor_rgb,theta(v),Sdiff(v)]=getX_RGB_isoluminant_isohue(background_rgb,target_rgb,values(v));
                        contrast_rgb=[target_rgb,distractor_rgb];
                        shape=define_circ(spacing,spacing);
                        [I,ycoord,xcoord]=image_popout_anyshape_color_xy(gridsize,barlen,barwid,spacing,[0,0],contrast_rgb,background_rgb,jitter_pos,jitter_angle,surr_prob,shape,a,b);

                       case 'bT-rrB'
                        %more contrast=less red
                        target_rgb=[0.5 0.5 1]';
                        background_rgb=[1 0 0]';
                        [distractor_rgb,theta(v),Sdiff(v)]=getX_RGB_isoluminant_isohue(background_rgb,target_rgb,values(v));
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
                
%               imagesc(imfuse(Iout,Imaskout));

                B_rgb{c}=background_rgb;
                T_rgb{c}=target_rgb;
                D_rgb{c}(v,:)=distractor_rgb;
                
%                 coordparams={a_rand(c,v),b_rand(c,v),y_rand(c,v),x_rand(c,v)};
%                 save(['dataset/extra/coordparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'coordparams');
%                   colorparams={target_rgb,background_rgb,distractor_rgb,theta(v),Ldiff,target_lsY,background_lsY,distractor_lsY};
%                   save(['dataset/extra/colorparams_' evaluation_list{e} '_' evaluation_conditions{e}{c} '_' strrep(num2str(evaluation_values{e}(v)),'.','p') '.mat'],'colorparams');
                    
                end
                

                plot_BTD(B_rgb{c},T_rgb{c},D_rgb{c},evaluation_conditions{e}{c},'hsl&lsY');
                savefig(['dataset/extra/' evaluation_conditions{e}{c} '_hsl_lsY.fig']);
                fig2png(['dataset/extra/' evaluation_conditions{e}{c} '_hsl_lsY.fig'],['dataset/extra/' evaluation_conditions{e}{c} '_hsl_lsY.png']);
                
                
                close all
            end
    end

end

