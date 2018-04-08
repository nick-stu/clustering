clear; clc;
warning off;
addpath(genpath(pwd));
basePath = './大力小力/';
dirs = dir(basePath);
begin=30*0 + 1;
tail=begin+29;
for x=1:size(dirs, 1)
    if (dirs(x).name(1) == '.')
        continue;
    end
    fprintf('%s-> ', dirs(x).name);
    
    load([basePath, dirs(x).name, '/hard/harddecimate_data_0.6k.mat']);
    hard = decimate_data(begin:tail, :);
    load([basePath, dirs(x).name, '/gentle/gentledecimate_data_0.6k.mat']);
    gentle = decimate_data(begin:tail, :);
    data=[hard;gentle];
    mdl=clustering_dis(data);
%     densityTest(data);
    pcaPlot(data,3,mdl.label);
end