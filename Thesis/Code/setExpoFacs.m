function ExpoFac = setExpoFacs
%Modified the loop (line 27 to 40) for interp1. rand(1,n) needed 100 multiplied 
%to it. Ran the code with the modification to create a new ExpoFacs.mat file. 

[ID, ChemList, MW] = setChemicalIDs;
load('mk-EFH-data.mat'); % Load from a file generated via popWeightedDist.m
load('TDS_data.mat','pops');
popM = pops(:,1);
popF = pops(:,4);
total_pop = sum(popM)+sum(popF);
min_ages_agg = [0, 1/12, 3/12, 6/12, 1, 2, 3, 6, 11, 16, 18, 21, 31, 41, 51, 61, 65, 71, 81];
num_grps = length(min_ages_agg)*2;
nSamps = 100000;
step_size = total_pop/nSamps;
num_per_grp = [round(popM./step_size); round(popF./step_size)];
nMonte = sum(num_per_grp);
xform = nan(1,nMonte);
xperc = xform;

indTime = normrnd(pDist.time.I.mu, pDist.time.I.sd, 1, nMonte*2);
indTime = indTime(find(indTime > 0)); indTime = indTime(1:nMonte);
outTime = normrnd(pDist.time.O.mu, pDist.time.O.sd, 1, nMonte*2);
outTime = outTime(find(outTime > 0)); outTime = outTime(1:nMonte);
indTime = indTime ./ (indTime + outTime); % fraction
outTime = 1 - indTime; % fraction

ExpoFac.ind = indTime;
ExpoFac.out = outTime;

min = 1;
for i=1:num_grps
    n = num_per_grp(i);
    max = min+n-1;
    if i <= length(min_ages_agg), % male
         Dermalrate(min:max) = interp1(xplev, xpvals.Dermal{i}, rand(1,n)*100)/1000; 
        inhRate(min:max) = interp1(xplev, xpvals.InhM{i}, rand(1,n)*100);
    else % female
         Dermalrate(min:max) = interp1(xplev, xpvals.Dermal{i-length(min_ages_agg)}, rand(1,n)*100)/1000;
        inhRate(min:max) = interp1(xplev, xpvals.InhF{i-length(min_ages_agg)}, rand(1,n)*100);
    end
 
    min = min+n;
end
Dermalrate(find(isnan(Dermalrate)==1)) = 0
ExpoFac = {};
ExpoFac{ID.OutdoorAir} = inhRate.* outTime;
ExpoFac{ID.IndoorAir} = inhRate.* indTime;
ExpoFac{ID.Dermalrate} = Dermalrate;

%ExpoFac{ID.OutdoorAir_alt} = ExpoFac{ID.OutdoorAir};
%ExpoFac{ID.IndoorAir_alt} = ExpoFac{ID.IndoorAir};


ExpoFac{ID.num_grps} = num_grps;
ExpoFac{ID.num_per_grp} = num_per_grp;
ExpoFac{ID.nMonte} = nMonte;

save('Test_exposure.mat','ExpoFac');

