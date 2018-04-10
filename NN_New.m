function [accuracy, net ] = NN_New( trainData, testData, testLabel )
% ʹ��������

trainData = featureNormalize(trainData);
testData = featureNormalize(testData);
% ����ѵ����ǩ
[trainLabel,tag] = getLabelsNew(trainData);

% ѵ������
net = NNTrainNew(trainData, trainLabel,size(tag,2));

% ����
Y = sim( net , testData' );

% ͳ��ʶ����ȷ��
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