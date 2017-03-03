%读入文件file，计算file文件的各个区域的Cx,Cy,Cmin,Cmax,Cavg，

function I_res=f_intensities(inputpath,threshold_area,threshold_rainfall,threshold_lunkuo)
   fid=fopen(inputpath,'r');
   I0=fread(fid,7808,'float32');
   I1=reshape(I0,128,61);
   I2=I1;
   I2(I2<=threshold_rainfall)=0;
   I2(I2>threshold_rainfall)=1;
   fclose(fid);
   I2=bwareaopen(I2,threshold_area,8);
   [counters1,L] = bwboundaries(I2,'noholes');
   [len_counters1,b] =size(counters1);
  
   I_res=zeros(128,61);
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
       
         for i=1:128
            for j=1:61
                if( L(x(1,1),y(1,1 ))== L(i,j) )
                    I_res(i,j)=255;
                end
            end
            
         end
        end
      end
      end
   end
end

