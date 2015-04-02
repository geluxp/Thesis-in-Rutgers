%This script is used to visualize the NSC based on Morris's design
%-Yong,20130611
%function MorrisOAT_Visual()
clear;clc
OutDir='\\n30\store6\yongz\FAA_Exposure\FAA_SSI\NSC_MorrisOAT\';
NSC_Data=load('\\n30\store6\yongz\FAA_Exposure\FAA_SSI\NSC_MorrisOAT\NSC_MorrisOAT.mat');
LabelNum=1:21;
%%
%%%Calculation of mean NSC based on 500 trajectories, eahc has 22 steps
%Ingestion
NSCMean_Inge_ACH1=nanmean(NSC_Data.NSC_Inge.ACH1,1);
NSCMean_Inge_ACH29=nanmean(NSC_Data.NSC_Inge.ACH29,1);
NSCMean_Inge_RA=nanmean(NSC_Data.NSC_Inge.RA,1);
%Inhalation
%there are some artifacts for inhalation NSC (ACH1 and ACH29) due to (1)
%short period of spraying and (2)just twenty trips were used to calculate
%the mean. This issue can be solved by increasing the simulated number of
%trips
InhaNSCMean_ACH1=mean(NSC_Data.NSC_Inha.ACH1((NSC_Data.NSC_Inha.ACH1<=20) & (NSC_Data.NSC_Inha.ACH1>=-20)));
NSC_Data.NSC_Inha.ACH1((NSC_Data.NSC_Inha.ACH1>=20) | (NSC_Data.NSC_Inha.ACH1<=-20))=InhaNSCMean_ACH1;
NSCMean_Inha_ACH1=nanmean(NSC_Data.NSC_Inha.ACH1,1);
InhaNSCMean_ACH29=mean(NSC_Data.NSC_Inha.ACH29((NSC_Data.NSC_Inha.ACH29<=20) & (NSC_Data.NSC_Inha.ACH29>=-20)));
NSC_Data.NSC_Inha.ACH29((NSC_Data.NSC_Inha.ACH29>=20) | (NSC_Data.NSC_Inha.ACH29<=-20))=InhaNSCMean_ACH29;
NSCMean_Inha_ACH29=nanmean(NSC_Data.NSC_Inha.ACH29,1);
NSCMean_Inha_RA=nanmean(NSC_Data.NSC_Inha.RA,1);
%Derm
NSCMean_Derm_ACH1=nanmean(NSC_Data.NSC_Derm.ACH1,1);
NSCMean_Derm_ACH29=nanmean(NSC_Data.NSC_Derm.ACH29,1);
NSCMean_Derm_RA=nanmean(NSC_Data.NSC_Derm.RA,1);
%Total
NSCMean_Total_ACH1=nanmean(NSC_Data.NSC_Total.ACH1,1);
NSCMean_Total_ACH29=nanmean(NSC_Data.NSC_Total.ACH29,1);
NSCMean_Total_RA=nanmean(NSC_Data.NSC_Total.RA,1);
%%%Calculation of standard deviations of NSC based on 500 trajectories, eahc has 22 steps
%Ingestion
%Ingestion
NSCStd_Inge_ACH1=nanstd(NSC_Data.NSC_Inge.ACH1,1);
NSCStd_Inge_ACH29=nanstd(NSC_Data.NSC_Inge.ACH29,1);
NSCStd_Inge_RA=nanstd(NSC_Data.NSC_Inge.RA,1);
%Inhalation
NSCStd_Inha_ACH1=nanstd(NSC_Data.NSC_Inha.ACH1,1);
NSCStd_Inha_ACH29=nanstd(NSC_Data.NSC_Inha.ACH29,1);
NSCStd_Inha_RA=nanstd(NSC_Data.NSC_Inha.RA,1);
%Derm
NSCStd_Derm_ACH1=nanstd(NSC_Data.NSC_Derm.ACH1,1);
NSCStd_Derm_ACH29=nanstd(NSC_Data.NSC_Derm.ACH29,1);
NSCStd_Derm_RA=nanstd(NSC_Data.NSC_Derm.RA,1);
%Total
NSCStd_Total_ACH1=nanstd(NSC_Data.NSC_Total.ACH1,1);
NSCStd_Total_ACH29=nanstd(NSC_Data.NSC_Total.ACH29,1);
NSCStd_Total_RA=nanstd(NSC_Data.NSC_Total.RA,1);
%%
% %save the data
% NSCMean_Inge=[NSCMean_Inge_RA;NSCMean_Inge_ACH1;NSCMean_Inge_ACH29];
% NSCStd_Inge=[NSCStd_Inge_RA;NSCStd_Inge_ACH1;NSCStd_Inge_ACH29];
% NSCMean_Inha=[NSCMean_Inha_RA;NSCMean_Inha_ACH1;NSCMean_Inha_ACH29];
% NSCStd_Inha=[NSCStd_Inha_RA;NSCStd_Inha_ACH1;NSCStd_Inha_ACH29];
% NSCMean_Derm=[NSCMean_Derm_RA;NSCMean_Derm_ACH1;NSCMean_Derm_ACH29];
% NSCStd_Derm=[NSCStd_Derm_RA;NSCStd_Derm_ACH1;NSCStd_Derm_ACH29];
% NSCMean_Total=[NSCMean_Total_RA;NSCMean_Total_ACH1;NSCMean_Total_ACH29];
% NSCStd_Total=[NSCStd_Total_RA;NSCStd_Total_ACH1;NSCStd_Total_ACH29];
% %
% OutData='\\n30\store6\yongz\FAA_Exposure\FAA_SSI\NSC_MorrisOAT\NSCg.mat';
% save(OutData,'NSCMean_Inge','NSCMean_Inha','NSCMean_Derm','NSCMean_Total',...
%     'NSCStd_Inge','NSCStd_Inha','NSCStd_Derm','NSCStd_Total');
%%
%visualization
%h2=figure('units','inches','position',[1 1 11.5 9]);
h1=figure('units','inches','position',[1 1 6.2 5]);
subplot(2,2,1)
plot(NSCMean_Inge_ACH1,NSCStd_Inge_ACH1,'bo');hold on;
plot(NSCMean_Inge_ACH29,NSCStd_Inge_ACH29,'g^');
plot(NSCMean_Inge_RA,NSCStd_Inge_RA,'rs');
%
plot(-0.09828,4,'g^');
text(-0.09828,4,'16','Color','g','FontSize',12);
axis([-0.55 0.5 0 4.3]);
line('XData', [0 0], 'YData', ylim, 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
% line('XData', [-1 1 1 -1 -1], 'YData',[0 0 1 1 0] , 'LineStyle', '-', ...
%     'LineWidth', 3, 'Color','k');
set(gca,'YTick',1:4,'XTickLabel',{},'FontSize',12);
text(-0.5,0.5,'A. Ingestion','FontSize',14);
text(NSCMean_Inge_ACH1,NSCStd_Inge_ACH1,cellstr(num2str(LabelNum')),'Color','b','FontSize',12);
text(NSCMean_Inge_ACH29,NSCStd_Inge_ACH29,cellstr(num2str(LabelNum')),'Color','g','FontSize',12);
text(NSCMean_Inge_RA,NSCStd_Inge_RA,cellstr(num2str(LabelNum')),'Color','r','FontSize',12);
%title('Ingestion')
hold off;
%
subplot(2,2,2)
plot(NSCMean_Inha_ACH1,NSCStd_Inha_ACH1,'bo');hold on;
plot(NSCMean_Inha_ACH29,NSCStd_Inha_ACH29,'g^');
plot(NSCMean_Inha_RA,NSCStd_Inha_RA,'rs');
axis([-0.55 0.5 0 4.3]);
line('XData', [0 0], 'YData', ylim, 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
% line('XData', [-1 1 1 -1 -1], 'YData',[0 0 1 1 0] , 'LineStyle', '-', ...
%     'LineWidth', 3, 'Color','k');
set(gca,'YTickLabel',{},'XTickLabel',{},'FontSize',12);
text(-0.5,0.5,'B. Inhalation','FontSize',14);
%text(NSCMean_Inha_ACH1,NSCStd_Inha_ACH1,cellstr(num2str(LabelNum')),'Color','b','FontSize',12);
%text(NSCMean_Inha_ACH29,NSCStd_Inha_ACH29,cellstr(num2str(LabelNum')),'Color','g','FontSize',12);
%text(NSCMean_Inha_RA,NSCStd_Inha_RA,cellstr(num2str(LabelNum')),'Color','r','FontSize',12);
legend('Preflight Spray','Top of Descent Spray','Residual Application','Location','NorthWest');
%title('Inhalation')
hold off;
%
subplot(2,2,3)
plot(NSCMean_Derm_ACH1,NSCStd_Derm_ACH1,'bo');hold on;
plot(NSCMean_Derm_ACH29,NSCStd_Derm_ACH29,'g^');
plot(NSCMean_Derm_RA,NSCStd_Derm_RA,'rs');
%
plot(-0.08721,4,'g^');
text(-0.08721,4,'16','Color','g','FontSize',12);
axis([-0.55 0.5 0 4.3]);
line('XData', [0 0], 'YData', ylim, 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
% line('XData', [-1 1 1 -1 -1], 'YData',[0 0 1 1 0] , 'LineStyle', '-', ...
%     'LineWidth', 3, 'Color','k');
set(gca,'YTick',1:4,'XTick',[-0.4 0 0.4],'FontSize',12);
text(-0.5,0.5,'C. Dermal','FontSize',14);
%text(NSCMean_Derm_ACH1,NSCStd_Derm_ACH1,cellstr(num2str(LabelNum')),'Color','b','FontSize',12);
%text(NSCMean_Derm_ACH29,NSCStd_Derm_ACH29,cellstr(num2str(LabelNum')),'Color','g','FontSize',12);
text(NSCMean_Derm_RA,NSCStd_Derm_RA,cellstr(num2str(LabelNum')),'Color','r','FontSize',12);
text(-0.25,-0.6,'Mean of Normalized Sensitivity Coefficient (unitless)','FontSize',14);
text(-0.65,1,'Standard Deviation of NSC (unitless)','rotation',90,'FontSize',14);
%title('Derm')
hold off;
%
subplot(2,2,4)
plot(NSCMean_Total_ACH1,NSCStd_Total_ACH1,'bo');hold on;
plot(NSCMean_Total_ACH29,NSCStd_Total_ACH29,'g^');
plot(NSCMean_Total_RA,NSCStd_Total_RA,'rs');
%
plot(-0.5268,4,'g^');
text(-0.5268,4,'16','Color','g','FontSize',12);
axis([-0.55 0.5 0 4.3]);
line('XData', [0 0], 'YData', ylim, 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
% line('XData', [-1 1 1 -1 -1], 'YData',[0 0 1 1 0] , 'LineStyle', '-', ...
%     'LineWidth', 3, 'Color','k');
set(gca,'YTickLabel',{},'XTick',[-0.4 0 0.4],'FontSize',12);
text(-0.5,0.5,'D. Total','FontSize',14);
%text(NSCMean_Total_ACH1,NSCStd_Total_ACH1,cellstr(num2str(LabelNum')),'Color','b','FontSize',12);
%text(NSCMean_Total_ACH29,NSCStd_Total_ACH29,cellstr(num2str(LabelNum')),'Color','g','FontSize',12);
text(NSCMean_Total_RA,NSCStd_Total_RA,cellstr(num2str(LabelNum')),'Color','r','FontSize',12);
%title('Total')
hold off;
spaceplots([0.04 0.00 0.00 0.045],[0.00 0.00]);
%save the figure
% OutputFile1=strcat(OutDir,'NSC_MorrisOAT');
% saveas(h1,OutputFile1,'fig');
% saveas(h1,OutputFile1,'psc2');
% print(h1,'-dpdf','-r300',OutputFile1);
%%
% %visualization
% h2=figure('units','inches','position',[1 1 4.5 9]);
% subplot(3,1,1)
% plot(NSCMean_Inge_ACH1,NSCStd_Inge_ACH1,'bo');hold on;
% plot(NSCMean_Inha_ACH1,NSCStd_Inha_ACH1,'rs');
% plot(NSCMean_Derm_ACH1,NSCStd_Derm_ACH1,'g^');
% plot(NSCMean_Total_ACH1,NSCStd_Total_ACH1,'k*');
% text(NSCMean_Total_ACH1,NSCStd_Total_ACH1,cellstr(num2str(LabelNum')));
% title('Preflight Spray')
% hold off;
% %
% subplot(3,1,2)
% plot(NSCMean_Inge_ACH29,NSCStd_Inge_ACH29,'bo');hold on;
% plot(NSCMean_Inha_ACH29,NSCStd_Inha_ACH29,'rs');
% plot(NSCMean_Derm_ACH29,NSCStd_Derm_ACH29,'g^');
% plot(NSCMean_Total_ACH29,NSCStd_Total_ACH29,'k*');
% text(NSCMean_Total_ACH29,NSCStd_Total_ACH29,cellstr(num2str(LabelNum')));
% title('Top of Descent Spray')
% hold off;
% %
% subplot(3,1,3)
% plot(NSCMean_Inge_RA,NSCStd_Inge_RA,'bo');hold on;
% plot(NSCMean_Inha_RA,NSCStd_Inha_RA,'rs');
% plot(NSCMean_Derm_RA,NSCStd_Derm_RA,'g^');
% plot(NSCMean_Total_RA,NSCStd_Total_RA,'k*');
% text(NSCMean_Derm_RA,NSCStd_Derm_RA,cellstr(num2str(LabelNum')));
% legend('Ingestion','Inhalation','Dermal','Total','Location','NorthEast');
% title('Residual Application')
% hold off;
%%
h3=figure('units','inches','position',[1 1 9 6]);
X1=0.5:3:60.5;
X2=1:3:61;
X3=1.5:3:61.5;
X4=2:3:62;
subplot(3,1,1);
errorbar(X1,NSCMean_Inge_ACH1,NSCStd_Inge_ACH1,'bo');hold on;
errorbar(X2,NSCMean_Inha_ACH1,NSCStd_Inha_ACH1,'rs');
errorbar(X3,NSCMean_Derm_ACH1,NSCStd_Derm_ACH1,'g^');
errorbar(X4,NSCMean_Total_ACH1,NSCStd_Total_ACH1,'kv');
line('XData', xlim, 'YData', [0 0], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','k');
line('XData', xlim, 'YData', [2 2], 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
line('XData', xlim, 'YData', [-2 -2], 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
set(gca,'XTick',1.25:3:61.25,'XTickLabel',{});
set(gca,'YTick',[-3 0 3]);
set(gca,'FontSize',12);
text(28.25,4.5,'A. Preflight Spray','FontSize',14);
axis([-0.5 63 -5.6 5.6]);
hold off;
%
subplot(3,1,2);
errorbar(X1,NSCMean_Inge_ACH29,NSCStd_Inge_ACH29,'bo');hold on;
errorbar(X2,NSCMean_Inha_ACH29,NSCStd_Inha_ACH29,'rs');
errorbar(X3,NSCMean_Derm_ACH29,NSCStd_Derm_ACH29,'g^');
errorbar(X4,NSCMean_Total_ACH29,NSCStd_Total_ACH29,'kv');
line('XData', xlim, 'YData', [0 0], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','k');
line('XData', xlim, 'YData', [2 2], 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
line('XData', xlim, 'YData', [-2 -2], 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
set(gca,'XTick',1.25:3:61.25,'XTickLabel',{});
set(gca,'FontSize',12);
set(gca,'YTick',[-3 0 3]);
text(1,3.7,'Upper Threshold NSC','FontSize',14);
text(1,-3.7,'Lower Threshold NSC','FontSize',14);
text(28.25,4.5,'B. Top of Descent Spray','FontSize',14);
axis([-0.5 63 -5.6 5.6]);
%title('Top of Descent Spray')
hold off;
subplot(3,1,3);
errorbar(X1,NSCMean_Inge_RA,NSCStd_Inge_RA,'bo');hold on;
errorbar(X2,NSCMean_Inha_RA,NSCStd_Inha_RA,'rs');
errorbar(X3,NSCMean_Derm_RA,NSCStd_Derm_RA,'g^');
errorbar(X4,NSCMean_Total_RA,NSCStd_Total_RA,'kv');
line('XData', xlim, 'YData', [0 0], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','k');
line('XData', xlim, 'YData', [2 2], 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
line('XData', xlim, 'YData', [-2 -2], 'LineStyle', '-.', ...
    'LineWidth', 1.5, 'Color','k');
set(gca,'XTick',1.25:3:61.25,'XTickLabel',{});
set(gca,'FontSize',12);
set(gca,'YTick',[-3 0 3]);
text(28.25,4.5,'C. Residual Application','FontSize',14);
%text(28,-50,'Parameters','FontSize',14);
text(-3,-3,'Mean and Standard Deviation of NSC (unitless)','FontSize',14,'rotation',90);
axis([-0.5 63 -5.6 5.6]);
legend('Ingestion','Inhalation','Dermal','Total','Location','SouthWest');
%title('Residual Application')
 XlabelText={'TN_{HSi}','TE_{Bi}','TE_{SHi}','k_d','k_v','T2','T1','T3',...
     'P_O','f','BW','S_H','P_H','P_D','TE_{HM}','TN_{HM}','P_{OAR}','In','F_{BS}','TE_{DS}','P_{EX}'};
 text(X1,-6.5*ones(size(X1)),XlabelText,'FontSize',11,'FontAngle','italic');
%text(X1,-45*ones(size(X1)),cellstr(num2str(LabelNum')),'FontSize',12,'FontAngle','italic');
hold off;
spaceplots([0.03 0.00 0.00 0.04],[0.00 0.00]);
%save the figure
% OutputFile3=strcat(OutDir,'NSC_ErrorBar');
% saveas(h3,OutputFile3,'fig');
% saveas(h3,OutputFile3,'psc2');
% print(h3,'-dpdf','-r300',OutputFile3);
%%
%calculate average absolute global NSC, abs(NSCg)
clear;clc
load('\\n30\store6\yongz\FAA_Exposure\FAA_SSI\NSC_MorrisOAT\NSCg.mat');
%exposure paths
NSC_Inge_AA=mean(mean(abs(NSCMean_Inge)));
NSC_Inha_AA=mean(mean(abs(NSCMean_Inha)));
NSC_Derm_AA=mean(mean(abs(NSCMean_Derm)));
NSC_Total_AA=mean(mean(abs(NSCMean_Total)));
%average absolute NSC for individual input parameters
NSC_kd_AA=mean(mean([abs(NSCMean_Inge(:,4)) abs(NSCMean_Inha(:,4)) abs(NSCMean_Derm(:,4)) abs(NSCMean_Total(:,4))]));
NSC_TEsh_AA=mean(mean([abs(NSCMean_Inge(:,3)) abs(NSCMean_Inha(:,3)) abs(NSCMean_Derm(:,3)) abs(NSCMean_Total(:,3))]));
NSC_BW_AA=mean(mean([abs(NSCMean_Inge(:,11)) abs(NSCMean_Inha(:,11)) abs(NSCMean_Derm(:,11)) abs(NSCMean_Total(:,11))]));
NSC_TEds_AA=mean(mean([abs(NSCMean_Inge(:,20)) abs(NSCMean_Inha(:,20)) abs(NSCMean_Derm(:,20)) abs(NSCMean_Total(:,20))]));
NSC_FBS_AA=mean(mean([abs(NSCMean_Inge(:,19)) abs(NSCMean_Inha(:,19)) abs(NSCMean_Derm(:,19)) abs(NSCMean_Total(:,19))]));
%average absolute NSC for exposure scenarios
NSC_Rsd_AA=mean([abs(NSCMean_Inge(1,:)) abs(NSCMean_Inha(1,:)) abs(NSCMean_Derm(1,:)) abs(NSCMean_Total(1,:))]);
NSC_Prflt_AA=mean([abs(NSCMean_Inge(2,:)) abs(NSCMean_Inha(2,:)) abs(NSCMean_Derm(2,:)) abs(NSCMean_Total(2,:))]);
NSC_TOD_AA=mean([abs(NSCMean_Inge(3,:)) abs(NSCMean_Inha(3,:)) abs(NSCMean_Derm(3,:)) abs(NSCMean_Total(3,:))]);
%average STD for exposure scenario
NSCStd_Rsd_AA=mean([abs(NSCStd_Inge(1,:)) abs(NSCStd_Inha(1,:)) abs(NSCStd_Derm(1,:)) abs(NSCStd_Total(1,:))]);
NSCStd_Prflt_AA=mean([abs(NSCStd_Inge(2,:)) abs(NSCStd_Inha(2,:)) abs(NSCStd_Derm(2,:)) abs(NSCStd_Total(2,:))]);
NSCStd_TOD_AA=mean([abs(NSCStd_Inge(3,:)) abs(NSCStd_Inha(3,:)) abs(NSCStd_Derm(3,:)) abs(NSCStd_Total(3,:))]);
%average STD for input parameters
NSCStd_f_AA=mean(mean([abs(NSCStd_Inge(:,10)) abs(NSCStd_Inha(:,10)) abs(NSCStd_Derm(:,10)) abs(NSCStd_Total(:,10))]));
NSCStd_Pd_AA=mean(mean([abs(NSCStd_Inge(:,14)) abs(NSCStd_Inha(:,14)) abs(NSCStd_Derm(:,14)) abs(NSCStd_Total(:,14))]));
NSCStd_TNhm_AA=mean(mean([abs(NSCStd_Inge(:,16)) abs(NSCStd_Inha(:,16)) abs(NSCStd_Derm(:,16)) abs(NSCStd_Total(:,16))]));


