tier = string(tier);

bhgr=0;
blph=0;
ocwa=0;
spto2=0;
spto=0;
for i = 1:length(tier)
if tier(i)=='BHGR'
bhgr = bhgr + tmax(i) - tmin(i);
elseif tier(i)=='BLPH'
blph = blph + tmax(i) - tmin(i);
elseif tier(i)=='OCWA'
ocwa = ocwa + tmax(i) - tmin(i);
elseif tier(i)=='SPTO2'
spto2 = spto2 + tmax(i) - tmin(i);
else tier(i)=='SPTO'
spto = spto + tmax(i) - tmin(i);
end
end

singlen=[bhgr, blph, ocwa, spto2, spto];
p_sing = singlen/300

p_nonSing = 1;
for i=1:5
p_nonSing = p_nonSing*(1-p_sing(i));
end

p_oneSing = 0;
for i=1:5
temp = 1;
temp = temp*p_sing(i);
for j=1:5
if j~=i
temp = temp*(1-p_sing(j));
end
end
p_oneSing = p_oneSing+temp;
end
p_overlap = 1-p_nonSing-p_oneSing;
