
function res = outdoor_time_sampler(pop_sample,sf)
% Functions takes as argument a group of randomly selected samples' age group 
% to calculate their time spent outdoor and indoor (res_out - outdoor; res_in -indoor). 
% Data for each age group taken from EFH (Chapter 16; Nov 2011) and was fitted
% to a lognormal distribution. 

%% Upload data from Excel
file_ptr = 'CCL_EFH-Outdoor-Activity-Table_05.21.12.xlsx';
data_range   = 'B2:G15';
[efh_data,~,~] = xlsread(file_ptr,data_range);

%% Fit lognormal to data
pop_sample_age = pop_sample(:,1); % Age group column
num_sample = length(pop_sample); % Number of samples
out_act_time = zeros(length(efh_data),num_sample);
for i = 1:length(efh_data)
    log_par_mean  = log(efh_data(i,3)); % Median = exp(mu) by definition 
    log_par_sigma = sqrt(2*(log(efh_data(i,5))-log_par_mean)); % Mean = exp(mu+(sigma^2)/2) by definition 
    dummy = lognrnd(log_par_mean,log_par_sigma,[1,2*num_sample]); 
    dummy = dummy(dummy <= 1440); % Ensure that maximum time spent is less than 24 hrs
    out_act_time(i,:) = dummy(1:num_sample); % Select only samples with less than 24 hrs
    maxout(i)=max(out_act_time(i,:));
    minout(i)=min(out_act_time(i,:));
end

%% Random sampling of outdoor time by age group
out_act_frac = out_act_time ./ 1440; % Outdoor activity fractions
        min_ages_agg = [0, 1/12, 3/12, 6/12, 1, 2, 3, 6, 11, 16, 18, 21, 31, 41, 51, 61, 65, 71, 81];
        min_outdoor_agg=[0,1/12,3/12,6/12,1,2,5,10,15,17,20,44,64,81];  
        res=zeros(length(pop_sample),1);
  for i = 1:num_sample
     
       res(i)=out_act_frac(find(min_outdoor_agg>=pop_sample_age(i),1),unidrnd(num_sample))*sf(9);
       if res(i)>maxout(find(min_outdoor_agg>=pop_sample_age(i),1));
           res(i)=maxout(find(min_outdoor_agg>=pop_sample_age(i),1));
       end
       if res(i)<minout(find(min_outdoor_agg>=pop_sample_age(i),1));
           res(i)=minout(find(min_outdoor_agg>=pop_sample_age(i),1));
       end
  end
end



