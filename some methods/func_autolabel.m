function labels = func_autolabel(img)
img_r = double(img(:,:,1));
img_b = double(img(:,:,3));
If = (img_r + 1)./ (img_b + 1);
If = (If - min(min(If)))/(max(max(If) - min(min(If)))) * 255;
T = func_computeOtsuT(If);

C_hard = If(If > 1.3 * T);
S_hard = If(If < T / 1.3);

[height,width] = size(If);
N = height * width;

disp('building graph');
E = edges4connected(height,width);
V = exp(-(power(abs(If(E(:,1))-If(E(:,2))),2))/(2 * 0.3^2));
A = sparse(E(:,1),E(:,2),V,N,N,4*N);

If_S = If(:);
dis = zeros(N,2);
for i = 1:length(If_S)
    dis(i,1) = min(abs(C_hard - If_S(i)));
    dis(i,2) = min(abs(S_hard - If_S(i)));
end

T = sparse([1:N;1:N]',[ones(N,1);ones(N,1)*2], dis(:));

disp('calculating maximum flow');

[flow,labels] = maxflow(A,T);
labels = reshape(labels,[height width]);