function res = radnom_sampler_mk( nMonte ,female_pop,male_pop,t)

%% Upload data from Excel


nMonte=10000;
female=female_pop(t,:);
 male=male_pop(t,:);
 pop=[male,female];
 
% number of samples as argument, and returns randomly selected 
% samples' age group and gender. First column of res is age group and 
% the second is gender (1 - male; 2 - female).
 


%% age group information
age_grp = [0, 1/12, 3/12, 6/12, 1, 2, 3, 6, 11, 16, 18, 21, 31, 41, 51, 61, 65, 71, 81];

%% Set up for sampling from data
entire_pop = sum(female)+sum(male);
pop_data_cumu(:,1) = cumsum(male);
pop_data_cumu(:,2) = cumsum(female) +  pop_data_cumu(end,1);

%% Random sampling 
res = zeros(nMonte, 2); 
for i = 1:nMonte
    rand_samp = unidrnd(entire_pop); % Randomly select one individual from entire population
    [I,J] = find(pop_data_cumu >= rand_samp,1); % Locate the age and gender of the individual
    res(i,:) = [age_grp(I), J]; % Storing age and gender of randomly selected indiviudals 
end


end

