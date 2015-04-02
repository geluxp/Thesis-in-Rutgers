 
%%Heatmap
%data test
 load('Concentrations.mat')
 
 pollenmean=zeros(5,9);
 pollenmean(1,:)=-(PollenMean11-PollenMean12)./PollenMean11;
 pollenmean(2,:)=-(PollenMean21-PollenMean22)./PollenMean21;
 pollenmean(3,:)=-(PollenMean31-PollenMean32)./PollenMean31;
 pollenmean(4,:)=-(PollenMean41-PollenMean42)./PollenMean41;
 pollenmean(5,:)=-(PollenMean51-PollenMean52)./PollenMean51;
 
pollenmean=pollenmean';
 
 signmean=sign(pollenmean);
 pollenmean=abs(pollenmean);
 for i=1:9
  for  j=1:5
     pollenmean_log(i,j)=sqrt(log10(pollenmean(i,j)+1));
 end
 end
 pollenmeantest=signmean.*pollenmean_log;

 
    
 


Area=char('Central', 'EastNorthCentral', 'Northeast', 'Northwest',...
'South', 'Southeast' ,'Southwest', 'West', 'WestNorthCentral');

area=cell(9,1);
for i=1:9
    area{i}=deblank(Area(i,:));
end

species=cell(5,1);
species={'Ambrosia' 'Artemisia' 'Betula' 'Gramineae' 'Quercus'};

%% using function imagesc to draw heatmap of concentrations of pollen grains
pollenmeantest=roundn(pollenmeantest,-2);
%   imagesc(pollenmeantest)
  rgcolor=redgreencolormap(pollenmeantest(:));
colormap(rgcolor)
%colorbar
imagescwithnan(pollenmeantest,rgcolor,[0 1 1])
  hold on
[rows,cols] = size(pollenmeantest);
for i = 1:rows
    for j = 1:cols
                 textHandles(j,i) = text(j,i,num2str(pollenmeantest(i,j)),...
                'horizontalAlignment','center','fontsize',12);
    end
end



set(gca,'YTick',1:9,'YTickLabel',area,'FontSize',16);
set(gca,'XTick',1:5,'XTickLabel',species,'FontSize',16);
title('Contrast of 1994-2000 to 2003-2010 of the concentrations of five spesices in nine regions of CONUS') 
hold off

