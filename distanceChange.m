function[ratio,distance]=distanceChange(sample,traindata)
    [num,~]=size(traindata);
    total=pdist2(sample,traindata);
    distance=sum(total(:))/ num;
    if num==1
        ratio=distance;
    else
        total=pdist2(traindata,traindata);
        density1 = sum(total(:))/(num*(num-1));
        total=pdist2([sample;traindata],[sample; traindata]);
        density2 = sum(total(:))/(num*(num+1));
        
        ratio=density1/density2;
        ratio=abs(ratio-1);
    end
end