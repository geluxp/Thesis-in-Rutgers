
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
% import 5 different pollen data from xls files from year 1994 to 2010

if ~isempty(Betula)
for i=1:17
size1=size(Betula.(strcat('Year',num2str(Year(i)))),1);
size2=size(Ambrosia.(strcat('Year',num2str(Year(i)))),1);
size3=size(Artemisia.(strcat('Year',num2str(Year(i)))),1);
size4=size(Gramineae.(strcat('Year',num2str(Year(i)))),1);
size5=size(Quercus.(strcat('Year',num2str(Year(i)))),1);
end
PollenBetula1=zeros(size1,3);
PollenBetula2=zeros(size2,3);
PollenBetula3=zeros(size3,3);
PollenBetula4=zeros(size4,3);
PollenBetula5=zeros(size5,3);
min1=1;
min2=1;
min3=1;
min4=1;
min5=1;
for i=1:17
     max1=min1+size(Betula.(strcat('Year',num2str(Year(i)))),1)-1;
     max2=min2+size(Ambrosia.(strcat('Year',num2str(Year(i)))),1)-1;
     max3=min3+size(Artemisia.(strcat('Year',num2str(Year(i)))),1)-1;
     max4=min4+size(Gramineae.(strcat('Year',num2str(Year(i)))),1)-1;
     max5=min5+size(Quercus.(strcat('Year',num2str(Year(i)))),1)-1;
    PollenBetula1(min1:max1,:)=Betula.(strcat('Year',num2str(Year(i))))(:,:);
    PollenAmbrosia1(min2:max2,:)=Ambrosia.(strcat('Year',num2str(Year(i))))(:,:);
    PollenArtemisia1(min3:max3,:)=Artemisia.(strcat('Year',num2str(Year(i))))(:,:);
    PollenGramineae1(min4:max4,:)=Gramineae.(strcat('Year',num2str(Year(i))))(:,:);
    PollenQuercus1(min5:max5,:)=Quercus.(strcat('Year',num2str(Year(i))))(:,:);
    min1=max1+1;
    min2=max2+1;
    min3=max3+1;
    min4=max4+1;
    min5=max5+1;
end
PollenBetula=round(PollenBetula1*10^2)/10^2; 
 PollenAmbrosia=round( PollenAmbrosia1*10^2)/10^2; 
PollenArtemisia=round(PollenArtemisia1*10^2)/10^2; 
PollenGramineae=round(PollenGramineae1*10^2)/10^2; 
PollenQuercus=round(PollenQuercus1*10^2)/10^2; 
end
% combine the data to form a single matrix,the output is PollenBetula

if ~isempty(Area)
[n,~,~]=xlsread('D:\Thesis\PollenData\Pollen-station_climate-zone_near-table','StationInfo_Valid');
latitude=n(:,3);
m=[1 7 11 27 31 40 46 50 58];
n=[6 10 26 30 39 45 49 57 60];
for i=1:9
a1=0;a2=0;a3=0;a4=0;a5=0;

for j=m(i):n(i)
    b1=(PollenBetula==latitude(j));
    b2=(PollenAmbrosia==latitude(j));
    b3=(PollenArtemisia==latitude(j));
    b4=(PollenGramineae==latitude(j));
    b5=(PollenQuercus==latitude(j));
    a1=a1+b1;a2=a2+b2;a3=a3+b3;a4=a4+b4;a5=a5+b5;
end
test1=find(a1==1);test2=find(a2==1);test3=find(a3==1);test4=find(a4==1);test5=find(a5==1);
RegionBetula.(deblank(Area(i,:)))=PollenBetula(test1,3);
RegionAmbrosia.(deblank(Area(i,:)))=PollenAmbrosia(test2,3);
RegionArtemisia.(deblank(Area(i,:)))=PollenArtemisia(test3,3);
RegionGramineae.(deblank(Area(i,:)))=PollenGramineae(test4,3);
RegionQuercus.(deblank(Area(i,:)))=PollenQuercus(test5,3);

end

