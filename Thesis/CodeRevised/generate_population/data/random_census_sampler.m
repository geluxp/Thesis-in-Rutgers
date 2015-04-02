function res = random_census_sampler(nMonte)
% Function for randomly selecting individuals based on US Census data. 
% Population in each age group and gender are specified in 
% CCL_USCensus2010_Population-Age-Gender_05.22.12.xlsx. Fucntion takes
% number of samples as argument, and returns randomly selected 
% samples' age group and gender. First column of res is age group and 
% the second is gender (1 - male; 2 - female).
 
%% Upload data from Excel
file_ptr = 'CCL_USCensus2010_Population-Age-Gender_05.22.12.xlsx';
data_range   = 'B2:F103';
[census_data,~,~] = xlsread(file_ptr,data_range);

%% Breakdown of uploaded data
pop_data = census_data(:,end-1:end); % Population by age and gender (first column male, second female)
age_grp  = cellstr(num2str(census_data(:,1))); % Age of each group (rounded down)
age_grp(2:12) = {'1/12','2/12','3/12','4/12','5/12','6/12','7/12','8/12',...
    '9/12','10/12','11/12'};      
age_grp = strtrim(age_grp);

%% Set up for sampling from data
entire_pop = sum(sum(pop_data));
pop_data_cumu(:,1) = cumsum(pop_data(:,1));
pop_data_cumu(:,2) = cumsum(pop_data(:,2)) +  pop_data_cumu(end,1);

%% Random sampling 
res = cell(nMonte, 2); 
for i = 1:nMonte
    rand_samp = unidrnd(entire_pop); % Randomly select one individual from entire population
    [I,J] = find(pop_data_cumu >= rand_samp,1); % Locate the age and gender of the individual
    res(i,:) = [age_grp(I), J]; % Storing age and gender of randomly selected indiviudals 
end

%% Optional: Test randomness
% uniq_age    = age_grp;
% uniq_weight = zeros(size(uniq_age));
% for i = 1:length(uniq_age)
%     uniq_weight(i) = length(find(strcmp(res(:,1),uniq_age(i))))/nMonte;
% end
% res_opt = [uniq_age, num2cell(uniq_weight)];