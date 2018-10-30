function [ I, mask ] = image_corner( Icorner, Imask, M, N , jitter_x)
if nargin < 5, jitter_x=0; end

%size of Icorner should be the same as Imask
prop=M/N;

[cM,cN]=size(Icorner);
Mdiff=M-cM;
Ndiff=N-cN;

cprop=cM/cN;

%resize (conserving M/N proportions to save same angle)
Icorner=imresize(Icorner,[M round(M/cprop)]); 
Imask=imresize(Imask,[M round(M/cprop)]); 
[cM,cN]=size(Icorner);
Mdiff=M-cM;
Ndiff=N-cN;

I=zeros(M,N);
if mod(Ndiff,2) %odd diff
    limleft=floor(Ndiff/2)+1+jitter_x;
    limright=N-limleft+jitter_x+jitter_x;
    I(:,1:limleft-1)=repmat(Icorner(:,1),1,limleft-1);
    I(:,limright+1:end)=repmat(Icorner(:,1),1,N-limright);
    
    I(:,limleft:limright)=Icorner;
else %even diff
    limleft=Ndiff/2+1+jitter_x;
    limright=N-limleft+jitter_x+jitter_x;
    I(:,1:limleft-1)=repmat(Icorner(:,1),1,limleft-1);
    I(:,limright+1:end)=repmat(Icorner(:,1),1,N-limright);
    
    I(:,limleft:limright)=Icorner;
end

mask=zeros(M,N);
if mod(Ndiff,2) %odd diff
    limleft=floor(Ndiff/2)+1+jitter_x;
    limright=N-limleft+jitter_x+jitter_x;
    mask(:,1:limleft-1)=repmat(Imask(:,1),1,limleft-1);
    mask(:,limright+1:end)=repmat(Imask(:,1),1,N-limright);
    
    mask(:,limleft:limright)=Imask;
else %even diff
    limleft=Ndiff/2+1+jitter_x;
    limright=N-limleft+jitter_x+jitter_x;
    mask(:,1:limleft-1)=repmat(Imask(:,1),1,limleft-1);
    mask(:,limright+1:end)=repmat(Imask(:,1),1,N-limright);
    
    mask(:,limleft:limright)=Imask;
end

end

