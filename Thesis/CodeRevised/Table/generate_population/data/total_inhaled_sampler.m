function res = total_inhaled_sampler(pop_sample)
% Functions takes as argument a group of randomly selected samples' age
% group and gender to calculate their total inhalation per day (m3/day). 
% Data for each age group and gender taken from EFH (Tables 6-14&15; 
% Sept 2011) and was fitted to an nonparametric distribution. 

%% Upload data from Excel
file_ptr = 'CCL_EFH-Total-Inhalation-Table_05.23.12.xlsx';
data_range = 'D3:K31';
[efh_data,~,~] = xlsread(file_ptr,data_range);

%% Structuring of data format
efh_data_prc = [0, 5, 10, 25, 50, 75, 90, 95, 100]; %Percentiles of the data. 0th percentile added.
efh_data = [efh_data(:,1), efh_data]; %Copied the first column(5 percentile) for 0th percentile.
efh_data = [efh_data(1:14,:); efh_data(16:29,:)]; % Remove 'NaN' row

%% Fit nonparametric distribution (spline method) to data
pop_sample_age    = pop_sample(:,1);    % Age group column
pop_sample_gender = pop_sample(:,2);    % Gender column
num_sample        = length(pop_sample); % Number of samples
age_grp_gend      = length(efh_data);
tot_inhal = zeros(age_grp_gend,num_sample);
for i=1:age_grp_gend
    tot_inhal(i,:) = interp1(efh_data_prc, efh_data(i,:), rand(1,num_sample)*100); % Spline for interpolation
end

%% Random sampling of total inhalation by age group and gender
res = cell(num_sample,1);
age_groups = {{'0','1/12','2/12','3/12','4/12','5/12','6/12','7/12','8/12','9/12','10/12','11/12'};
              {'1'};
              {'2'};
              cellfun(@(x) num2str(x),num2cell(3:5),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(6:10),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(11:15),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(16:20),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(21:30),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(31:40),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(41:50),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(51:60),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(61:70),'UniformOutput',false);
              cellfun(@(x) num2str(x),num2cell(71:80),'UniformOutput',false); 
              cellfun(@(x) num2str(x),num2cell(81:100),'UniformOutput',false); 
              };
  
for i = 1:num_sample
    switch pop_sample_gender{i}
    case 1 % Male
        switch pop_sample_age{i}
        case age_groups{1,1}, res{i}=tot_inhal(1, unidrnd(num_sample));
        case age_groups{2,1}, res{i}=tot_inhal(2, unidrnd(num_sample));
        case age_groups{3,1}, res{i}=tot_inhal(3, unidrnd(num_sample));
        case age_groups{4,1}, res{i}=tot_inhal(4, unidrnd(num_sample));
        case age_groups{5,1}, res{i}=tot_inhal(5, unidrnd(num_sample));
        case age_groups{6,1}, res{i}=tot_inhal(6, unidrnd(num_sample));
        case age_groups{7,1}, res{i}=tot_inhal(7, unidrnd(num_sample));
        case age_groups{8,1}, res{i}=tot_inhal(8, unidrnd(num_sample));
        case age_groups{9,1}, res{i}=tot_inhal(9, unidrnd(num_sample));
        case age_groups{10,1}, res{i}=tot_inhal(10, unidrnd(num_sample));
        case age_groups{11,1}, res{i}=tot_inhal(11, unidrnd(num_sample));
        case age_groups{12,1}, res{i}=tot_inhal(12, unidrnd(num_sample));
        case age_groups{13,1}, res{i}=tot_inhal(13, unidrnd(num_sample));
        case age_groups{14,1}, res{i}=tot_inhal(14, unidrnd(num_sample));
        end
    case 2 % Female
        switch pop_sample_age{i}
        case age_groups{1,1}, res{i}=tot_inhal(15, unidrnd(num_sample));
        case age_groups{2,1}, res{i}=tot_inhal(16, unidrnd(num_sample));
        case age_groups{3,1}, res{i}=tot_inhal(17, unidrnd(num_sample));
        case age_groups{4,1}, res{i}=tot_inhal(18, unidrnd(num_sample));
        case age_groups{5,1}, res{i}=tot_inhal(19, unidrnd(num_sample));
        case age_groups{6,1}, res{i}=tot_inhal(20, unidrnd(num_sample));
        case age_groups{7,1}, res{i}=tot_inhal(21, unidrnd(num_sample));
        case age_groups{8,1}, res{i}=tot_inhal(22, unidrnd(num_sample));
        case age_groups{9,1}, res{i}=tot_inhal(23, unidrnd(num_sample));
        case age_groups{10,1}, res{i}=tot_inhal(24, unidrnd(num_sample));
        case age_groups{11,1}, res{i}=tot_inhal(25, unidrnd(num_sample));
        case age_groups{12,1}, res{i}=tot_inhal(26, unidrnd(num_sample));
        case age_groups{13,1}, res{i}=tot_inhal(27, unidrnd(num_sample));
        case age_groups{14,1}, res{i}=tot_inhal(28, unidrnd(num_sample));   
        end
    end
end
