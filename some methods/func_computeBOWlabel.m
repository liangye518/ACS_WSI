function [BOW_RGB_label,BOW_sift_label] = func_computeBOWlabel(img,sift) 
    Esift = 1;
    if (nargin < 2)
            Esift = 0;
    end
    addpath BOW/
    if Esift ~= 0
        siftCenter = load('siftCenter.mat','C');
        siftCenter = siftCenter.C;
        
        [h1,w1,c1] = size(sift);
        sift = reshape(sift,h1*w1,c1);    
        d_sift = EuclideanDistance(sift,siftCenter);
        [~,index1] = min(d_sift,[],2);
        BOW_sift_label = reshape(index1,h1,w1);
    else
        BOW_sift_label = 0;
    end
    
    RGBCenter = load('RGBCenter.mat','C');
    RGBCenter = RGBCenter.C;

    RGB = single(img);

    [h2,w2,c2] = size(RGB);
    RGB = reshape(RGB,h2*w2,c2);
    d_RGB = EuclideanDistance(RGB,RGBCenter);
    [~,index2] = min(d_RGB,[],2);
    BOW_RGB_label = reshape(index2,h2,w2);
end


