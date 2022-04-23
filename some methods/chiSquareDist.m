function dist = chiSquareDist(hist)
[n,d] = size(hist);

dist = zeros(n,n);
for i = 1 : n
    for j = 1 : i
        for l = 1 : d
            if ((hist(i,l) ~= 0 ) && ((hist(j,l) ~= 0 )))
                dist(i,j) = dist(i,j) + 0.5 * (hist(i,l) - hist(j,l))^2 /(hist(i,l) + hist(j,l)); 
            end
        end        
    end
end