for i=1:9
RegionBetula.(deblank(Area(i,:)))(RegionBetula.(deblank(Area(i,:)))==0)=[];
RegionAmbrosia.(deblank(Area(i,:)))(RegionAmbrosia.(deblank(Area(i,:)))==0)=[];
RegionArtemisia.(deblank(Area(i,:)))(RegionArtemisia.(deblank(Area(i,:)))==0)=[];
RegionGramineae.(deblank(Area(i,:)))(RegionGramineae.(deblank(Area(i,:)))==0)=[];
RegionQuercus.(deblank(Area(i,:)))(RegionQuercus.(deblank(Area(i,:)))==0)=[];
end
%remove the zero value in the matrice
end
% put the pollen values into different climate regions


Conc=cell(5,9);

%%
for i=1:9
     a=length(RegionAmbrosia.(deblank(Area(i,:))));
     b=length(RegionArtemisia.(deblank(Area(i,:))));
    c=length(RegionBetula.(deblank(Area(i,:))));
    d=length(RegionGramineae.(deblank(Area(i,:))));
    e=length(RegionQuercus.(deblank(Area(i,:))));
    if a<=3000
    RegionAmbrosia.(deblank(Area(i,:)))=[RegionAmbrosia.(deblank(Area(i,:))) zeros((3313-a),1)];
    end
    if b<1247
        RegionArtemisia.(deblank(Area(i,:)))=[RegionArtemisia.(deblank(Area(i,:))) zeros((1247-a),1)];
    end
    if c<2284
        RegionBetula.(deblank(Area(i,:)))=[RegionBetula.(deblank(Area(i,:))) zeros((2284-a),1)];
    end
    if d<5000
        RegionGramineae.(deblank(Area(i,:)))=[RegionGramineae.(deblank(Area(i,:))) zeros((7152-a),1)];
    end
    if e<3610
        RegionQuercus.(deblank(Area(i,:)))=[RegionGramineae.(deblank(Area(i,:))) zeros((2284-a),1)];

    end
    
    
    
%make histogram distribution
for i=1:9  

        
[n,xout]=hist(RegionBetula.(deblank(Area(i,:))),1000);
frequency=n/length(RegionBetula.(deblank(Area(i,:))));
Conc{3,i}=randsample(xout,5000,true,frequency);

end

for i=1:9
[n,xout]=hist(RegionAmbrosia.(deblank(Area(i,:))),1000);

frequency=n/length(RegionAmbrosia.(deblank(Area(i,:))));
Conc(1,:)=randsample(xout,5000,true,frequency);
end

for i=1:9
[n,xout]=hist(RegionArtemisia.(deblank(Area(i,:))),1000);

frequency=n/length(RegionArtemisia.(deblank(Area(i,:))));
Conc(2,i)=randsample(xout,5000,true,frequency);
end

for i=1:9
[n,xout]=hist(RegionGramineae.(deblank(Area(i,:))),1000);

frequency=n/length(RegionGramineae.(deblank(Area(i,:))));
Conc(4,i)=randsample(xout,5000,true,frequency);
end

for i=1:9
[n,xout]=hist(RegionQuercus.(deblank(Area(i,:))),1000);

frequency=n/length(RegionQuercus.(deblank(Area(i,:))));
Conc(5,i)=randsample(xout,5000,true,frequency);
end





% fnt_sze = 20;
% lne_wdth = 3;
% lne_styl = {'-b','-.g','-r','-b','-r','--g',':b'};
% plev = [0:100];
%     if ~isempty(Region)
%               for i=1:9
%                 %num_data_sets = num_data_sets + 1;
%                 figure;
%                 semilogx(prctile(Region.(deblank(Area(i,:))),plev),plev,lne_styl{1},'LineWidth',lne_wdth); 
%               xlabel('pollen numbers','FontSize',14);
%               ylabel('percentile','FontSize',14);
%               end         
%         end
  
save('RegionPollenDist','Area','RegionBetula','RegionAmbrosia','RegionArtemisia','RegionGramineae','RegionQuercus','Conc1','Conc2','Conc3','Conc4','Conc5');


