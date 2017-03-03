%读入文件file，计算file文件的各个区域的Cx,Cy,Cmin,Cmax,Cavg，
close all;
clear all;
clc;
inputpath='F:\\anal\\anal_0.dat';

threshold_lunkuo=10;
   fid=fopen(inputpath,'r');
   I0=fread(fid,7808,'float32');
   I1=reshape(I0,128,61);
   I2=I1;
   I2(I2<=25)=0;
   I2(I2>25)=1;
   fclose(fid);
   [counters1,L] = bwboundaries(I2,'noholes');
   [len_counters1,b] =size(counters1);
   count_counter=0;
   for counters1_i=1:len_counters1
      [len_temp,b]=size(cell2mat(counters1(counters1_i,1)));
      if(len_temp>threshold_lunkuo)
         xy=cell2mat(counters1(counters1_i,1));
         x=xy(:,1);
         y=xy(:,2);
      flag=isfitellipse(x,y);
      if(flag)
        cell_res=  fitellipse(x,y);
        max_b=max(cell_res(1,1),cell_res(1,2));
        min_a=min(cell_res(1,1),cell_res(1,2));
     if(~(max_b>15*min_a))
        count_counter=count_counter+1;
        end
      end
      end
   end
   intensities=zeros(count_counter,6);
   pos=1;
   for counters1_i=1:len_counters1
      [len_temp,b]=size(cell2mat(counters1(counters1_i,1)));
      if(len_temp>threshold_lunkuo)
         xy=cell2mat(counters1(counters1_i,1));
         x=xy(:,1);
         y=xy(:,2);
      flag=isfitellipse(x,y);
      if(flag)
        cell_res=  fitellipse(x,y);
        max_b=max(cell_res(1,1),cell_res(1,2));
        min_a=min(cell_res(1,1),cell_res(1,2));
       if(~(max_b>15*min_a))
        for intensities_i=1:5
             intensities(pos,intensities_i)=cell_res(1,intensities_i);
        end
            L(x(1,1),y(1,1))
          intensities(pos,6)=f_get_Cavg(I1,L(x(1,1),y(1,1)),L);
           pos=pos+1;
       end
      end
end
   end
 


