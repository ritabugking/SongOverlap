t_overlap=0;
i=1;
a=0;
time = 0;
while(i<length(tier))
    if (i+a)<=length(tier)
        a=a+1;
    end    
    while(a~=0)
        if (i+a)<=length(tier)       
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
p_reOverlap=t_overlap/300;
disp('realized overlap: ')
disp(p_reOverlap)
