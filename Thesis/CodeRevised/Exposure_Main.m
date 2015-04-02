function [Exposurem] = Exposure_Main(ExpsName,SensitiveFactor)
% ExpsName='43564';
%  SensitiveFactor=ones(18,1);
 nMonte=50000;
% ExpsName='test';
% Species=1;
load('ConcBetula','Conc32');
 load('RegionPollenDist','Conc1');
 ExposureFolder=strcat('D:\Thesis\Code\Cache\',ExpsName);
 
ExpsOptName=strcat(ExposureFolder,'test_1.20');

  [ExpoFac] = generatePopulation_mk(nMonte,SensitiveFactor,1);

  
  [n,xout]=hist(Conc1(1,:),1000);
  frequency=n/length(Conc1(1,:));
  conc=randsample(xout,nMonte,true,frequency);
  concout=conc;
  concin=conc*1.75*SensitiveFactor(16)./(1.75*SensitiveFactor(16)+10);
   

 inhal=concin'.*ExpoFac.in.inh+concout'.*ExpoFac.out.inh;
  ingest=concin'.*ExpoFac.in.ingest+concout'.*ExpoFac.out.ingest;
   dermal=concin'.*ExpoFac.in.dermal+concout'.*ExpoFac.out.dermal;
 

 

   i=1;
      Exposurem(i,1)=nanmean(inhal)  ;
    Exposurem(i,2)=nanmean(ingest);
    Exposurem(i,3)=nanmean(dermal);
   
   
      Exposurem(i,4)=Exposurem(i,1)+Exposurem(i,2)+Exposurem(i,3);
   
 
      
save(strcat(ExpsOptName,'.mat'),'Exposurem')
     
%                 figure; exp =  ExpoFac{1}(unidrnd(5520)) .*pollen1_mean1dint;
%                 semilogx(prctile(exp,plev),plev,lne_styl{1},'LineWidth',lne_wdth);
% %            


end





