clc
clear
% ncdisp('Betula_2004.ncf');
pollen=ncread('Betula_2004.ncf','NUMPOLLEN',[1 1 1 1000],[Inf Inf Inf 200],[1 1 1 1]);
%read the Pollen matrix(which is a 4D matrix) from "Betula.ncf",to make it
%simpele ,we only choose the timestep from 1000 to 1200,
[d1,d2,d3,d4]=size(pollen);
%the four dimensions are: d1:longitude(column) d2:latitude(row) d3:
%altitude(layer) d4:hour(timestep)
pollen1=squeeze(pollen(:,:,1,:));
%only pick up the data in the layer 1 for further processing

%compare the plot of an abritary point to which in the VERDI
pollen1_mean=mean(pollen1,1);
%get the mean value towards the x coordinate
pollen_mean=mean(pollen1_mean,2);
for i=1:200
pollendist(i)=pollen_mean(1,1,i)
end
plot(pollendist)

fnt_sze=14
ylabel('pollen numbers','FontSize',fnt_sze);
xlabel('hour','FontSize',fnt_sze);
