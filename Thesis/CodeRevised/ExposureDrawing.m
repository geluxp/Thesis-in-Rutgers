
SensitiveFactor=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
  nMonte=100000;
  Area=char('Central', 'EastNorthCentral', 'Northeast', 'Northwest', 'South', 'Southeast' ,'Southwest', 'West', 'WestNorthCentral');
 
  for i=1:9
   expo([i i+9],:) = generatePopulation_mk(nMonte,SensitiveFactor,i);
  end
  
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

 %% calculation of concentration 
  for i=1:9     
  [n,xout]=hist(Conc11.(deblank(Area(i,:))),2000);
  frequency=n/length(Conc11.(deblank(Area(i,:))));
  conc=randsample(xout,nMonte,true,frequency);
  concout11=conc;
  concin11=conc*1.75./(1.75+10);
 inhal11(i,:)=concin11.*expo(i,:)+concout11.*expo(i+9,:);
  end
   for i=1:9     
  [n,xout]=hist(Conc12.(deblank(Area(i,:))),2000);
  frequency=n/length(Conc12.(deblank(Area(i,:))));
  conc=randsample(xout,nMonte,true,frequency);
  concout11=conc;
  concin11=conc*1.75./(1.75+10);
 inhal12(i,:)=concin11.*expo(i,:)+concout11.*expo(i+9,:);
   end
   for i=1:9     
  [n,xout]=hist(Conc21.(deblank(Area(i,:))),2000);
  frequency=n/length(Conc21.(deblank(Area(i,:))));
  conc=randsample(xout,nMonte,true,frequency);
  concout11=conc;
  concin11=conc*1.75./(1.75+10);
 inhal21(i,:)=concin11.*expo(i,:)+concout11.*expo(i+9,:);
   end
   for i=1:9     
  [n,xout]=hist(Conc22.(deblank(Area(i,:))),2000);
  frequency=n/length(Conc22.(deblank(Area(i,:))));
  conc=randsample(xout,nMonte,true,frequency);
  concout11=conc;
  concin11=conc*1.75./(1.75+10);
 inhal22(i,:)=concin11.*expo(i,:)+concout11.*expo(i+9,:);
   end
   for i=1:9     
  [n,xout]=hist(Conc31.(deblank(Area(i,:))),2000);
  frequency=n/length(Conc31.(deblank(Area(i,:))));
  conc=randsample(xout,nMonte,true,frequency);
  concout11=conc;
  concin11=conc*1.75./(1.75+10);
 inhal31(i,:)=concin11.*expo(i,:)+concout11.*expo(i+9,:);
   end
   for i=1:9     
  [n,xout]=hist(Conc32.(deblank(Area(i,:))),2000);
  frequency=n/length(Conc32.(deblank(Area(i,:))));
  conc=randsample(xout,nMonte,true,frequency);
  concout11=conc;
  concin11=conc*1.75./(1.75+10);
 inhal32(i,:)=concin11.*expo(i,:)+concout11.*expo(i+9,:);
   end
   for i=1:9     
  [n,xout]=hist(Conc41.(deblank(Area(i,:))),2000);
  frequency=n/length(Conc41.(deblank(Area(i,:))));
  conc=randsample(xout,nMonte,true,frequency);
  concout11=conc;
  concin11=conc*1.75./(1.75+10);
 inhal41(i,:)=concin11.*expo(i,:)+concout11.*expo(i+9,:);
   end
   for i=1:9     
  [n,xout]=hist(Conc42.(deblank(Area(i,:))),2000);
  frequency=n/length(Conc42.(deblank(Area(i,:))));
  conc=randsample(xout,nMonte,true,frequency);
  concout11=conc;
  concin11=conc*1.75./(1.75+10);
 inhal42(i,:)=concin11.*expo(i,:)+concout11.*expo(i+9,:);
   end
   for i=1:9     
  [n,xout]=hist(Conc51.(deblank(Area(i,:))),2000);
  frequency=n/length(Conc51.(deblank(Area(i,:))));
  conc=randsample(xout,nMonte,true,frequency);
  concout11=conc;
  concin11=conc*1.75./(1.75+10);
 inhal51(i,:)=concin11.*expo(i,:)+concout11.*expo(i+9,:);
   end
   for i=1:9     
  [n,xout]=hist(Conc52.(deblank(Area(i,:))),2000);
  frequency=n/length(Conc52.(deblank(Area(i,:))));
  conc=randsample(xout,nMonte,true,frequency);
  concout11=conc;
  concin11=conc*1.75./(1.75+10);
 inhal52(i,:)=concin11.*expo(i,:)+concout11.*expo(i+9,:);
   end
   

  
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
inhal11(4,:)=nan;
m=1;
h1=figure;
subplot(2,1,1)
for i=1:9
 semilogx(prctile(inhal11(i,:),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;    
end
 legend(Area,'Location','SouthEast');
 axis([0 20000 0 100]);
 set(gca,'XTickLabel',{});
 ylabel('Cumulative probability (%)','FontSize',14);
 title('Daily individual inhalation intake of birch ( Betula ) pollen' ,'FontSize',14);
 hold off
subplot(2,1,2)
for i=1:9
 semilogx(prctile(inhal12(i,:),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;     
end
 axis([0 20000 0 100]);
 legend(Area,'Location','SouthEast');
 xlabel('Daily intake ( pollen grains/day )','FontSize',14);
 ylabel('Cumulative probability (%)','FontSize',14);

 hold off
 spaceplots
 %% artemisia
 inhal21([1 2 5 9],:)=nan;
 m=1;
h1=figure;
subplot(2,1,1)
for i=1:9
semilogx(prctile(inhal21(i,:),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;         
end
 legend(Area,'Location','SouthEast');
  axis([0 20000 0 100]);
 set(gca,'XTickLabel',{});
 ylabel('Cumulative probability (%)','FontSize',14);
 title('Daily individual inhalation intake of ragweed ( Ambrosia ) pollen','FontSize',14);
 hold off
subplot(2,1,2)
for i=1:9
 semilogx(prctile(inhal22(i,:),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;    
     
end
 legend(Area,'Location','SouthEast'); axis([0 20000 0 100]);
 xlabel('Daily intake ( pollen grains/day )','FontSize',14);
 ylabel('Cumulative probability (%)','FontSize',14);
 hold off
 spaceplots
 
 %% betula
 inhal31(7,:)=nan;
  m=1;
h1=figure;
subplot(2,1,1)
for i=1:9
 semilogx(prctile(inhal31(i,:),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;    
     
end
 legend(Area,'Location','SouthEast');
 set(gca,'XTickLabel',{}); axis([0 20000 0 100]);
 ylabel('Cumulative probability (%)','FontSize',14);
 title('Daily individual inhalation intake of mugwort ( Artemisia ) pollen','FontSize',14);
 hold off
subplot(2,1,2)
for i=1:9
semilogx(prctile(inhal32(i,:),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;    
end
 legend(Area,'Location','SouthEast'); axis([0 20000 0 100]);
 xlabel('Daily intake ( pollen grains/day )','FontSize',14);
 ylabel('Cumulative probability (%)','FontSize',14);
 hold off
 spaceplots
 
%%  gramineae
  m=1;
h1=figure;
subplot(2,1,1)
for i=1:9
 semilogx(prctile(inhal41(i,:),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;    
end
 legend(Area,'Location','SouthEast');
 set(gca,'XTickLabel',{}); axis([0 20000 0 100]);
 ylabel('Cumulative probability (%)','FontSize',14);
 title('Daily individual inhalation intake of grass ( Gramineae ) pollen','FontSize',14);
 hold off
subplot(2,1,2)
for i=1:9
 semilogx(prctile(inhal42(i,:),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;    
     
end
 legend(Area,'Location','SouthEast');
 xlabel('Daily intake ( pollen grains/day )','FontSize',14); axis([0 20000 0 100]);
 ylabel('Cumulative probability (%)','FontSize',14);
 hold off
 spaceplots
 
 
 %% quercus
 inhal51(7,:)=nan;
 m=1;
h1=figure;
subplot(2,1,1)
for i=1:9
 semilogx(prctile(inhal51(i,:),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;    
     
end
 legend(Area,'Location','SouthEast');
 set(gca,'XTickLabel',{}); axis([0 20000 0 100]);
 ylabel('Cumulative probability (%)','FontSize',14);
 title('Daily individual inhalation intake of oak ( Quercus ) pollen','FontSize',14);
 hold off
subplot(2,1,2)
for i=1:9
 semilogx(prctile(inhal52(i,:),plev),plev,'Color',colorOrder(i,:),'LineWidth',lne_wdth); hold on;    
     
end
 legend(Area,'Location','SouthEast'); axis([0 20000 0 100]);
 xlabel('Daily intake ( pollen grains/day )','FontSize',14);
 ylabel('Cumulative probability (%)','FontSize',14);
 hold off
 spaceplots
 
for i=1:9
 pinhal11(i,:)=prctile(inhal11(i,:),plev);
pinhal12(i,:)=prctile(inhal12(i,:),plev);
pinhal21(i,:)=prctile(inhal21(i,:),plev);
pinhal22(i,:)=prctile(inhal22(i,:),plev);
pinhal31(i,:)=prctile(inhal31(i,:),plev);
pinhal32(i,:)=prctile(inhal32(i,:),plev);
pinhal41(i,:)=prctile(inhal41(i,:),plev);
pinhal42(i,:)=prctile(inhal42(i,:),plev);
pinhal51(i,:)=prctile(inhal51(i,:),plev);
pinhal52(i,:)=prctile(inhal52(i,:),plev);
 end
 stat_exposure=cell(5,9);
 
 for i=1:9
stat11(i,:)=[mean(pinhal11(i,:)) std(pinhal11(i,:)) pinhal11(i,250) pinhal11(i,500) pinhal11(i,750) pinhal11(i,950) ];
stat12(i,:)=[mean(pinhal12(i,:)) std(pinhal12(i,:)) pinhal12(i,250) pinhal12(i,500) pinhal12(i,750) pinhal12(i,950) ];
stat21(i,:)=[mean(pinhal21(i,:)) std(pinhal21(i,:)) pinhal21(i,250) pinhal21(i,500) pinhal21(i,750) pinhal21(i,950) ];
stat22(i,:)=[mean(pinhal22(i,:)) std(pinhal22(i,:)) pinhal22(i,250) pinhal22(i,500) pinhal22(i,750) pinhal22(i,950) ];
stat31(i,:)=[mean(pinhal31(i,:)) std(pinhal31(i,:)) pinhal31(i,250) pinhal31(i,500) pinhal31(i,750) pinhal31(i,950) ];
stat32(i,:)=[mean(pinhal32(i,:)) std(pinhal32(i,:)) pinhal32(i,250) pinhal32(i,500) pinhal32(i,750) pinhal32(i,950) ];
stat41(i,:)=[mean(pinhal41(i,:)) std(pinhal41(i,:)) pinhal41(i,250) pinhal41(i,500) pinhal41(i,750) pinhal41(i,950) ];
stat42(i,:)=[mean(pinhal42(i,:)) std(pinhal42(i,:)) pinhal42(i,250) pinhal42(i,500) pinhal42(i,750) pinhal42(i,950) ];
stat51(i,:)=[mean(pinhal51(i,:)) std(pinhal51(i,:)) pinhal51(i,250) pinhal51(i,500) pinhal51(i,750) pinhal51(i,950) ];
stat52(i,:)=[mean(pinhal52(i,:)) std(pinhal52(i,:)) pinhal52(i,250) pinhal52(i,500) pinhal52(i,750) pinhal52(i,950) ];
end
 %%%%%%
 %%
for i=1:9
stat_exposure{1,i}=[mean(sort_exposure1(i,:)) std(sort_exposure1(i,:)) sort_exposure1(i,250) sort_exposure1(i,500) sort_exposure1(i,750) sort_exposure1(i,950) ];
stat_exposure{2,i}=[mean(sort_exposure2(i,:)) std(sort_exposure2(i,:)) sort_exposure2(i,250) sort_exposure2(i,500) sort_exposure2(i,750) sort_exposure2(i,950)];
stat_exposure{3,i}=[mean(sort_exposure3(i,:)) std(sort_exposure3(i,:)) sort_exposure3(i,250) sort_exposure3(i,500) sort_exposure3(i,750) sort_exposure3(i,950)];
stat_exposure{4,i}=[mean(sort_exposure4(i,:)) std(sort_exposure4(i,:)) sort_exposure4(i,250) sort_exposure4(i,500) sort_exposure4(i,750) sort_exposure4(i,950)];
 stat_exposure{5,i}=[mean(sort_exposure5(i,:)) std(sort_exposure5(i,:)) sort_exposure5(i,250) sort_exposure5(i,500) sort_exposure5(i,750) sort_exposure5(i,950)];
end
wholeexposure1=[sort_exposure1(1,:) sort_exposure1(2,:) sort_exposure1(3,:) sort_exposure1(4,:) sort_exposure1(5,:) sort_exposure1(6,:) sort_exposure1(7,:) sort_exposure1(8,:) sort_exposure1(9,:)];
wholeexposure2=[sort_exposure2(1,:) sort_exposure2(2,:) sort_exposure2(3,:) sort_exposure2(4,:) sort_exposure2(5,:) sort_exposure2(6,:) sort_exposure2(7,:) sort_exposure2(8,:) sort_exposure2(9,:)];
wholeexposure3=[sort_exposure3(1,:) sort_exposure3(2,:) sort_exposure3(3,:) sort_exposure3(4,:) sort_exposure3(5,:) sort_exposure3(6,:) sort_exposure3(7,:) sort_exposure3(8,:) sort_exposure3(9,:)];
wholeexposure4=[sort_exposure4(1,:) sort_exposure4(2,:) sort_exposure4(3,:) sort_exposure4(4,:) sort_exposure4(5,:) sort_exposure4(6,:) sort_exposure4(7,:) sort_exposure4(8,:) sort_exposure4(9,:)];
wholeexposure5=[sort_exposure5(1,:) sort_exposure5(2,:) sort_exposure5(3,:) sort_exposure5(4,:) sort_exposure5(5,:) sort_exposure5(6,:) sort_exposure5(7,:) sort_exposure5(8,:) sort_exposure5(9,:)];

usmean4=mean(wholeexposure5)
usstd3=std(wholeexposure5)

 save('stat_exposure.mat','stat_exposure');