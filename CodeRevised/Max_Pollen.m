function [ Maxpollen,Maxmean,Conc,PollenMean] = Max_Pollen(pollen, time)
Year=1994:2010;
Area=char('Central', 'EastNorthCentral', 'Northeast', 'Northwest', 'South', 'Southeast' ,'Southwest', 'West', 'WestNorthCentral');
% time=1;
Betula=pollen;

   if time==1
      minv=1;
      for i=1:7 % combine the Betula data from 1994 to 2000 into one dataset
     maxv=minv+size(Betula.(strcat('Year',num2str(Year(i)))),1)-1;
     PollenBetula1(minv:maxv,1:3)=Betula.(strcat('Year',num2str(Year(i))));
     PollenBetula1(minv:maxv,4)=i;
     minv=maxv+1;
    
      end
   else
      minv=1;
    for i=10:17 % combine the Betula data from 1994 to 2000 into one dataset
     maxv=minv+size(Betula.(strcat('Year',num2str(Year(i)))),1)-1;
     PollenBetula1(minv:maxv,1:3)=Betula.(strcat('Year',num2str(Year(i))));
     PollenBetula1(minv:maxv,4)=i;
     minv=maxv+1;
    end
  end
% divide them in to different region groups
PollenBetula=round(PollenBetula1*10^2)/10^2; 

[station,~,~]=xlsread('D:\Thesis\PollenData\Pollen-station_climate-zone_near-table','StationInfo_Valid');
latitude=station(:,3);
m=[1 7 11 27 31 40 46 50 58];
n=[6 10 26 30 39 45 49 57 60];
for i=1:9
a=0;
for j=m(i):n(i)
  b=(PollenBetula==latitude(j));
    a=a+b;
end
test=find(a==1);
Region.(deblank(Area(i,:)))=PollenBetula(test,[1 3 4]);
end




 
%%find the maxium pollen concentration for each monitor station in each year
k=1;
Maxpollen=zeros(9,70);
for i=1:9
    Temp=Region.(deblank(Area(i,:)));
    t=1;
    for j=1:length(Temp)-1
    if Temp(j+1,1)==Temp(j,1)&&Temp(j+1,3)==Temp(j,3)&&j~=length(Temp)-1
        dummy_matrix(k)=Temp(j,2);
        k=k+1;
    else
        Maxpollen(i,t)=max(dummy_matrix);
        dummy_matrix=1;
        t=t+1;k=1;
    end
         end
    
end
% mean for each climate region
      for i=1:9
          temp=Maxpollen(i,:);
          Maxmean(i)=mean(temp(temp~=0));
      end

for i=1:9
Conc.(deblank(Area(i,:)))=Region.(deblank(Area(i,:)))(:,2);
Conc.(deblank(Area(i,:)))(Conc.(deblank(Area(i,:)))==0)=[];

end


for i=1:9
    tempt=Conc.(deblank(Area(i,:)));
    PollenMean(i)=mean(tempt); 
 
end

% j=1;k=1;
% for i=1:length(test_trend)-1
%     if test_trend(i+1,1)==test_trend(i,1)
%         dummy_matrix(j,k)=test_trend(i,2);
%         j=j+1;
%     else 
%          dummy_matrix(j,k)=test_trend(i,2);
%         j=1;k=k+1;
%     end


end

