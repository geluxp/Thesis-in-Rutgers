function res = total_ingest_sampler(pop_sample,sf,vd)
% Functions takes as argument a group of randomly selected samples' age group 
% to calculate their time spent outdoor and indoor (res_out - outdoor; res_in -indoor). 
% Data for each age group taken from EFH (Chapter 16; Nov 2011) and was fitted
% to a lognormal distribution. 
% pop_sample=census_age_gend;
%% Upload data from Excel
file_ptr = 'EFHcalculation_MK.xlsx';
data_range   = 'E28:M63';
[skin,~,~] = xlsread(file_ptr,'DermalHand',data_range);
[freq,~,~]=xlsread(file_ptr,'nondietary','B6:F22');
skin_male=skin(1:17,:);
skin_male=[skin_male(:,1) ,skin_male];
skin_female=skin(20:end,:);
skin_female=[skin_female(:,1) , skin_female];

freq_int=freq(1:end,1)*sf(12); freq_out=freq(1:end,4)*sf(10);



%% Fit nonparametric distribution (spline method) to data
efh_data_prc = [0, 5, 10, 15,25, 50, 75, 85,90, 95];
pop_sample_age    = pop_sample(:,1);    % Age group column
pop_sample_gender = pop_sample(:,2);    % Gender column
num_sample        = length(pop_sample); % Number of samples
age_grp_gend      = length(skin_male);
tot_skin_male = zeros(age_grp_gend,num_sample);
tot_skin_female=zeros(age_grp_gend,num_sample);
for i=1:age_grp_gend %skin surface area
    tot_skin_male(i,:) = interp1(efh_data_prc, skin_male(i,:), rand(1,num_sample)*100)*sf(12); % Spline for interpolation
    tot_skin_female(i,:) = interp1(efh_data_prc, skin_female(i,:), rand(1,num_sample)*100)*sf(11); % Spline for interpolation
end
hands=[5.3 5.3 5.3 5.3 5.7 4.7 4.9  4.7 4.5 4.5 5.2 4.8 5.2 4.8 5.2 4.8 5.2]*sf(13)/100;

%% ingestion
  for i=1:age_grp_gend            % dermal_contact=freqeuncy(time/hour)*24hour*skinsurface*vd*handsratio/(1+1.5)
    ingest_male_out(i,:)=24*freq_int(i)*tot_skin_male(i,:)*vd*0.24*sf(17)*hands(i)./(1+2.0*sf(18));  
    ingest_male_in(i,:)=24*freq_out(i)*tot_skin_male(i,:)*vd*0.24*sf(17)*hands(i)./(1+2.0*sf(18));  
      ingest_female_out(i,:)=24*freq_int(i)*tot_skin_female(i,:)*vd*0.24*sf(17)*hands(i)./(1+2.0*sf(18));  
    ingest_female_in(i,:)=24*freq_out(i)*tot_skin_female(i,:)*vd*0.24*sf(17)*hands(i)./(1+2.0*sf(18));  
  end
%% dermal contact 
tot_hand_male=zeros(17,num_sample); tot_hand_female=zeros(17,num_sample);
for i=1:17 %hands surface area
tot_hand_male(i,:)=tot_skin_male(i,:)*vd*sf(17)*0.03*0.5./(1+1.5*sf(18));
tot_hand_female(i,:)=tot_skin_female(i,:)*vd*sf(17)*0.03*0.5./(1+1.5*sf(18));
end




%% Random sampling of outdoor time by age group
        min_ages_agg = [0, 1/12, 3/12, 6/12, 1, 2, 3, 6, 11, 16, 18, 21, 31, 41, 51, 61, 65, 71, 81];
        min_outdoor_agg=[0,1/12,3/12,6/12,1,2,5,10,15,17,21,31,41, 51, 61, 71, 81];  
      for i = 1:num_sample   
         switch pop_sample_gender(i)
        case 1 % Male

       res.ingest.int(i)=ingest_male_in(find(min_outdoor_agg>=pop_sample_age(i),1),unidrnd(num_sample));
       res.ingest.out(i)=ingest_male_out(find(min_outdoor_agg>=pop_sample_age(i),1),unidrnd(num_sample));
       res.dermal(i)=tot_hand_male(find(min_outdoor_agg>=pop_sample_age(i),1),unidrnd(num_sample));
       
             case 2 %Female
                  res.ingest.int(i)=ingest_female_in(find(min_outdoor_agg>=pop_sample_age(i),1),unidrnd(num_sample));
       res.ingest.out(i)=ingest_female_out(find(min_outdoor_agg>=pop_sample_age(i),1),unidrnd(num_sample));
       res.dermal(i)=tot_hand_female(find(min_outdoor_agg>=pop_sample_age(i),1),unidrnd(num_sample));
         end
      end
end
