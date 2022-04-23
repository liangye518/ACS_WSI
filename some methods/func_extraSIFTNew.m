function siftAll = func_extraSIFTNew(org_img)
    scale = 4; %the scale of compute sift 
    oritation = 0; % the oritation of compute sift
    
    [h, w, c] = size(org_img);
    if c == 3
        img_r = double(org_img(:,:,1));
        img_b = double(org_img(:,:,3));
        img = single(img_r ./ img_b);
%        img = single(rgb2gray(org_img));
    else
        img = single(org_img);
    end
    
    siftAll = zeros(h,w,128);
    
    for i = 1:h
        parfor j = 1:w
            [~,d] = vl_sift(img,'frames',[i;j;scale;oritation]);
            siftAll(i,j,:) = d;
        end
    end
    