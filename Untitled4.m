close all;
clear all;
clc;
date=f_hash_date;
for i=0:1:4380
    if(date(i+1,1)==2005)
        if(date(i+1,2)==9)
            if(date(i+1,3)==26)
                disp(i);
                break;
            end
        end
    end
end