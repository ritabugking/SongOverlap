tier = string(tier);

spto=0;
ocwa=0;
nawa=0;
bhgr=0;
bhcb=0;
oth = 0;
for i = 1:length(tier)
if tier(i)=='SPTO'
spto = spto + tmax(i) - tmin(i);
elseif tier(i)=='OCWA'
ocwa = ocwa + tmax(i) - tmin(i);
elseif tier(i)=='BLPH'
nawa = nawa + tmax(i) - tmin(i);
elseif tier(i)=='BrownHeadedCowbird'
bhcb = bhcb + tmax(i) - tmin(i);
elseif tier(i)=='AlarmCall'
oth = oth + tmax(i) - tmin(i);
else tier(i)=='BHGR'
bhgr = bhgr + tmax(i) - tmin(i);
end
end

singlen=[spto, ocwa, nawa, bhgr, bhcb, oth];
p_sing = singlen/300

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
