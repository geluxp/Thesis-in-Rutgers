
clc
clear
% ncdisp('Betula_2004.ncf');
pollen=ncread('Betula_2004.ncf','NUMPOLLEN',[1 1 1 1000],[Inf Inf Inf 200],[1 1 1 1]);
%read the Pollen matrix(which is a 4D matrix) from "Betula.ncf",to make it
%simpele ,we only choose the timestep from 1000 to 1200,
[d1,d2,d3,d4]=size(pollen);
%the four dimensions are: d1:longitude(column) d2:latitude(row) d3:
%altitude(layer) d4:hour(timestep)
pollen1(1:d1,1:d2,1:d4)=pollen(:,:,1,:);
pollen1test=squeeze(pollen(:,:,1,:));
%only pick up the data in the layer 1 for further processing.here we use
%two different methods
if isequal(pollen1,pollen1test)
A=1;
else A=0;
end
%the result shows that they are the same
a=pollen1(74,33,:);
b=squeeze(a);
%compare the plot of an abritary point to which in the VERDI
pollen1_mean=mean(pollen1,3);
%get the mean value towards the timesteps
pollen1_meanint=floor(pollen1_mean);





m=1;
pollen1_mean1d=zeros(d1*d2,1);
for i=1:d1
n=m+d2-1;    
pollen1_mean1d(m:n,1)=pollen1_mean(i,:);
m=n+1;
end

m=1;
pollen1_mean1dint=zeros(d1*d2,1);
for i=1:d1
n=m+d2-1;    
pollen1_mean1dint(m:n,1)=pollen1_meanint(i,:);
m=n+1;
end

fnt_sze = 20;
lne_wdth = 3;
lne_styl = {'-b','-.g','-r','-b','-r','--g',':b'};
plev = [0:100];


% %for m=1:length(enviro_media)
%     if ~isempty(pollen1_mean1d)
%         if ~isnan(pollen1_mean1d)
%             if prctile(pollen1_mean1d,99.7) > 0
%                 %num_data_sets = num_data_sets + 1;
%                 semilogx(prctile((pollen1_mean1d),plev),plev,lne_styl{1},'LineWidth',lne_wdth); 
% %                 hold on;
% %                 axis tight
%                 %legend_strs{num_data_sets} = enviro_media{m};
%             end
%         end
%     end
     
    if ~isempty(pollen1_mean1d)
        if ~isnan(pollen1_mean1d)
            if prctile(pollen1_mean1d,99.7) > 0
                %num_data_sets = num_data_sets + 1;
                figure;
                semilogx(prctile((pollen1_mean1dint),plev),plev,lne_styl{1},'LineWidth',lne_wdth); 
              xlabel('pollen numbers','FontSize',14);
              ylabel('percentile','FontSize',14);
  
            end
        end
    end
         
     load('test_exposure.mat');
     if ~isempty(pollen1_mean1d)
        if ~isnan(pollen1_mean1d)
            if prctile(pollen1_mean1d,99.7) > 0
                %num_data_sets = num_data_sets + 1;
                figure; exp =  ExpoFac{1}(unidrnd(5520)) .*pollen1_mean1dint;
                semilogx(prctile(exp,plev),plev,lne_styl{1},'LineWidth',lne_wdth);
%                 hold on; axis tight
                %legend_strs{num_data_sets} = enviro_media{m};
                xlabel('ExposureEffect','FontSize',14);
                ylabel('percentile','FontSize',14);
            end
        end
     end
   
