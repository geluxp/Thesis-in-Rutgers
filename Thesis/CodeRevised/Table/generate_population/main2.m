%% Diesel Intake Plots
%% Step-0: Adding necessary paths of functions
addpath data

%% Step-1: Define age-groups and get intake fractions of cleaning products for each group
nMonte = 1 * 100; %# of iterations for Monte Carlo algorithm 
age_groups = [ 0,10;
              11,21;  
              22,39;
              40,59;
              60,100]; %Age group matrix by rows.

sim_population = generatePopulation(age_groups, nMonte); 