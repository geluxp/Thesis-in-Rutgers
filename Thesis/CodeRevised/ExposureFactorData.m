function [xplev,xpvals,pDist]= ExposureFactorData(SensitiveFactor,vd)
%UNTITLED7 Summary of this function goes here
  % Detailed explanation goes here
%   SensitiveFactor=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]; 
%  vd=0.0909;
% Distributions for inhaltion rates, etc., that are population weighted --
% from EFH
outpvals = 0:100;
xplev = outpvals;
load('C:\Documents and Settings\kunmei\My Documents\Thesis\Table\EFHdata_MK.mat','Inhal','surface','frequency');
load('C:\Documents and Settings\kunmei\My Documents\Thesis\CodeRevised\FactorIndoor.mat','Findoor_m','Foutdoor_m','Findoor_f','Foutdoor_f');
%%
% Percentiles for inhalation rates:
% table 6-10 & 6-11, p 6-29 (304)
%popWeights = round(n(3:30,1)/2000); % we use population weights in multiples of 2k
plev.inh = [0 5 10 25 50 75 90 95 100]/100; % 5th	10th	25th	50th	75th	90th	95th	Max

%%
inhPctiles=nan(28,101);
for i=1:28 % 28 different age/gender groups
%   pvals(i,:) = [n(i+2,4) n(i+2,4:11)];
%   inhData(i,:) = getPercentiles(plev.inh,pvals(i,:),10000);
%   inhPctiles(i,:) = prctile(inhData(i,:),outpvals); 
  inhPctiles(i,:) = prctile(getPercentiles(plev.inh,[Inhal(i+2,4) Inhal(i+2,4:11)],1000),outpvals); 
end


% calculat the dermal exposure and ingestion rate   unit : mg/day

hands=[5.3 5.3 5.3 5.3 5.7 4.7 4.9  4.7 4.5 4.5 5.2 4.8 5.2 4.8 5.2 4.8 5.2]*SensitiveFactor(14)/100;
% mean percent of total surface area

surface_hands=nan(17,12);
dermal_contact=nan(17,12);
for i=1:17
      %surface_hands(1+i,1:2)=surface(1+i,1:2)*SensitiveFactor(13);
      surface_hands(1+i,3:12)=surface(1+i,3:12)*hands(i);
end

namdav=1;
for i=1:6
      %dermal_contact(1+i,1:2)=surface_hands(1+i,1:2);
      dermal_contact(1+i,3:12)=surface_hands(1+i,3:12)*frequency(i,1)*24*vd*SensitiveFactor(12)*namdav*SensitiveFactor(9);
end
for i=6:17
       %dermal_contact(1+i,1:2)=surface_hands(1+i,1:2);
      dermal_contact(1+i,3:12)=surface_hands(1+i,3:12)*24*vd*SensitiveFactor(12)*namdav*SensitiveFactor(9);

end
plev.Dermal = [0 5 10 15 25 50 75 85 90 95 100]/100; 


parfor i=1:17 % 17 different age/gender groups
  DermalPctiles(i,:) = prctile(getPercentiles(plev.Dermal,[dermal_contact(i+1,4) dermal_contact(i+1,4:12) dermal_contact(i+1,12)],1000),outpvals); 
end

min_ages_agg = [0, 1/12, 3/12, 6/12, 1, 2, 3, 6, 11, 16, 18, 21, 31, 41, 51, 61, 65, 71, 81];
min_ages_inh = [0, 1, 2, 3, 6, 11, 16, 21, 31, 41, 51, 61, 71, 81];
min_ages_Dermal=[0, 1/12, 3/12, 6/12, 1, 2, 3, 6, 11, 16, 21, 31, 41, 51, 61,  71, 81];


%%

%%

cntr=1;
   for i = 1:19
    if min_ages_agg(i) == min_ages_inh(cntr)
    
        xpvals.InhM{i} = inhPctiles(cntr,:)*SensitiveFactor(15);
        xpvals.InhF{i} = inhPctiles(cntr+14,:)*SensitiveFactor(16);
      
        cntr = cntr + 1;
       
    else
        xpvals.InhM{i} = xpvals.InhM{i-1}*SensitiveFactor(15);
        xpvals.InhF{i} = xpvals.InhF{i-1}*SensitiveFactor(16);
    end
   end



cntr = 1; 
  for i = 1:length(min_ages_agg)
    if min_ages_agg(i) == min_ages_Dermal(cntr)
        xpvals.Dermal{i} = DermalPctiles(cntr,:);
        if ~(min_ages_Dermal(cntr) == 65), cntr = cntr + 1; end
    else
        xpvals.Dermal{i} = xpvals.Dermal{i-1};
    end
  end




%%
nSamp1 = 2762; % National sample on indoor/outdoor time | page 16-165 of EFH Statistics for 12 years and older (EFH 2011)
pDist.time.Ind.mu = 1279*SensitiveFactor(10)/1440;
pDist.time.Ind.sd = 21 * sqrt(nSamp1)/1440; %Standard Deviation = Standard error of mean x sqrt(sample size)
pDist.time.Out.mu = 87*SensitiveFactor(11)/1440;
pDist.time.Out.sd = 4 * sqrt(nSamp1)/1440;
pDist.time.InVeh.mu = 87*SensitiveFactor(11)/1440;
pDist.time.InVeh.sd = 2 * sqrt(nSamp1)/1440;

pDist.time.I.mu = pDist.time.Ind.mu;
pDist.time.I.sd = pDist.time.Ind.sd;

pDist.time.O.mu = (pDist.time.Out.mu + pDist.time.InVeh.mu);
pDist.time.O.sd = sqrt(pDist.time.Out.sd^2 + pDist.time.InVeh.sd^2);

res.pvals = xpvals;
res.plev = xplev;

%save('mk-EFH-data','xplev','xpvals','pDist');


end