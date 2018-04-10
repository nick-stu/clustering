function [accuracy, net ] = NN_New( trainData1,trainData2, testData, testLabel )
% 使用神经网络

% 生成训练标签
rows = size(trainData1, 1);
singleNum = rows / 9;
[trainLabel1,tag1]=getLabelsNew(trainData1,singleNum,3);

rows = size(trainData2, 1);
singleNum = rows / 9;
[trainLabel2,tag2]=getLabelsNew(trainData2,singleNum,3);

trainLabel=[trainLabel1;trainLabel2];
trainData=[trainData1;trainData2];
tag=[tag1 tag2+max(tag1)];
% 训练网络
net = NNTrainNew(trainData, trainLabel);

% 仿真
Y = sim( net , testData' );

% 统计识别正确率
validNum = 0;
correctNum = 0;
s = size(Y, 2);
for i = 1 : s
    [m , index] = max(Y( : , i));
    if m > 0
        index=tag(index);
        validNum = validNum + 1;
        if((size(testLabel, 2) == 9 && testLabel(i, index) == 1) || index  == testLabel(i))
            correctNum = correctNum + 1 ; 
        end
    else
        disp('--------------invalid--------------');
    end
end
accuracy=correctNum / validNum;
fprintf('%.4f\n', correctNum / validNum);