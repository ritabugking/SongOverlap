
% tierNum.m
tier2 = string(tier);
numTier = [];
flag = 1;
for i=1:size(tier2,1)
    if size(numTier,2)==0
        numTier = [numTier, tier2(i)];
    else
        for j=1:size(numTier,2)
            if tier2(i)==numTier(j)
                flag = 0;
                break;
            end
        end
        if flag == 1
            numTier = [numTier, tier2(i)];
        end
        flag=1;
    end
end
% p_realOverlap.m
t_overlap=0;
i=1;
a=0;
time = 0;
while(i<size(tier,1))
    if (i+a)<=size(tier,1)
        a=a+1;
    end    
    while(a~=0)
        if (i+a)<=size(tier,1)      
            if tmax(i)>tmin(i+a)
                if tmax(i)<tmax(i+a)
                    if tmin(i+a)>time
                        t_overlap=t_overlap+tmax(i)-tmin(i+a);
                        time = tmax(i);
                    elseif tmax(i)>time
                        t_overlap=t_overlap+tmax(i)-time;
                        time = tmax(i);
                    else
                        time = time;
                    end
                    i=i+a-1;
                    a=0;
                else
                    if tmin(i+a)>time
                        t_overlap=t_overlap+tmax(i+a)-tmin(i+a);
                        time = tmax(i+a);
                    elseif tmax(i+a)>time
                        t_overlap=t_overlap+tmax(i+a)-time;
                        time = tmax(i+a);
                    else
                        time = time;
                    end
                    a=a+1;
                end
            else
                a=0;
            end
        else
            break;
        end        
    end
    i=i+1;
end
p_Overlap=t_overlap/300;
% disp('realized overlap: ')
% disp(p_reOverlap)

% tierNum.m
nullOverlap=[];
for k=1:1000
    
tier2 = string(tier);
numTier = [];
flag = 1;
for i=1:size(tier2,1)
    if size(numTier,2)==0
        numTier = [numTier, tier2(i)];
    else
        for j=1:size(numTier,2)
            if tier2(i)==numTier(j)
                flag = 0;
                break;
            end
        end
        if flag == 1
            numTier = [numTier, tier2(i)];
        end
        flag=1;
    end
end

% shuffle 1000 times

% shuffleOneSeries.m
s=zeros(size(tier2,1)+1,size(numTier,2));
e=zeros(size(tier2,1)+1,size(numTier,2));
si=zeros(size(tier2,1)+1,size(numTier,2));
ei=zeros(size(tier2,1)+1,size(numTier,2));

for j=1:size(numTier,2) % seperate singing time of different tier into different column   
index=1;
    for i=1:size(tier2,1)

    
        if tier2(i)==numTier(j)
            s(index,j)=tmin(i);    
            e(index,j)=tmax(i);
            index=index+1;
        end
    end
end

% build the interval matrix
for i=1:size(numTier,2)
index2=1;    
    if s(1,i)~=0
        si(index2,i)=0;
        ei(index2,i)=s(1,i);
        index2=index2+1;
    end
    

    for j=1:find(s(:,i),1,'last')-1 % to the last non-zero number of the column
        si(index2,i)=e(j,i);
        ei(index2,i)=s(j+1,i);
        index2=index2+1;
    end

    if e(find(s(:,i),1,'last'),i)~=300
        si(index2,i)=e(find(s(:,i),1,'last'),i);
        ei(index2,i)=300;   
    end
end


ns=zeros(size(tier2,1)+1,size(numTier,2));
ne=zeros(size(tier2,1)+1,size(numTier,2));
duration=e-s;
duration_i=ei-si;
%if interval happened first
for i=1:size(numTier,2)
    time=0;  % shuffle song & iterval, create a new song series 
    index3=1;
    tempd=duration(1:find(duration(:,i),1,'last'),i);
    tempdi=duration_i(1:find(duration_i(:,i),1,'last'),i);
    while (size(tempd,2)>0 && size(tempdi,2)>0)
        rn=randi(size(tempdi,1));
        time=time+tempdi(rn);
        ns(index3,i)=time;
        tempdi(rn)=[];
        rn=randi(size(tempd,1));
        time=time+tempd(rn);
        ne(index3,i)=time;
        tempd(rn)=[];
        index3=index3+1;
    end    
end

% combine all seperate tier into original in order
length=size(tmin,1);
tmin2=[]; tmax2=[]; tier2=[];
for i=1:length
    if(sum(ns(1,:)==0)~=0)
        n=find(ns(1,:)==0);
        ns(:,n)=[];ne(:,n)=[];numTier(:,n)=[];
    end
    if (size(ns,2)==0)
        break;
    end
    num = find(ns(1,:)==(min(ns(1,:))));
    if(size(num,2)>1)
        num=num(1);
    end
    tmin2=[tmin2; ns(1,num)];
    temp=ns(:,num);
    temp(1)=[];
    temp=[temp;0];
    ns(:,num)=temp;
    
    tmax2=[tmax2; ne(1,num)];
    temp=ne(:,num);
    temp(1)=[];
    temp=[temp;0];
    ne(:,num)=temp;
    tier2=[tier2; numTier(1,num)]; 
end
    
% p_realOverlap.m
t_overlap=0;
i=1;
a=0;
time = 0;
while(i<size(tier2,1))
    if (i+a)<=size(tier2,1)
        a=a+1;
    end    
    while(a~=0)
        if (i+a)<=size(tier2,1)      
            if tmax2(i)>tmin2(i+a)
                if tmax2(i)<tmax2(i+a)
                    if tmin2(i+a)>time
                        t_overlap=t_overlap+tmax2(i)-tmin2(i+a);
                        time = tmax2(i);
                    elseif tmax2(i)>time
                        t_overlap=t_overlap+tmax2(i)-time;
                        time = tmax2(i);
                    else
                        time = time;
                    end
                    i=i+a-1;
                    a=0;
                else
                    if tmin2(i+a)>time
                        t_overlap=t_overlap+tmax2(i+a)-tmin2(i+a);
                        time = tmax2(i+a);
                    elseif tmax2(i+a)>time
                        t_overlap=t_overlap+tmax2(i+a)-time;
                        time = tmax2(i+a);
                    else
                        time = time;
                    end
                    a=a+1;
                end
            else
                a=0;
            end
        else
            break;
        end        
    end
    i=i+1;
end
p_reOverlap=t_overlap/300;
nullOverlap=[nullOverlap;p_reOverlap];
% disp('realized overlap: ')
% disp(p_reOverlap)
end

nullOverlap=sort(nullOverlap);
p=find(p_Overlap>nullOverlap);
if (size(p,1)~=0)
    p_value=(size(p,1)+1)/1000;
else
    p_value=0;
end