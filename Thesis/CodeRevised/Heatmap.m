%%Heatmap
%data test
data = rand(9,5);

Area=char('Central', 'EastNorthCentral', 'Northeast', 'Northwest',...
'South', 'Southeast' ,'Southwest', 'West', 'WestNorthCentral');

area=cell(9,1);
for i=1:9
    area{i}=deblank(Area(i,:));
end

species=cell(5,1);
species={'Ambrosia' 'Artemisia' 'Betula' 'Gramineae' 'Quercus'};


hmo = HeatMap(data,'Rowlabels',area,'Columnlabels', species,'ColumnLabelsRotate',0,'Annotate','on',...
'LabelsWithMarkers',0);
addXLabel(hmo, 'Times', 'FontSize', 12, 'FontAngle', 'Italic')
plot(hmo)
view(hmo)
hold on
colorbar('East');


x=rand(100,1);
plot(cos(x),x);
hold on
colorbar('East');
hold off

%% using function imagesc



  imagesc(data)
  hold on
[rows,cols] = size(data);
for i = 1:rows
    for j = 1:cols
                 textHandles(j,i) = text(j,i,num2str(data(i,j)),...
                'horizontalAlignment','center');
    end
end
set(gca,'YTick',1:9,'YTickLabel',area,'FontSize',14);
set(gca,'XTick',1:5,'XTickLabel',species,'FontSize',14);
title('Contrast of 1994-2000 to 2003-2010 of the exposure intakes of five spesices in nine regions of CONUS');

