function [Exposurem] = Exposure_Main(ExpsName,SensitiveFactor)

 
 
% ExpsName='test';
% Species=1;
load('D:\Thesis\Code\subcode\RegionPollenDist','Conc1');
 
 ExposureFolder=strcat('D:\Thesis\Code\Cache\',ExpsName);
 
ExpsOptName=strcat(ExposureFolder,'test_1.20');

   vd=vd_value(SensitiveFactor);
 
  [xplev,xpvals,pDist]= ExposureFactorData(SensitiveFactor,vd);
  [ExpoFac] = setExpoFacs(xplev,xpvals,pDist,SensitiveFactor);

  
  expo=cell(6,9);
  for i=1:6
      for j=1:9
  [n,xout]=hist(ExpoFac{i}(j,:),1000);
  frequency=n/length(ExpoFac{i}(j,:));
  expo{i,j}=randsample(xout,5000,true,frequency);
      end
  end
  expo1=cell(4,9);
 for i=1:9
  expo1{1,i}=expo{1,i}+expo{2,i}; %inhalation
  expo1{2,i}=expo{3,i}+expo{4,i}; %dermal
  expo1{3,i}=expo{5,i}+expo{6,i}; %ingestion
 end 
 
 
  Exposurem=nan(9,4);
 
  for i=1:9
   
      Exposurem(i,1)=mean(Conc1(i,:).*expo{1,i});  
    Exposurem(i,2)=mean(Conc1(i,:).*expo{2,i});  
    Exposurem(i,3)=mean(Conc1(i,:).*expo{3,i});  
   
   
      Exposurem(i,4)=Exposurem(i,1)+Exposurem(i,2)+Exposurem(i,3);
   
  end
      
save(strcat(ExpsOptName,'.mat'),'Exposurem')
     
%                 figure; exp =  ExpoFac{1}(unidrnd(5520)) .*pollen1_mean1dint;
%                 semilogx(prctile(exp,plev),plev,lne_styl{1},'LineWidth',lne_wdth);
% %            


end





