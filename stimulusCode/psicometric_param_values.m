function [ psycontrast, psycontrast_up, psycontrast_down,psycontrast_updown ,cnum,types] = psicometric_param_values

cfactor=1; %slope of contrast power exponent
cnum=7-1; %number of contrast values to test (N)
contrast=[0:1/cnum:1]; %contrast list
psycontrast=(contrast.^cfactor); %psychometric trial contrast (psi)
for t=1:round(cnum/2+1), types{1,t}='hard'; end; %hard
for t=round(cnum/2+1)+1:cnum+1, types{1,t}='easy'; end; %easy


maxclen=2; %maximum and minimum proportion on increase/decrease percentage (some eval)
minclen=0.5;

psycontrast_up=psycontrast*(maxclen-1)+1;
psycontrast_down=psycontrast*(1-minclen)+minclen;
% psycontrast_updown=psycontrast*(maxclen-minclen)+minclen;
psycontrast_updown_aux=[psycontrast_down,psycontrast_up(2:end)];
psycontrast_updown=psycontrast_updown_aux(1:2:end);


