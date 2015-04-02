%%
%%Exposure factors Calcuation
exposuremean1=[
               320 163 86 nan 161 73 219 24 664 
               nan nan 85 79 nan 30 146 32 nan 
               100 151 206 167 151 103 nan 111 176
               54 31 38 137 30 83 31 54 196
               274 302 366 61 641 401 464 801  120];
exposuremean2=[
               302 173 83 10 461 17 175 24 20 
               20 12 34 79 25 124 321 105 369 
               121 155 541 166 146 156 7 65 112 
               148 78 82 334 250 27 33 44 38 
               732 942 1277 187 1145 1109 84 214 316];
               

exposuremean=(exposuremean2-exposuremean1)./(exposuremean1);

   
 


 
exposuremean=exposuremean';
 
 signmean=sign(exposuremean); exposuremean=abs(exposuremean); 
 for i=1:9
  for  j=1:5
     exposuremean_log(i,j)=sqrt(log10(exposuremean(i,j)+1));
  end
 end
 exposuremeantest=signmean.*exposuremean_log;
%  

 
    
 


Area=char('Central', 'EastNorthCentral', 'Northeast', 'Northwest',...
'South', 'Southeast' ,'Southwest', 'West', 'WestNorthCentral');

area=cell(9,1);
for i=1:9
    area{i}=deblank(Area(i,:));
end

species=cell(5,1);
species={'Ambrosia' 'Artemisia' 'Betula' 'Gramineae' 'Quercus'};

%% using function imagesc to draw heatmap of concentrations of exposure grains
exposuremeantest=roundn(exposuremeantest,-2);
%   imagesc(exposuremeantest)
  rgcolor=redgreencolormap(exposuremeantest(:));
colormap(rgcolor)
colorbar
imagescwithnan(exposuremeantest,rgcolor,[0 1 1])
  hold on
[rows,cols] = size(exposuremeantest);
for i = 1:rows
    for j = 1:cols
                 textHandles(j,i) = text(j,i,num2str(exposuremeantest(i,j)),...
                'horizontalAlignment','center','fontsize',16);
    end
end



set(gca,'YTick',1:9,'YTickLabel',area,'FontSize',20);
set(gca,'XTick',1:5,'XTickLabel',species,'FontSize',20);
title('Contrast of the mean individuals inhalation intakes of 5 species in 9 regions') 
hold off
