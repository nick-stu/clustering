function[distance,avg]=distanceChange(sample,traindata)
    [num,~]=size(traindata);
    total=pdist2(sample,traindata);
    distance=sum(total(:))/ num;
    if num==1   % ���������ֻ��һ���㣬��ѡȡ����ĵ��������ˣ������ж���ֵ
        avg=0;
    else
        data=[traindata;sample];
        [num,~]=size(data);
        total=pdist2(data,data); % ������ƽ������
        avg = sum(total(:))/(num*(num-1));
    end
end