close all;
clear all;
clc;

filenum=4380;

threshold_area=8;
threshold_rainfall=20;
threshold_lunkuo=10;
for i=0:1:4380
    inputpath='G:\\anal\\anal_';
    str_i=int2str(i);
    inputpath=strcat(inputpath,str_i);
    inputpath=strcat(inputpath,'.dat');
    I_res=f_intensities(inputpath,threshold_area,threshold_rainfall,threshold_lunkuo);
    I_res=I_res';
    outputpath='G:\\20points\\';
    str_i=int2str(i);
    outputpath=strcat(outputpath,str_i);
    outputpath=strcat(outputpath,'.png');
    imwrite(I_res,outputpath);
end
