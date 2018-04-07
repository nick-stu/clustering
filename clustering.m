function [ mdl ] = clustering( data )
% ��ֵ���������������Ƿ����
% mdl.data: �����ѵ������
% mdl.label: �����ѵ�������ķ���
% mdl.classNum: ������γɵ��������

    mdl.data = data;

    num = size(data, 1);
    label = zeros(1, num);
    pre_index = zeros(1, num); % �����ǩ�����ݵĶ�Ӧ��ϵ
    dis = zeros(1, num);
    p_label = 1:num;

    %% �ҳ�����������С��������
    D = pdist2(data, data);
    D(D == 0) = Inf;
    [d, i] = min(D);
    [~, index] = min(d);
    index = i(index);
    % ���������е�����һ�����뵽 finded ������
    finded = data(index, :);
    data(index, :) = [];
    pre_index(index) = 1;
    p_label(index) = [];

    %% �� finded �����еĵ���ʣ�������������룬�ҳ���С���룬�������Ҳ���뵽 finded ������
    for i=2:num
        min_d = Inf;
        for j=1:size(data, 1)
            [~, d] = nearest(data(j, :), finded);
            if d(1) < min_d
                min_d = d(1);
                min_i = j;
            end
        end
        dis(i) = min_d;
        finded = [finded; data(min_i, :)];
        data(min_i, :) = [];
        pre_index(p_label(min_i)) = i;
        p_label(min_i) = [];
    end

    %% ����
    % �Ƚ�һ��Ϊͬһ������
    % 1. ������ֵ(ƽ������ + ����)
    % 2. ����һ���ľ���С
    threshold = mean(dis(2 : end)) + std(dis(2 : end));
    classNum = 1;
    label(1) = 1;
    label(2) = 1;
    for i=3:num
        if dis(i) <= threshold || dis(i) / dis(i - 1) < 1
            label(i) = label(i - 1);
        else
            classNum = classNum + 1;
            label(i) = classNum;
        end
    end
    dis(1) = dis(2);
    figure;
    plot(dis);
    hold on;
    plot([0, num + 1], [threshold, threshold]);
    xlim([0, num + 1]);
    % plot label
    for i=1:num
        text(i, dis(i), num2str(find(pre_index==i) ));
    end
    data = finded;
    %% �ϲ�������
    for i=1:classNum
        index = find(label == i);
        if size(index, 2) == 0
            continue
        end
        
        data1 = data(index, :);
        min_d = Inf;
        min_j = 0;
        for j=1:classNum
            if i == j
                continue
            end
            index = find(label == j);
            if size(index, 2) < size(data1, 1)
                continue
            end
            data2 = data(index, :);
            d1 = mean(pdist(data2));
            d2 = mean(pdist([data1; data2]));
            if d2 / d1 < min_d
                min_d = d2 / d1;
                min_j = j;
            end
        end
%         fprintf('%d %d %.4f %d\n', i, min_j, min_d, sum(label == i));
        if min_d < 1.05
            label(label == i) = min_j;
        end
    end
    
    %% �ָ����ںϲ��ർ�µ� label ������
    maxClassNum = max(label);
    classNum = 0;
    for i=1:maxClassNum
        index = find(label == i);
        if size(index, 2) > 0
            classNum = classNum + 1;
            label(index) = classNum;
        end
    end

    %% ��ͼ���·����׼ȷ��
%     dis(1) = dis(2);
%     figure;
%     plot(dis);
%     hold on;
%     plot([0, num + 1], [threshold, threshold]);
%     xlim([0, num + 1]);
%     % plot label
%     for i=1:num
%         text(i, dis(i), num2str(label(i)));
%     end
    
    %% �ָ���ǩ�� data �Ķ�Ӧ��ϵ
    label = label(pre_index);
    %% �鿴����Ч��
    figure;
    scatter(1:num,label); 
    ylim([0,classNum+1]);
    
    mdl.label = label;
    mdl.classNum = classNum;
    
end