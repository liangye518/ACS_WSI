Path = '.\SubCloud_use\';
savePath = '.\SubCloud_use_sift\';
list = dir(Path);

run('vlfeat-0.9.21\toolbox\vl_setup.m')

tic
for k = 3:size(list,1)
    k
    img = imread([list(k).folder,'\',list(k).name]);
    sift = func_extraBOWfeaturesNew(img);
    save([savePath,list(k).name(1:end-4),'.mat'],'sift')
end
toc