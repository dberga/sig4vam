function  Sq  = RMSroughness(T)

T = T -mean(T(:));
n=size(T(:),1);
T = T.^2;
Sq = sqrt(sum(sum(T))./n);
end