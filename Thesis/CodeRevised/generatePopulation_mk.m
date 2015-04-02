function EF = generatePopulation_mk( nMonte,sf,t) 
%% 

addpath data
load('PopulationData');
vd=vd_value(sf); 
census_age_gend = radnom_sampler_mk(nMonte,female_pop,male_pop,t); % Random sampling for representative population
out_frac   = outdoor_time_sampler_mk(census_age_gend,sf);
tot_inhal  = inhaled_sampler_mk(census_age_gend,sf); % m^3/day
tot_ingest_dermal = total_ingest_sampler(census_age_gend,sf,vd);

inh_per_out = tot_inhal.out' .* out_frac; % m^3/day
inh_per_in = tot_inhal.int'.* (1-out_frac); % m^3/day
ingest_out=tot_ingest_dermal.ingest.int'.* out_frac;
ingest_in=tot_ingest_dermal.ingest.out'.*(1-out_frac);
dermal_out=tot_ingest_dermal.dermal'.*out_frac;
dermal_in=tot_ingest_dermal.dermal'.*(1-out_frac);

 EF(1,:)=inh_per_in;
EF(2,:)=inh_per_out;

% EF.in.inh=inh_per_in;
% EF.in.ingest=ingest_in;
% EF.in.dermal=dermal_in;
% 
% EF.out.inh=inh_per_out;
% EF.out.ingest=ingest_out;
% EF.out.dermal=dermal_out;
