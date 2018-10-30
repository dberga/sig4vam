function [imsizefac,crop,max_radius,sigma,stimsize,M,N,pxva,dva,gridsize]=common_param_values

M=1024;
N=1280;
pxva=40; %number of pixels for 1 dva, calculated as (screensize/pix)*distance*tand(1)
dva=2.5; %stimulus and spacing
pxstim=pxva*dva;

stimsize=pxstim; 
gridsize=round([M/stimsize N/stimsize]);

imsizefac=stimsize/1.6;
sigma=ceil([imsizefac/1.6]);
crop=ceil(5*max(sigma));
max_radius=ceil(5*max(sigma))+1;

