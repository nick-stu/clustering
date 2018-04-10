function[trainLabel,tag]=getLabelsNew(trainData)
    rows = size(trainData, 1);
    singleNum = rows / 9;
    tag=[]; trainLabel=[];
    cursor=0;
    for i = 1:9
        mdl=clustering_dis( trainData( (i-1)*singleNum+1 : i*singleNum,:) );
        label=zeros(singleNum,rows);
        for j=1:singleNum
            label(j,mdl.label(j)+cursor)=1; 
        end
        cursor=cursor+mdl.classNum;
        tag=[tag repmat(i,[1,mdl.classNum])];
        trainLabel=[trainLabel;label];
    end
    trainLabel(:, find( sum(trainLabel,1)==0) )=[];
end