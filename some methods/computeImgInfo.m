PathRoot='.\ALL';  %data file
same_imageSize = 1     %is the image at the same size?
list=dir(PathRoot);  
image_num = size(list,1)-2
r = image_num;

if ~same_imageSize
    l = zeros(image_num); %存每张图的大小，图片大小不相等的情况下
else
    img = imread([list(3).folder,'\',list(3).name]);
    [H,W]=size(img(:,:,1));
    l = H*W;
end
data_mean = zeros(r ,3);
data_var = zeros(r ,3); 

for k=3:size(list,1)  
    a = k - 2
    img = imread([list(k).folder,'\',list(k).name]);
    
    img_c1 = double(img(:,:,1))/255;
    img_c2 = double(img(:,:,2))/255;
    img_c3 = double(img(:,:,3))/255;
    
    if ~same_imageSize
        [H,W]=size(img_c1);
        ln = H*W;
        l(k-2) = ln;
    end
    
    data_mean(k-2,1) = mean2(img_c1);
    data_mean(k-2,2) = mean2(img_c2);
    data_mean(k-2,3) = mean2(img_c3);
    
    data_var(k-2,1) = (std2(img_c1))^2;
    data_var(k-2,2) = (std2(img_c2))^2;
    data_var(k-2,3) = (std2(img_c3))^2;
end

data_c1_mean = mean(data_mean(:,1))
data_c2_mean = mean(data_mean(:,2))
data_c3_mean = mean(data_mean(:,3))

Sa1=0;
Sa2=0;
Sa3=0;
if ~same_imageSize
    for n = 1:r
        Sa1 = Sa1 + l(n) * r * (std(data_mean(:,1)))^2;
        Sa2 = Sa2 + l(n) * r * (std(data_mean(:,2)))^2;
        Sa3 = Sa3 + l(n) * r * (std(data_mean(:,3)))^2;
        
        Se1 = Sa1 + l(n) * data_var(n,1);
        Se2 = Sa2 + l(n) * data_var(n,2);
        Se3 = Sa3 + l(n) * data_var(n,3);
    end
else
    Sa1 = l * r * (std(data_mean(:,1)))^2;
    Sa2 = l * r * (std(data_mean(:,2)))^2;
    Sa3 = l * r * (std(data_mean(:,3)))^2;
    
    Se1 = l * sum(data_var(:,1));
    Se2 = l * sum(data_var(:,2));
    Se3 = l * sum(data_var(:,3));
end

St1 = (Sa1 + Se1)/(l*r);
St2 = (Sa2 + Se2)/(l*r);
St3 = (Sa3 + Se3)/(l*r);

str1 = St1^0.5
str2 = St2^0.5
str3 = St3^0.5