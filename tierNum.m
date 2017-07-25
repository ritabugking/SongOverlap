tier = string(tier);
numTier = [];
flag = 1;
for i=1:length(tier)
    if length(numTier)==0
        numTier = [numTier, tier(i)];
    else
        for j=1:length(numTier)
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