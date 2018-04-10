function[distance,avg]=distanceChange(sample,traindata)
    [num,~]=size(traindata);
    total=pdist2(sample,traindata);
    distance=sum(total(:))/ num;
    if num==1   % 如果已有类只有一个点，那选取最近的点加入就行了，不用判断阈值
        avg=0;
    else
%         data=[traindata;sample]; % 这里是平均距离
%         [num,~]=size(data);
%         total=pdist2(data,data); 
%         avg = sum(total(:))/(num*(num-1));
        avg=distance; % 这里是点与类的平均距离
    end
end