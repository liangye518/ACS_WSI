addpath .\super_pixel
addpath .\maxflow

imgPath = '.\ALLSquare\';
siftPath = '.\ALLSquare_sift\';
gtPath = '.\ALLSquareGT\';

RGBVocabulary_size = 150;
siftVocabulary_size = 500;



list = dir(imgPath);
for i = 3 : 3%length(list)
    i
    %read img , RGB_bow label, get sift feature and gt
    img = imread([list(i).folder,'\',list(i).name]);
    img_bowLabel = func_computeBOWlabel(img);
    sift = load([siftPath,list(i).name(1:end-4),'.mat'],'sift');
    gt = load([gtPath,list(i).name(1:end-4)]);
    gt = gt.matGT_Seg;
    
    %fusion SP use sift and RGB
    l = func_SPfusion(img,sift.sift,list(i).name,1);
end