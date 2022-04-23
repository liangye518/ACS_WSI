function T = func_computeOtsuT(I)
T = 0;
[h,w] = size(I);
N = h*w;
for i = 0:255
    C = I(I > i);
    S = I(I <= i);
   VT =  (length(C) / N) * (length(S) / N) * (mean(C) - mean(S));
   if VT > T
       T = VT;
   end
end