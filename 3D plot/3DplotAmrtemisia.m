%this script is used to creat 3D line plot for airborne pollen count for different years 
%and add the duration lines on each peak
%By Yong & Ting, Aug-19-2013
%%
%function Pollen_3D_Birch_TingC_Final
clear;clc;
Spec='Amtemisia';
Station='Newark_NJ';%'CherryHill_NJ';
Lat=42.599877;%39.935819;    
YearR=[2010:-1:1994];
YearAll=2010:-1:1994;
%InputfileI=strcat('C:\Documents and Settings\kunmei\My Documents\Thesis\PollenData\PollenF_',num2str(YearI),'.xls');
%%
%get the data
Pollen_Conc = cell(1,length(YearR));%Preallocation
Pollen_Day  = cell(1,length(YearR));%Preallocation
Pollen_Year = cell(1,length(YearR));%Preallocation
for i=1:length(YearR)
    YearI=YearR(i);
    InputfileI=strcat('D:\Thesis\PollenData\PollenF_',num2str(YearI),'.xls');
    [N,T,R] = xlsread(InputfileI,Spec);
    id=find(N(:,1)==Lat);
    if size(id)
    Day_1st=datenum(strcat('01/01/',num2str(YearI)));
    Pollen_DayI=datenum(R(id,3))-Day_1st+1;
    Pollen_ConcI=N(id,3);
    idDay=find((Pollen_DayI>=180) & (Pollen_DayI<=300));%tree (Betula) pollen season can not exceed Jun 30
    Pollen_Day{i}=Pollen_DayI(idDay);
    Pollen_Year{i}=YearI*ones(length(Pollen_Day{i}),1);
    Pollen_Conc{i}=Pollen_ConcI(idDay); 
    end
       
    
    if length(Pollen_Year{i})==0
          Pollen_Day{i}=[63 ;64 ;65];
    Pollen_Year{i}=YearI*ones(length(Pollen_Day{i}),1);
    Pollen_Conc{i}=[1; 1; 1];
    end
    
end
%%
Pollen_StartDate = cell(1,length(YearR));%Preallocation
Pollen_EndDate   = cell(1,length(YearR));%Preallocation
Pollen_Year2     = cell(1,length(YearR));%Preallocation
Pollen_PeakConc  = cell(1,length(YearR));%Preallocation
% for i=1:length(YearR)
%     YearI=YearR(i);
%     InputfileI=strcat('\\N30\store5\yongz\PollenProject\Historical_US\Pollen-Data-Bielory\Newark_Pollen\Newark_PollenInfo_',num2str(YearI),'.xls');
%     [N,T,R] = xlsread(InputfileI,Spec);
%     id=find(N(:,8)==Lat);
%     if size(id)
%     Pollen_StartDateI=N(id,1);
%     Pollen_EndDateI=N(id,2);
%     Pollen_PeakConcI=N(id,7);
%     idDay=find(Pollen_StartDateI<=365);%longday spring-flowing speacies should flower before June 22, 172; 
%     Pollen_StartDate{i}=Pollen_StartDateI(idDay);
%     Pollen_EndDate{i}=Pollen_EndDateI(idDay);
%     Pollen_Year2{i}=YearI*ones(length(Pollen_StartDate{i}),1);
%     Pollen_PeakConc{i}=Pollen_PeakConcI(idDay); 
%     end    
% end
%%
%add extra points to the plot to close the polygons
Pollen_Year_Closed = cell(size(Pollen_Year));
Pollen_Day_Closed  = cell(size(Pollen_Year));
Pollen_Conc_Closed = cell(size(Pollen_Year));
for i=1:length(YearR)
    dummy1 = cell2mat((Pollen_Year(i)));
    Pollen_Year_Closed{i} = [dummy1(1); dummy1; dummy1(end)];
    dummy2 = cell2mat((Pollen_Day(i)));
    Pollen_Day_Closed{i} = [dummy2(1); dummy2; dummy2(end)];
    dummy3 = cell2mat((Pollen_Conc(i)));
    Pollen_Conc_Closed{i} = [0; dummy3; 0];    
end

%%
%visulization
h=figure; 
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
hold on
for i = 1:length(YearR)
    IdxColor=find(YearAll==YearR(i));
    plot3(cell2mat(Pollen_Year_Closed(i)),cell2mat(Pollen_Day_Closed(i)),cell2mat(Pollen_Conc_Closed(i)),'k')
    fill3(cell2mat(Pollen_Year_Closed(i)),cell2mat(Pollen_Day_Closed(i)),cell2mat(Pollen_Conc_Closed(i)),colorOrder(IdxColor,:))
    plot3([cell2mat(Pollen_Year2(i)),cell2mat(Pollen_Year2(i))],...
    [cell2mat(Pollen_StartDate(i)),cell2mat(Pollen_EndDate(i))],...
    [cell2mat(Pollen_PeakConc(i)),cell2mat(Pollen_PeakConc(i))], 'color', colorOrder(IdxColor,:),'LineWidth',1.2)    
end

% label and view
axis([1994 2010 180 300 0 1200]);
grid on;
box off;
zlab=zlabel('Pollen Conc. (grain/m^3)');
set(zlab,'FontSize',14);
datestr(60+datenum('2010-01-01')-1,'mmdd');
set(gca,'YTick',[ 211 241 271],'FontSize',12);
set(gca,'YTickLabel',{'August','September 01','October 01'})
set(gca,'XTick',[1995 2000 2005 2010],'FontSize',12);
set(gca,'ZTick',[0 300 600 900 1200],'FontSize',12);
hold off
view(22.5,26);
spaceplots([0.0 0 0 0.0],[0.00 0.00]);
%%
Area=1:9;
% set(h,'PaperPositionMode','auto');
%  saveas(h,OutputFile,strcat('fig',num2str(Area)));
% saveas(h,OutputFile,'psc2');
% print(h,'-dpdf','-r300',OutputFile);