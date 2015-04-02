function res = outdoor_time_sampler(pop_sample)
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
end

%% Random sampling of outdoor time by age group
out_act_frac = out_act_time ./ 1440; % Outdoor activity fractions
res = cell(num_sample,1);
age_groups = {{'0'};
              {'1/12','2/12'};
              {'3/12','4/12','5/12'};
              {'6/12','7/12','8/12','9/12','10/12','11/12'};
              {'1'};
              {'2'};
              cellfun(@(x) num2str(x),num2cell(3:5),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(6:10),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(11:15),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(16:17),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(18:20),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(21:44),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(44:64),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(64:100),'UniformOutput',false);
              };
          
for i = 1:num_sample
    switch pop_sample_age{i}
        case age_groups{1,1},  res{i}= out_act_frac(1, unidrnd(num_sample));
        case age_groups{2,1},  res{i}= out_act_frac(2, unidrnd(num_sample));
        case age_groups{3,1},  res{i}= out_act_frac(3, unidrnd(num_sample));
        case age_groups{4,1},  res{i}= out_act_frac(4, unidrnd(num_sample));
        case age_groups{5,1},  res{i}= out_act_frac(5, unidrnd(num_sample));
        case age_groups{6,1},  res{i}= out_act_frac(6, unidrnd(num_sample));
        case age_groups{7,1},  res{i}= out_act_frac(7, unidrnd(num_sample));
        case age_groups{8,1},  res{i}= out_act_frac(8, unidrnd(num_sample));
        case age_groups{9,1},  res{i}= out_act_frac(9, unidrnd(num_sample));
        case age_groups{10,1},  res{i}= out_act_frac(10, unidrnd(num_sample));
        case age_groups{11,1},  res{i}= out_act_frac(11, unidrnd(num_sample));
        case age_groups{12,1},  res{i}= out_act_frac(12, unidrnd(num_sample));
        case age_groups{13,1},  res{i}= out_act_frac(13, unidrnd(num_sample));
        case age_groups{14,1},  res{i}= out_act_frac(14, unidrnd(num_sample));
    end
end


%% Optional: compare mean, median and sd of distribution to efh data
% std_dist = abs(std(out_act_time,0,2) - efh_data(:,6)) ./ efh_data(:,6);
% mean_dist = abs(mean(out_act_time,2) - efh_data(:,5)) ./ efh_data(:,5);
% median_dist = abs(median(out_act_time,2) - efh_data(:,3)) ./ efh_data(:,3);