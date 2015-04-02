load('Populationdata');
% population distribution by age,sex and region
%nine regions in total
popM=nan(9,19);
popF=nan(9,19);

for i=1:9
popM(i,1)=male_pop(i,1)/2;  popM(i,2)=male_pop(i,1)/2; popM(i,3:19)=male_pop(i,2:18);
popF(i,1)=female_pop(i,1)/2; popF(i,2)=female_pop(i,1)/2; popF(i,3:19)=female_pop(i,2:18);
end


min_ages_agg = [0, 1/12, 3/12, 6/12, 1, 2, 3, 6, 11, 16, 18, 21, 31, 41, 51, 61, 65, 71, 81];
num_grps = length(min_ages_agg)*2;
nSamps = 10000;
%normalization the age groups,put all the population in a 10000 scale
step_size=nan(9,19);
for i=1:9
    for j=1:19
step_size(i) = total_pop(i)/nSamps;
num_per_grpM(i,j) = round(popM(i,j)./step_size(i));
num_per_grpF(i,j)= round(popF(i,j)./step_size(i));
    end
end


for j=1:9
cntr=1;
   for i = 1:length(min_ages_agg)
    if min_ages_agg(i) == min_ages_inh(cntr)
        xpvals.InhM{j,i} = num_per_grpM(j,i)*inhPctiles(cntr,i)*SensitiveFactor(15);
        xpvals.InhF{j,i} = num_per_grpF(j,i)*inhPctiles(cntr+14,i)*SensitiveFactor(16);
        cntr = cntr + 1;
    else
        xpvals.InhM{j,i} = num_per_grpM(j,i)*xpvals.InhM{i-1}*SensitiveFactor(15);
        xpvals.InhF{j,i} = num_per_grpF(j,i)*xpvals.InhF{i-1}*SensitiveFactor(16);
    end
   end



cntr = 1; 
  for i = 1:length(min_ages_agg)
    if min_ages_agg(i) == min_ages_Dermal(cntr)
        xpvals.Dermal{i} = (num_per_grpM(j,i)+num_per_grpF(j,i))*DermalPctiles(cntr,:);
        if ~(min_ages_Dermal(cntr) == 65), cntr = cntr + 1; end
    else
        xpvals.Dermal{i} = (num_per_grpM(j,i)+num_per_grpF(j,i))*(xpvals.Dermal{i-1};
    end
  end
end

