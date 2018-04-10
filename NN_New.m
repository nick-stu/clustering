function [accuracy, net ] = NN_New( trainData, testData, testLabel )
% 使用神经网络

trainData = featureNormalize(trainData);
testData = featureNormalize(testData);
% 生成训练标签
[trainLabel,tag] = getLabelsNew(trainData);

% 训练网络
net = NNTrainNew(trainData, trainLabel,size(tag,2));

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
        if((size(testLabel, 2) == 9 && testLabel(i, index) == 1))% || index  == testLabel(i))
            correctNum = correctNum + 1 ; 
        end
    else
        disp('--------------invalid--------------');
    end
end
accuracy=correctNum / validNum;
fprintf('%.4f\n', correctNum / validNum);