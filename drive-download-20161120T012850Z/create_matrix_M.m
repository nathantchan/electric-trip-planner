clear all;
close all;
%%

filename = 'C:\Users\Eliott\Google Drive\Hackathon\start.csv';
a = csvread(filename,0,0);
mat = [mat;
    -1 a(1) a(2)];

filename = 'C:\Users\Eliott\Google Drive\Hackathon\start.csv';
a = csvread(filename,0,0);

% filename = 'C:\Users\Eliott\Google Drive\liste_des_stations.csv';
% 
% mat = csvread(filename,1,0);
% nStat = size(mat,1);
% mat = [mat;
%     -1; 
% 
% ind = 1;
% for i=1:nStat
%     for j=(i+1):nStat
%         i
%         ind1 = mat(i,1);
%         ind2 = mat(j,1);
%         
%         latlon1(1) = mat(i,1);
%         latlon1(2) = mat(i,2);
%         
%         latlon2(1) = mat(j,1);
%         latlon2(2) = mat(j,2);
%         
%         [dist ~]=lldistkm(latlon1,latlon2);
%         
%         M(ind,1) = ind1;
%         M(ind,3) = ind2;
%         M(ind,2) = dist*1000;
%         M(ind,2) = 0.94458*M(ind,2) + 95048;
%         M(ind,4) = 0.033267*M(ind,2) + 3541;
%         ind = ind+1;
%     end
% end
