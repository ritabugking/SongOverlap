singlen=[];
for i=1:length(numTier)
    singlen=[singlen, 0];
end

for i = 1:length(tier)
    for j=1:length(singlen)
        if tier(i)== numTier(j)
            singlen(j) = singlen(j) + tmax(i) - tmin(i);
            break;
        end
    end
end

p_sing = singlen/300;

p_nonSing = 1;
for i=1:length(singlen)
    p_nonSing = p_nonSing*(1-p_sing(i));
end

p_oneSing = 0;
for i=1:length(singlen)
    temp = 1;
    temp = temp*p_sing(i);
    for j=1:length(singlen)
        if j~=i
            temp = temp*(1-p_sing(j));
        end
    end
    p_oneSing = p_oneSing+temp;
end
p_overlap = 1-p_nonSing-p_oneSing;
disp('expected overlap: ')
disp(p_overlap)