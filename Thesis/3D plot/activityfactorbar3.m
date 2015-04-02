
load('D:\Thesis\CodeRevised\EFHdata_MK.xls','Inhal','surface','frequency');
Inhalbar3=Inhal(3:30,4:11);
Inhal_male=Inhal(3:16,4:11);
+-------------------------------------------------------------------------.
Inhal_female=Inhal(17:30,4:11);
a=1:14;
subplot(2,1,1)
bar3(a,Inhal_male);
hold on;
set(gca,'XTick',[2 4 6 8 9],'FontSize',10);
set(gca,'XTickLabel',{'10th','50th','75th','90th',''})
set(gca,'YTick',[1 4 7 10 13 15],'FontSize',10);
set(gca,'YtickLabel',{'1','5','18','45','76',''});
xlabel('Percentile (%)','FontSize',14);ylabel('Age (years)','FontSize',14); zlabel('Inhalationrate (m^3/day)','FontSize',14);
title('Inhalation rate (male)','FontSize',14);
hold off
subplot(2,1,2)
bar3(a,Inhal_female);
set(gca,'XTick',[2 4 6 8],'FontSize',10);
set(gca,'XTickLabel',{'10th','50th','75th','90th'})
set(gca,'YTick',[1 4 7 10 13 15],'FontSize',10);
set(gca,'YtickLabel',{'1','5','18','45','76',''});
xlabel('Percentile (%)','FontSize',14);ylabel('Age (years)','FontSize',14); zlabel('Inhalationrate (m^3/day)','FontSize',14);
title('Inhalation rate (female)','FontSize',14);
spaceplots


%% skin surface
file_ptr = 'EFHcalculation_MK.xlsx';
data_range   = 'E28:M63';
[skin,~,~] = xlsread(file_ptr,'DermalHand',data_range);
skin_male=skin(1:17,1:9);
b=1:17;
subplot(2,1,1)
bar3(b,skin_male);
hold on
set(gca,'XTick',[2 4 6 8],'FontSize',10);
set(gca,'XTickLabel',{'10th','25th','75th','90th'})
set(gca,'YTick',[1 4 7 10 13 15 17 18],'FontSize',10);
set(gca,'YtickLabel',{'0.1','0.5','5','18','45','65','85',''});
xlabel('Percentile (%)','FontSize',14);ylabel('Age (years)','FontSize',14); zlabel('Surface Area (m^2)','FontSize',14);
title('Human Skin Area (male) ','FontSize',14);
hold off
subplot(2,1,2)
bar3(b,skin_male);
hold on
set(gca,'XTick',[2 4 6 8],'FontSize',10);
set(gca,'XTickLabel',{'10th','25th','75th','90th'})
set(gca,'YTick',[1 4 7 10 13 15 17 18],'FontSize',10);
set(gca,'YtickLabel',{'0.1','0.5','5','18','45','65','85',''});
xlabel('Percentile (%)','FontSize',14);ylabel('Age (years)','FontSize',14); zlabel('Surface Area (m^2)','FontSize',14);
title('Human Skin Area (male)','FontSize',14);
hold off
