function l = func_SPfusion(img,sift) %if save_flag ~= 0, save the fusion result

    addpath BOW\
%    savePath = '.\ALLSquareSPFusion\';
    RGBVocabulary_size = 150;
    siftVocabulary_size = 500;
    a1 = 0.475;
    a2 = 0.475;
    a3 = 0.05;

    [siftLabel,RGBLabel] = func_computeBOWlabel(img,sift);

    addpath super_pixel\
    [l,Am,C] = slic(img,100,10,4,'median');

    [~,spixelNum] = size(C);

    iter = 0;
    while 1
        'iteration'
        iter = iter + 1
        spRGBBow = zeros(spixelNum,RGBVocabulary_size);
        spSiftBow = zeros(spixelNum,siftVocabulary_size);
        for n = 1:spixelNum
            spRGB = RGBLabel(l==n);
            spRGBBow(n,:) = hist(spRGB,(1:RGBVocabulary_size));
            
            spSift = siftLabel(l==n);
            spSiftBow(n,:) = hist(spSift,(1:siftVocabulary_size));
        end

        spRGBBow_d = chiSquareDist(spRGBBow);
        siftVocabulary_size_d = chiSquareDist(spSiftBow);

        score = zeros(spixelNum,spixelNum);

        for i = 1:spixelNum
            for j = 1:i
                if full(Am(i,j))
                    score(i,j) = 1 - 1/(a1 + a2 + a3) * (a1 * siftVocabulary_size_d(i,j) + a2 * spRGBBow_d(i,j) + a3 * (C(1,i).N + C(1,j).N));
                end
            end
        end

        [x,y] = find(score == max(max(score(score ~= 0))));
        score(x,y)
        l(l==y(1)) = x(1); % (1) is to pick the first one if exist multy equal
        Am(x(1),y(1)) = 0;
        Am(y(1),x(1)) = 0;
        Am(x(1),:) = Am(x(1),:) + Am(y(1),:);
        Am(y(1),:) = 0;

        if (score(x(1),y(1))>-100) || (iter>30)
            break;
        end
       
    end
    
end
