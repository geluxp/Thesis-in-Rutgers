function [ExpoFac] = setExpoFacs(xplev,xpvals,pDist,SensitiveFactor)
%Modified the loop (line 27 to 40) for interp1. rand(1,n) needed 100 multiplied 
%to it. Ran the code with the modification to create a new ExpoFacs.mat file. 

[ID, ChemList, MW] = setChemicalIDs;
load('D:\Thesis\Code\subcode\numpergrp','num_per_population');
nMonte=100000;
min_ages_agg = [0, 1/12, 3/12, 6/12, 1, 2, 3, 6, 11, 16, 18, 21, 31, 41, 51, 61, 65, 71, 81];
num_grps = length(min_ages_agg)*2;

indTime = normrnd(pDist.time.I.mu, pDist.time.I.sd, 1, nMonte*2);
indTime = indTime(find(indTime > 0)); indTime = indTime(1:nMonte);
outTime = normrnd(pDist.time.O.mu, pDist.time.O.sd, 1, nMonte*2);
outTime = outTime(find(outTime > 0)); outTime = outTime(1:nMonte);
indTime = indTime ./ (indTime + outTime); % fraction
outTime = 1 - indTime; % fraction

ExpoFac.ind = indTime;
ExpoFac.out = outTime;
Dermalrate=zeros(9,100000);
inhRate=zeros(9,100000);
ingestrate=zeros(9,100000);
for i=1:9; % nine differenct climate zones
min = 1;
for j=1:38
    n = num_per_population(i,j);
    max = min+n-1;
    if j <= length(min_ages_agg), % male
         Dermalrate(i,min:max) = interp1(xplev, xpvals.Dermal{j}, rand(1,n)*100); 
        inhRate(i,min:max) = interp1(xplev, xpvals.InhM{j}, rand(1,n)*100);
        ingestrate(i,min:max) = interp1(xplev, xpvals.ingest{j}, rand(1,n)*100); 
    else % female
         Dermalrate(i,min:max) = interp1(xplev, xpvals.Dermal{j-length(min_ages_agg)}, rand(1,n)*100);
        inhRate(i,min:max) = interp1(xplev, xpvals.InhF{j-length(min_ages_agg)}, rand(1,n)*100);
        ingestrate(i,min:max) = interp1(xplev, xpvals.ingest{j-length(min_ages_agg)}, rand(1,n)*100);
    end
 
    min = min+n;
end
end
outTime1=repmat(outTime,9,1);
indTime1=repmat(indTime,9,1);
ExpoFac = {};
ExpoFac{ID.OutdoorAir} = inhRate.* outTime1;
ExpoFac{ID.IndoorAir} = inhRate.* indTime1*(1/(1+1.75*SensitiveFactor(17)));
ExpoFac{ID.DermalrateOut} = Dermalrate.* outTime1;
ExpoFac{ID.DermalrateIn} = Dermalrate.* indTime1*1.2*SensitiveFactor(9)/(1*SensitiveFactor(9)+1.75*SensitiveFactor(17));
ExpoFac{ID.IngestOut} = ingestrate.* outTime1;
ExpoFac{ID.IngestIn} = ingestrate.* indTime1*1.2*SensitiveFactor(9)/(1.2*SensitiveFactor(9)+1.75*SensitiveFactor(17));

%ExpoFac{ID.OutdoorAir_alt} = ExpoFac{ID.OutdoorAir};
%ExpoFac{ID.IndoorAir_alt} = ExpoFac{ID.IndoorAir};




end