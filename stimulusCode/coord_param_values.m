function [ a_rand, b_rand, y_rand, x_rand ] = coord_param_values( cond_num, cnum, gridsize, stimsize )


   
a_rand=ceil((gridsize(1)-3).*rand(cond_num,cnum+1)+1); %random positions on grid
b_rand=ceil((gridsize(2)-3).*rand(cond_num,cnum+1)+1);  %random positions on grid
y_rand=round(a_rand*stimsize+(stimsize*0.5));
x_rand=round(b_rand*stimsize+(stimsize*0.5));

% coords={a_rand,b_rand,y_rand,x_rand};


% for coo=1:cnum+1
% coords_cell{coo,1}=a_rand(coo);
% coords_cell{coo,2}=b_rand(coo);
% end
% w_csv(coords_cell,['dataset/extra/' 'coords.csv']);

end

