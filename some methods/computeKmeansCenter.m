Path = './samples';
class_mun = 150;
dataType = 'RGB'; %'sift' or 'RGB'
list = dir(Path);
template = ones(501,501);
for i = 1:501
    for j = 1:501
        if (i-251)^2 + (j-251)^2 > 250^2
            template(i,j) = 0;
        end
    end
end
template = cat(3,template,template,template);

if strcmp(dataType,'sift')
    feature = load([list(3).folder,'/',list(3).name],dataType);
    [h,w,c] = size(feature.sift);
    AllFeature = reshape(feature.sift,h*w,c);
elseif strcmp(dataType,'RGB')
    feature = imread([list(3).folder,'/',list(3).name]);
    AllFeature = double(feature(template == 1));
%    [h,w,c] = size(feature);
%    AllFeature = double(reshape(feature,h*w,c));
end


for k = 4:size(list)
    k
    if strcmp(dataType,'sift')
        feature = load([list(k).folder,'/',list(k).name],dataType);
        [h,w,c] = size(feature.sift);
        feature = reshape(feature.sift,h*w,c);        
    elseif strcmp(dataType,'RGB')
        feature = imread([list(k).folder,'/',list(k).name]);
        feature = double(feature(template == 1));
%        [h,w,c] = size(feature);
%        feature = double(reshape(feature,h*w,c));
    end
    
    AllFeature = [AllFeature;feature];
    
end

[idx,C] = kmeans(AllFeature,class_mun);
save([dataType,'Center'],'C')