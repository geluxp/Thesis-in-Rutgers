clc
clear
ncdisp('Betula_2004.ncf');
pollen=ncread('Betula_2004.ncf','POLLEN',[1 1 1 1000],[Inf Inf Inf 200],[1 1 1 1]);
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
plot(b);
%compare the plot of an abritary point to which in the VERDI
pollen1_mean=mean(pollen1,3);
%get the mean value towards the timesteps
sizepollen1mena=size(pollen1_mean)


