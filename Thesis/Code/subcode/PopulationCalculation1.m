%%Population Calculation

min_ages_agg = [0, 1/12, 3/12, 6/12, 1, 2, 3, 6, 11, 16, 18, 21, 31, 41, 51, 61, 65, 71, 81];
num_grps = length(min_ages_agg)*2;

grpM(:,1)=male_pop(:,1)/2; 
grpF(:,1)=female_pop(:,1)/2;
grpT(:,1)=total_pop(:,1)/2;
grpM(:,2)=grpM(:,1); grpF(:,2)=grpF(:,1); grpT(:,2)=grpT(:,1);
grpM(:,3:19)=male_pop(:,2:18); grpF(:,3:19)=female_pop(:,2:18); grpT(:,3:19)=total_pop(:,2:18);

nSamps = 100000;

popsumM=sum(grpM,2);
popsumF=sum(grpF,2);

for i=1:9
stepsize(i)=(popsumM(i)+popsumF(i))/100000;
num_per_grp(i,:)=round(grpM(i,1:19)/stepsize(i));
num_per_grpF(i,:)=round(grpF(i,1:19)/stepsize(i));
end

num_per_population=[num_per_grp,num_per_grpF];

num_per_population;
sum_norm_pop=sum(num_per_population,2);
save('numpergrp','num_per_population');

nMonte=100000;

step_size = total_pop/nSamps;
num_per_grp = [round(popM./step_size); round(popF./step_size)];
nMonte = sum(num_per_grp);
xform = nan(1,nMonte);
xperc = xform;