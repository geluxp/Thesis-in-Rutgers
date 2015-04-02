function res = inhaled_sampler_mk( pop_sample,sf )

 %Functions takes as argument a group of randomly selected samples' age
% group and gender to calculate their total inhalation per day (m3/day). 
% Data for each age group and gender taken from EFH (Tables 6-14&15; 
% Sept 2011) and was fitted to an nonparametric distribution. 

%% Upload data from Excel
file_ptr = 'CCL_EFH-Total-Inhalation-Table_05.23.12.xlsx';
data_range = 'D3:K31';
[efh_data,~,~] = xlsread(file_ptr,data_range);
load('Factorindoor.mat');
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
tot_inhal_int=zeros(age_grp_gend,num_sample);
tot_inhal_out=zeros(age_grp_gend,num_sample);

[Fint,Fout]=Findoor(sf);
for i=1:28
    tot_inhal_int(i,:)=Fint(i)*tot_inhal(i,:);
     tot_inhal_out(i,:)=Fout(i)*tot_inhal(i,:);
end

for i=1:28
    maxinh(i)=max(tot_inhal(i,:));
    mininh(i)=min(tot_inhal(i,:));
end

%% Random sampling of total inhalation by age group and gender

min_ages_agg = [0, 1/12, 3/12, 6/12, 1, 2, 3, 6, 11, 16, 18, 21, 31, 41, 51, 61, 65, 71, 81];
min_ages_inh = [0, 1, 2, 3, 6, 11, 16, 21, 31, 41, 51, 61, 71, 81];
  
for i = 1:num_sample
    switch pop_sample_gender(i)
    case 1 % Male
            
            res.int(i)=tot_inhal_int(find(min_ages_inh>=pop_sample_age(i),1),unidrnd(num_sample))*sf(15);
            if res.int(i)<mininh(find(min_ages_inh>=pop_sample_age(i),1))
                res.int(i)=mininh(find(min_ages_inh>=pop_sample_age(i),1));
            end
             if res.int(i)>maxinh(find(min_ages_inh>=pop_sample_age(i),1))
                res.int(i)=maxinh(find(min_ages_inh>=pop_sample_age(i),1));
            end
            res.out(i)=tot_inhal_out(find(min_ages_inh>=pop_sample_age(i),1),unidrnd(num_sample))*sf(15);
            if res.out(i)>maxinh(find(min_ages_inh>=pop_sample_age(i),1))
                res.out(i)=maxinh(find(min_ages_inh>=pop_sample_age(i),1));
            end
            if res.out(i)<mininh(find(min_ages_inh>=pop_sample_age(i),1))
                res.out(i)=mininh(find(min_ages_inh>=pop_sample_age(i),1));
            end
            
    case 2 % Female
         res.int(i)=tot_inhal_int(find(min_ages_inh>=pop_sample_age(i),1)+14,unidrnd(num_sample))*sf(14);
         res.out(i)=tot_inhal_out(find(min_ages_inh>=pop_sample_age(i),1)+14,unidrnd(num_sample))*sf(14);
            if res.int(i)<mininh(find(min_ages_inh>=pop_sample_age(i),1))
                res.int(i)=mininh(find(min_ages_inh>=pop_sample_age(i),1));
            end
             if res.int(i)>maxinh(find(min_ages_inh>=pop_sample_age(i),1))
                res.int(i)=maxinh(find(min_ages_inh>=pop_sample_age(i),1));
             end
             if res.out(i)>maxinh(find(min_ages_inh>=pop_sample_age(i),1))
                res.out(i)=maxinh(find(min_ages_inh>=pop_sample_age(i),1));
            end
            if res.out(i)<mininh(find(min_ages_inh>=pop_sample_age(i),1))
                res.out(i)=mininh(find(min_ages_inh>=pop_sample_age(i),1));
            end
            
    end
end
end
% A=[3 5 6 10;2 6 7 8];
% B=find(A>7);%找出大于7的位置
% A(B)=5; %将大于7的位置置为0B=find(A>7);%找出大于7的位置



