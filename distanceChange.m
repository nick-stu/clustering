function[distance,avg]=distanceChange(sample,traindata)
    [num,~]=size(traindata);
    total=pdist2(sample,traindata);
    distance=sum(total(:))/ num;
    
    data=[traindata;sample];
    [num,~]=size(data);
	total=pdist2(data,data); % 这里是平均距离
    avg = sum(total(:))/(num*(num-1));
end