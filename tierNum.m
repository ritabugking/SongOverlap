tier = string(tier);
numTier = [];
flag = 1;
for i=1:size(tier,1)
    if size(numTier,2)==0
        numTier = [numTier, tier(i)];
    else
        for j=1:size(numTier,2)
            if tier(i)==numTier(j)
                flag = 0;
                break;
            end
        end
        if flag == 1
            numTier = [numTier, tier(i)];
        end
        flag=1;
    end
end