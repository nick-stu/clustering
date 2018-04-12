clear; clc;
warning off;
addpath(genpath(pwd));
basePath = './����С��/';
dirs = dir(basePath);
begin=30*8 + 1;
tail=begin+29;
for x=1:size(dirs, 1)
    if (dirs(x).name(1) == '.')
        continue;
    end
    fprintf('%s-> ', dirs(x).name);
    
    load([basePath, dirs(x).name, '/hard/hard_decimatedata_0.6k_withPSD.mat']);
    hard = decimate_data(begin:tail, :);
    load([basePath, dirs(x).name, '/gentle/gentle_decimatedata_0.6k_withPSD.mat']);
    gentle = decimate_data(begin:tail, :);
    data=[hard;gentle];
    %% �Ƿ��һ��
    originData=data;
    data=featureNormalize(data);% ��һ��
    mdl=clustering_dis(data);
%     densitySituation(data);
    pcaPlot(originData,3,mdl.label);
end