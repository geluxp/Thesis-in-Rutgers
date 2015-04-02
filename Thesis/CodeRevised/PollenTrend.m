
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

save('ConcBetula','Conc31','Conc32');
xlswrite('PollenTrend',Maxmean11',1,'A1');
xlswrite('PollenTrend',Maxmean12',1,'B1');%ambrosia

xlswrite('PollenTrend',Maxmean21',1,'D1');%artemisia
xlswrite('PollenTrend',Maxmean22',1,'E1');

xlswrite('PollenTrend',Maxmean31',1,'G1');%betula
xlswrite('PollenTrend',Maxmean32',1,'H1');

xlswrite('PollenTrend',Maxmean41',1,'J1');%gramineae
xlswrite('PollenTrend',Maxmean42',1,'K1');

xlswrite('PollenTrend',Maxmean51',1,'M1');%quercus
xlswrite('PollenTrend',Maxmean52',1,'N1');

%% do the t-test to the maxpollen data
h=zeros(9,5); p=zeros(9,5);
for i=1:9 %ambrosia
[h(i,1),p(i,1)]=ttest2(Maxpollen11(i,find(Maxpollen11(i,:))),Maxpollen12(i,find(Maxpollen12(i,:))));
end
for i=1:9 %artemisia
[h(i,2),p(i,2)]=ttest2(Maxpollen21(i,find(Maxpollen21(i,:))),Maxpollen22(i,find(Maxpollen22(i,:))));
end
for i=1:9 %betula
[h(i,3),p(i,3)]=ttest2(Maxpollen31(i,find(Maxpollen31(i,:))),Maxpollen32(i,find(Maxpollen32(i,:))));
end
for i=1:9 %gramineae
[h(i,4),p(i,4)]=ttest2(Maxpollen41(i,find(Maxpollen41(i,:))),Maxpollen42(i,find(Maxpollen42(i,:))));
end
for i=1:9 %quercus
[h(i,5),p(i,5)]=ttest2(Maxpollen51(i,find(Maxpollen51(i,:))),Maxpollen52(i,find(Maxpollen52(i,:))));
end


xlswrite('PollenTrend1',PollenMean11',1,'A1');
xlswrite('PollenTrend1',PollenMean12',1,'B1');%ambrosia

xlswrite('PollenTrend1',PollenMean21',1,'D1');%artemisia
xlswrite('PollenTrend1',PollenMean22',1,'E1');

xlswrite('PollenTrend1',PollenMean31',1,'G1');%betula
xlswrite('PollenTrend1',PollenMean32',1,'H1');

xlswrite('PollenTrend1',PollenMean41',1,'J1');%gramineae
xlswrite('PollenTrend1',PollenMean42',1,'K1');

xlswrite('PollenTrend1',PollenMean51',1,'M1');%quercus
xlswrite('PollenTrend1',PollenMean52',1,'N1');

%% do the t-test to the meanpollen data
h1=zeros(9,5); p1=zeros(9,5);
for i=1:9 %ambrosia
[h1(i,1),p1(i,1)]=ttest2(Conc11.(deblank(Area(i,:))),Conc12.(deblank(Area(i,:))));
end
for i=1:9 %artemisia
[h1(i,2),p1(i,2)]=ttest2(Conc21.(deblank(Area(i,:))),Conc22.(deblank(Area(i,:))));
end
for i=1:9 %betula
[h1(i,3),p1(i,3)]=ttest2(Conc31.(deblank(Area(i,:))),Conc32.(deblank(Area(i,:))));
end
for i=1:9 %gramineae
  [h1(i,4),p1(i,4)]=ttest2(Conc41.(deblank(Area(i,:))),Conc42.(deblank(Area(i,:))));
end
for i=1:9 %quercus
[h1(i,5),p1(i,5)]=ttest2(Conc51.(deblank(Area(i,:))),Conc52.(deblank(Area(i,:))));
end


    