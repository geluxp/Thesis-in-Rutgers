%Pollen Trend
clc
clear
Year=1994:2010;
Area=char('Central', 'EastNorthCentral', 'Northeast', 'Northwest', 'South', 'Southeast' ,'Southwest', 'West', 'WestNorthCentral');
if ~isempty(Year)
     for i=1:17
[Betula.(strcat('Year',num2str(Year(i)))),~,~]=xlsread(strcat('D:\Thesis\PollenData\PollenF_',num2str(Year(i))),'Betula');
[Ambrosia.(strcat('Year',num2str(Year(i)))),~,~]=xlsread(strcat('D:\Thesis\PollenData\PollenF_',num2str(Year(i))),'Ambrosia');
[Artemisia.(strcat('Year',num2str(Year(i)))),~,~]=xlsread(strcat('D:\Thesis\PollenData\PollenF_',num2str(Year(i))),'Artemisia');
[Quercus.(strcat('Year',num2str(Year(i)))),~,~]=xlsread(strcat('D:\Thesis\PollenData\PollenF_',num2str(Year(i))),'Quercus');
[Gramineae.(strcat('Year',num2str(Year(i)))),~,~]=xlsread(strcat('D:\Thesis\PollenData\PollenF_',num2str(Year(i))),'Gramineae_Poaceae');
end
%Combine the Betula Data into a matrix
end
%% get the values: first number is the number of the specise(1:ambrosia) the second number is the time group(1:1994-2008)
%1994-2008
[Maxpollen11,Maxmean11,Conc11,PollenMean11]=Max_Pollen(Ambrosia,1);
[Maxpollen21,Maxmean21,Conc21, PollenMean21]=Max_Pollen(Artemisia,1);
[Maxpollen31,Maxmean31, Conc31,PollenMean31]=Max_Pollen(Betula,1);
[Maxpollen41,Maxmean41,Conc41, PollenMean41]=Max_Pollen(Gramineae,1);
[Maxpollen51,Maxmean51,Conc51, PollenMean51]=Max_Pollen(Quercus,1);

%2000-2010
[Maxpollen12,Maxmean12,Conc12, PollenMean12]=Max_Pollen(Ambrosia,2);
[Maxpollen22,Maxmean22,Conc22, PollenMean22]=Max_Pollen(Artemisia,2);
[Maxpollen32,Maxmean32,Conc32, PollenMean32]=Max_Pollen(Betula,2);
[Maxpollen42,Maxmean42,Conc42, PollenMean42]=Max_Pollen(Gramineae,2);
[Maxpollen52,Maxmean52,Conc52, PollenMean52]=Max_Pollen(Quercus,2);

 

 
 %%
 plev = 0:0.1:100;
 fnt_sze = 20;
lne_wdth = 1.5;
colorOrder=[
    1.0 0.0 0.0
    0.5 0.0 0.8
    0.0 0.0 0.0
    0.0 1.0 0.0
    0.0 1.0 1.0
    0.0 0.0 1.0
    1.0 0.0 1.0
    0.5 0.0 0.0
    0.0 0.5 0.5
    0.2 0.0 0.8
    0.8 0.0 0.2
    0.2 0.5 0.8
    0.0 0.5 0.0
    0.5 0.5 0.0
    0.0 0.0 0.5
    0.5 0.0 0.5
    1.0 0.5 0.5
    ];
% lne_styl = {'--b','-r','k','c','g','--k','y','m','b'};

m=1;
h1=figure;
subplot(2,1,1)
for i=1:9
 semilogx(prctile((Conc11.(deblank(Area(i,:)))),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;
     
end
 legend(Area,'Location','SouthEast');
 set(gca,'XTickLabel',{});
 ylabel('Cumulative probability (%)','FontSize',14);
 title('Daily concentration of birch ( Betula )','FontSize',14);
 hold off
subplot(2,1,2)
for i=1:9
 semilogx(prctile((Conc12.(deblank(Area(i,:)))),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;
     
end
 legend(Area,'Location','SouthEast');
 xlabel('Pollen Concentration ( pollen grains/m^3)','FontSize',14);
 ylabel('Cumulative probability (%)','FontSize',14);

 hold off
 spaceplots
 %% artemisia
 m=1;
h1=figure;
subplot(2,1,1)
for i=1:9
 semilogx(prctile((Conc21.(deblank(Area(i,:)))),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;
     
end
 legend(Area,'Location','SouthEast');
 set(gca,'XTickLabel',{});
 ylabel('Cumulative probability (%)','FontSize',14);
 title('Daily concentration of ragweed ( Ambrosia )','FontSize',14);
 hold off
subplot(2,1,2)
for i=1:9
 semilogx(prctile((Conc22.(deblank(Area(i,:)))),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;
     
end
 legend(Area,'Location','SouthEast');
 xlabel('Pollen Concentration ( pollen grains/m^3)','FontSize',14);
 ylabel('Cumulative probability (%)','FontSize',14);
 hold off
 spaceplots
 
 %% betula
  m=1;
h1=figure;
subplot(2,1,1)
for i=1:9
 semilogx(prctile((Conc31.(deblank(Area(i,:)))),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;
     
end
 legend(Area,'Location','SouthEast');
 set(gca,'XTickLabel',{});
 ylabel('Cumulative probability (%)','FontSize',14);
 title('Daily concentration of mugwort ( Artemisia )','FontSize',14);
 hold off
subplot(2,1,2)
for i=1:9
 semilogx(prctile((Conc32.(deblank(Area(i,:)))),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;
     
end
 legend(Area,'Location','SouthEast');
 xlabel('Pollen Concentration ( pollen grains/m^3)','FontSize',14);
 ylabel('Cumulative probability (%)','FontSize',14);
 hold off
 spaceplots
 
%%  gramineae
  m=1;
h1=figure;
subplot(2,1,1)
for i=1:9
 semilogx(prctile((Conc41.(deblank(Area(i,:)))),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;
     
end
 legend(Area,'Location','SouthEast');
 set(gca,'XTickLabel',{});
 ylabel('Cumulative probability (%)','FontSize',14);
 title('Daily concentration of grass ( Gramineae )','FontSize',14);
 hold off
subplot(2,1,2)
for i=1:9
 semilogx(prctile((Conc42.(deblank(Area(i,:)))),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;
     
end
 legend(Area,'Location','SouthEast');
 xlabel('Pollen Concentration ( pollen grains/m^3)','FontSize',14);
 ylabel('Cumulative probability (%)','FontSize',14);
 hold off
 spaceplots
 
 
 %% quercus
 m=1;
h1=figure;
subplot(2,1,1)
for i=1:9
 semilogx(prctile((Conc51.(deblank(Area(i,:)))),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;
     
end
 legend(Area,'Location','SouthEast');
 set(gca,'XTickLabel',{});
 ylabel('Cumulative probability (%)','FontSize',14);
 title('Daily concentration of oak ( Quercus )','FontSize',14);
 hold off
subplot(2,1,2)
for i=1:9
 semilogx(prctile((Conc52.(deblank(Area(i,:)))),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;
     
end
 legend(Area,'Location','SouthEast');
 xlabel('Pollen Concentration ( pollen grains/m^3)','FontSize',14);
 ylabel('Cumulative probability (%)','FontSize',14);
 hold off
 spaceplots
 

