% EPA Data (Metabolically Derived Human Ventilation Rates: A Revised ...
% Approach Based Upon Oxygen Consumption Rates 2009)

%% Load data
load('ActivityVentilation.mat');

%% X-Axis data
x_data = [0,1,2,3,6,11,16,21,31,41,51,61,71,81,100]; %Ages in year
X = zeros(1,size(x_data,2)*2-1);
j = 0;
for i = 1:length(x_data)-1
    X(i+j) = x_data(i);
    X(i+j+1) = x_data(i+1);
    j = j + 1;
end
X(end) = x_data(end);

%% Y-Axis data and Plotting
figure('Units', 'pixels', ...
    'Position', [100 100 500 375]);
hold on;

ActivityList = fieldnames(ActivityVentilation.male);
Y = zeros(size(X));
h = zeros(numel(ActivityList)+1,1);
j = 0;
for z = 1:numel(ActivityList)    
    for i = 1:length(x_data)-1
        Y(i+j) = ActivityVentilation.male.(ActivityList{z,1})(i,3);
        Y(i+j+1) = ActivityVentilation.male.(ActivityList{z,1})(i,3);
        j = j + 1;
    end
    Y(end) = ActivityVentilation.male.(ActivityList{z,1})(end,3);
    h(z) = plot(X,Y);
    j = 0;
end

%% Line settings
colors = lines(5);
lineWidth = 2.5;

set(h(1), ...
    'LineStyle'       , '-'        , ...
    'Color'           , colors(1,:)    , ...
    'LineWidth'       , lineWidth);

set(h(2), ...
    'LineStyle'       , '-'        , ...    
    'Color'           , colors(2,:)    , ...         
    'LineWidth'       , lineWidth);

set(h(3), ...
    'LineStyle'       , '-'        , ...
    'Color'           , colors(3,:)    , ...
    'LineWidth'       , lineWidth);

set(h(4), ...
    'LineStyle'       , '-'        , ...    
    'Color'           , colors(4,:)    , ...         
    'LineWidth'       , lineWidth);

%% Legends
% hLegend = legend( ...
%     [h(1), h(2), h(3), h(4)], ...
%     'Male Sedentary/Passive', ... 
%     'Male Light Intensity', ... 
%     'Male Moderate Intensity' , ...
%     'Male High Intensity' , ...
%     'Location'     , 'SouthOutside');
% set(hLegend, ...
%     'FontName'                 , 'AvantGarde', ...
%     'FontSize'                 , 14          );
% xlim([0,90])
% ylim([0,25])

%% Title and labels
hTitle = title(sprintf('Ventilation Rate During Activity (L/min)\n Unadjusted for Body Weight'));
hXLabel = xlabel('Age (years)');
hYLabel = ylabel('Ventilation Rate');
set(gca, ... 
    'FontName' ,'AvantGarde', ...
    'FontSize', 14);
set([hTitle, hXLabel, hYLabel] , ...
    'FontName'                 , 'AvantGarde', ...
    'FontSize'                 , 14          );
set( hTitle                    , ...
    'FontSize'   , 16          , ...
    'FontWeight' , 'bold'      );

%% Print FRC 
print(gcf, '-dpdf', '-r300', 'plots/activity_male_vent_unadj');  
print(gcf, '-dpng', '-r300', 'plots/activity_male_vent_unadj');  