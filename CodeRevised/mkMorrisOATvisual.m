%This script is used to visualize the NSC based on Morris's design
%-Yong,20130611
%function MorrisOAT_Visual()
clear;clc
OutDir='\\n30\store6\yongz\FAA_Exposure\FAA_SSI\NSC_MorrisOAT\';
load('D:\Thesis\codeNSC_MorrisOAT.mat');
LabelNum=1:18;
%%
%reshape the cell array
MatInha=cell2mat(NSC.Inha);
MatDerm=cell2mat(NSC.Derm);
MatIngest=cell2mat(NSC.Ingest);
MatTotal=cell2mat(NSC.Total);
%%%Calculation of mean NSC based on 100 trajectories, eahc has 17 steps
%Inhalation
NSCMean_Inha=reshape(nanmean(MatInha,1),1,18)*10;
%Derm
NSCMean_Derm=reshape(nanmean(MatDerm,1),1,18)*10;
%Ingest
NSCMean_Ingest=reshape(nanmean(MatIngest,1),1,18)*10;
%Total
NSCMean_Total=reshape(nanmean(MatTotal,1),1,18)*10;


%%%Calculation of standard deviations of NSC based on 500 trajectories, eahc has 22 steps
%Inhalation
NSCStd_Inha=reshape(nanstd(MatInha,1),1,18);
%Derm
NSCStd_Derm=reshape(nanstd(MatDerm,1),1,18);
%Ingestion
NSCStd_Ingest=reshape(nanstd(MatIngest,1),1,18);
%Total
NSCStd_Total=reshape(nanstd(MatTotal,1),1,18);
%% reshape the mean and standard deviation.
 i=1;
%visualization
%h2=figure('units','inches','position',[1 1 11.5 9]);
subplot(2,2,1)
plot(NSCMean_Inha(i,:),NSCStd_Inha(i,:),'bo');hold on;
 axis([-0.2 0.4  0.1 0.4]);
% text(0.010,0.45,'A. Inhalation');
% set(gca,'XTickLabel',{});
% set(gca,'YTickLabel',0.2:0.4/4:0.6);
text(NSCMean_Inha(1,:),NSCStd_Inha(i,:),cellstr(num2str(LabelNum')),'Color','b','FontSize',10);
hold off;
subplot(2,2,2)
plot(NSCMean_Derm(i,:),NSCStd_Derm(i,:),'r^');hold on;
text(0.010,0.45,'B. Dermal');
line('XData', [0 0], 'YData', [0.2 0.6], 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
set(gca,'YTickLabel',{});
text(NSCMean_Derm(i,:),NSCStd_Derm(i,:),cellstr(num2str(LabelNum')),'Color','r','FontSize',10);
 axis([-0.2 0.4  0.1 0.4])
%set(gca,'XTickLabel',{},'YTickLabel',{});
hold off;
subplot(2,2,3)
plot(NSCMean_Ingest(i,:),NSCStd_Ingest(i,:),'gd');hold on;
 axis([-0.2 0.4  0.1 0.4])
text(0.010,0.45,'C. Ingestion');
text(0.2,0.13,'Mean of Normalized Sensitivity Coefficient (unitless)');
text(-0.06,0.4,'Standard Deviation of NSC (unitless)','rotation',90);
text(NSCMean_Ingest(i,:),NSCStd_Ingest(i,:),cellstr(num2str(LabelNum')),'Color','g','FontSize',10);
hold off;
subplot(2,2,4) 
plot(NSCMean_Total(i,:),NSCStd_Total(i,:),'gd');hold on;
 axis([-0.2 0.4  0.1 0.4])
text(0.010,0.45,'D. Total');
line('XData', [0 0], 'YData', [0.2 0.8], 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
set(gca,'YTickLabel',{});
text(NSCMean_Total(i,:),NSCStd_Total(i,:),cellstr(num2str(LabelNum')),'Color','k','FontSize',10);
hold off
%spaceplots([0.04 0.00 0.00 0.06],[0.00 0.00]);
%save the figure

%%
%visualization and contrast
h2=figure('units','inches','position',[1 1 4.5 9]);
hold on
plot(NSCMean_Inha,NSCStd_Inha,'bo');
plot(NSCMean_Derm,NSCStd_Derm,'r^');
plot(NSCMean_Ingest,NSCStd_Ingest,'gd');
plot(NSCMean_Total,NSCStd_Total,'ks');
title('Contrast of the coeificents')
hold off;
%

h=figure;hold on
for i=1:9;
%errorbar


subplot(3,3,i);hold on
X2=1:97.5/16:98.5;
X3=1.5:97.5/16:99;
X4=2:97.5/16:99.5;

errorbar(X2,NSCMean_Inha(i,:),NSCStd_Inha(i,:),'rs');
errorbar(X3,NSCMean_Derm(i,:),NSCStd_Derm(i,:),'g^');
errorbar(X4,NSCMean_Total(i,:),NSCStd_Total(i,:),'kv');
  line('XData', xlim, 'YData', [0 0], 'LineStyle', '-', ...
      'LineWidth', 2, 'Color','k');
  axis ([-1 101 -0.5 1.5]);
% % line('XData', xlim, 'YData', [2 2], 'LineStyle', '-.', ...
% %     'LineWidth', 1.5, 'Color','k');
% % line('XData', xlim, 'YData', [-2 -2], 'LineStyle', '-.', ...
% %     'LineWidth', 1.5, 'Color','k');
%  set(gca,'XTick',1.25:3:61.25,'XTickLabel',{});
% set(gca,'YTick',[-3 0 3]);
% set(gca,'FontSize',12);
%text(28.25,4.5,'contrast of these zones','FontSize',14);


end
absmean_inha=mean(abs(NSCMean_Inha));
absmean_Derm=mean(abs(NSCMean_Derm));
absmean_Ingest=mean(abs(NSCMean_Ingest));
absmean_Total=mean(abs(NSCMean_Total));

meanstd_dermal=mean(NSCStd_Derm);
meanstd_ingest=mean(NSCStd_Ingest);

