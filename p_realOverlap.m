t_overlap=0;
i=1;
a=0;
while(i<length(tier))
if (i+a)<=length(tier)
a=a+1;
while(a~=0)
if tmax(i)>tmin(i+a)
if tmax(i)<tmax(i+a)
t_overlap=t_overlap+tmax(i)-tmin(i+a);
i=i+a-1;
a=0;
else
t_overlap=t_overlap+tmax(i+a)-tmin(i+a);
a=a+1;
end
else
a=0;
end
end
end
i=i+1;
end
p_reOverlap=t_overlap/300;
