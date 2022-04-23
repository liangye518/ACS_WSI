Path = '.\DataSet_ZJLA\OriImg\';
savePath = '.\DataSet_ZJLA\ImgCut\';
list = dir(Path);

for k = 3:size(list,1)
    img = imread([list(k).folder,'\',list(k).name]);
    img_r = func_round2squareNew(img);
    
    subImg1 = img_r(1:170,1:263,:);
    subImg2 = img_r(1:170,264:526,:);
    subImg3 = img_r(1:170,527:789,:);
    subImg4 = img_r(1:170,790:1052,:);
    subImg5 = img_r(1:170,1053:1315,:);
    subImg6 = img_r(1:170,1316:1578,:);
    
    subImg7 = img_r(171:340,1:263,:);
    subImg8 = img_r(171:340,264:526,:);
    subImg9 = img_r(171:340,527:789,:);
    subImg10 = img_r(171:340,790:1052,:);
    subImg11 = img_r(171:340,1053:1315,:);
    subImg12 = img_r(171:340,1316:1578,:);
    
    imwrite(subImg1,[savePath,list(k).name(1:(length(list(k).name)-4)),'01.jpg'])
    imwrite(subImg2,[savePath,list(k).name(1:(length(list(k).name)-4)),'02.jpg'])
    imwrite(subImg3,[savePath,list(k).name(1:(length(list(k).name)-4)),'03.jpg'])
    imwrite(subImg4,[savePath,list(k).name(1:(length(list(k).name)-4)),'04.jpg'])
    imwrite(subImg5,[savePath,list(k).name(1:(length(list(k).name)-4)),'05.jpg'])
    imwrite(subImg6,[savePath,list(k).name(1:(length(list(k).name)-4)),'06.jpg'])
    imwrite(subImg7,[savePath,list(k).name(1:(length(list(k).name)-4)),'07.jpg'])
    imwrite(subImg8,[savePath,list(k).name(1:(length(list(k).name)-4)),'08.jpg'])
    imwrite(subImg9,[savePath,list(k).name(1:(length(list(k).name)-4)),'09.jpg'])
    imwrite(subImg10,[savePath,list(k).name(1:(length(list(k).name)-4)),'10.jpg'])
    imwrite(subImg11,[savePath,list(k).name(1:(length(list(k).name)-4)),'11.jpg'])
    imwrite(subImg12,[savePath,list(k).name(1:(length(list(k).name)-4)),'12.jpg'])
end
