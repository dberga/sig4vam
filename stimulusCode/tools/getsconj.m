function [ sconj ] = getsconj( gridsize, surr_prob )

rows=gridsize(1);
cols=gridsize(2);
if numel(gridsize)>2
    snum=gridsize(3);
else
    snum=round((gridsize(1)*gridsize(2))*surr_prob);
end

sconj=rand(gridsize(1),gridsize(2));

% while sum(sum(sconj<=surr_prob)) ~= sum(snum)
%     sconj=rand(gridsize(1),gridsize(end));
% end

diff=sum(sum(sconj<=surr_prob))-sum(snum);
while diff ~= 0
     if diff < 0
        coords=find(sconj>surr_prob);
        sconj(coords(1:-diff))=(rand(-diff,1).*(1-surr_prob));
     else if diff > 0
         coords=find(sconj<surr_prob);
         sconj(coords(1:diff))=surr_prob+(rand(diff,1)*(1-surr_prob));
         end
     end
     diff=sum(sum(sconj<=surr_prob))-sum(snum);
end

end

