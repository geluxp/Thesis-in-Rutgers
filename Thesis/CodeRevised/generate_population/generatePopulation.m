function res = generatePopulation(age_groups, nMonte) 
%% 
census_age_gend = random_census_sampler(nMonte); % Random sampling for representative population
out_frac   = cell2mat(outdoor_time_sampler(census_age_gend));
tot_inhal  = total_inhaled_sampler(census_age_gend); % m^3/day
tot_ingest = total_ingest_sampler(census_age_gend);
tot_dermal = total_dermal_sampler(census_age_gend);
inh_per_kg_out = tot_inhal .* out_frac; % m^3/day-kg
inh_per_kg_in = tot_inhal.* (1-out_frac); % m^3/day-kg


load('FactorIndoor.mat','Findoor','Foutdoor');
%% Age groups
age_sprd = age_res;
for i = 1:length(age_groups)
   age_beg = find(ismember(age_sprd, num2str(age_groups(i,1))));
   if age_groups(i, 2) > 90
       age_end = find(ismember(age_sprd, '90'));
   else
       age_end = find(ismember(age_sprd, num2str(age_groups(i,2))));
   end
   age_index = ismember(census_age_gend(:,1), age_sprd(age_beg:age_end));  
   res.(['AgeGrp', num2str(i)]).age_gend = census_age_gend(age_index,:);
   res.(['AgeGrp', num2str(i)]).inhalaton = tot_inhal(age_index,:);
   res.(['AgeGrp', num2str(i)]).body_weight = bod_weight(age_index,:);
   res.(['AgeGrp', num2str(i)]).outdoor = out_frac(age_index,:);
   res.(['AgeGrp', num2str(i)]).inha_per_weight_out = inh_per_kg_out(age_index,:);
   res.(['AgeGrp', num2str(i)]).inha_per_weight_in = inh_per_kg_in(age_index,:);
end

end

function res = age_res
    dummy = {'0','1/12','2/12','3/12','4/12','5/12','6/12','7/12','8/12',...
        '9/12','10/12','11/12'};
    dummy2 = cellfun(@(x) strtrim(num2str(rats(x))),num2cell(1:90),'UniformOutput',false);
    res = [dummy,dummy2];
end