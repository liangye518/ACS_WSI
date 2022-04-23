filePath = '.\DataSet_HZ2013-v2\matGroundTruth_Type\';
savePath = '.\DataSet_HZ2013-v2\matInternalSquareGroundTruth_Type\';

fileList = dir(filePath);
dataType = fileList(3).name(end-2:end);

for i = 3 : length(fileList)
    if strcmp(dataType,'jpg')
        data = imread([fileList(i).folder,'\',fileList(i).name]);
    elseif strcmp(dataType,'mat')
        data = load([fileList(i).folder,'\',fileList(i).name]);
        data = data.matGT_Type;
    end
    
    internalData = data(74:428,74:428,:);
    
    if strcmp(dataType,'jpg')
        imwrite(internalData,[savePath,fileList(i).name]);
    elseif strcmp(dataType,'mat')
        matGT_Type = internalData;
        save([savePath,fileList(i).name],'matGT_Type');
    end
end