function [imgRes] = func_round2squareNew(imgRound)

pi = 3.1415926535897;
[row,col,ch] = size(imgRound);

imgRound = imresize(imgRound,[row,row]);
centerIndex = ceil(row/2);
radius = centerIndex;

weight = ceil(2 * pi * radius);
height = ceil(pi * radius / 2);

imgRes = zeros([height,weight,3],'uint8');

mapRound2Square = zeros([height,weight,2],'double');

for iRow = 1:height
    for iCol = 1:weight
        x0 = iCol-1;
        y0 = iRow-1;
        theta = x0/radius;
        alpha = y0/radius;
        y = radius * sin(alpha) * cos(theta);
        x = y * tan(theta);
        coInOriginalImgRow = centerIndex + round(y);
        coInOriginalImgCol = centerIndex + round(x);
        if coInOriginalImgRow < 1 coInOriginalImgRow = 1; end
        if coInOriginalImgRow > row coInOriginalImgRow = row; end
        if coInOriginalImgCol < 1 coInOriginalImgCol = 1; end
        if coInOriginalImgCol > col coInOriginalImgCol = col; end
        
        mapRound2Square(iRow,iCol,1) = coInOriginalImgRow;
        mapRound2Square(iRow,iCol,2) = coInOriginalImgCol;
        imgRes(iRow,iCol,:) = imgRound(coInOriginalImgRow,coInOriginalImgCol,:);
    end
end