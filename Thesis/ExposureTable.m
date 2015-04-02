load('RegionPollenDist','Area','Region','Conc1','Conc2','Conc3','Conc4','Conc5');
load('RegionPollenDist');
%%
vd=0.0929;
SensitiveFactor=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
  [xplev,xpvals,pDist]= ExposureFactorData(SensitiveFactor,vd);
  [ExpoFac] = setExpoFacs(xplev,xpvals,pDist,SensitiveFactor);
  %set of the exposure factors
expo=cell(6,9);
  for i=1:6
      for j=1:9
  [n,xout]=hist(ExpoFac{i}(j,:),2000);
  frequency=n/length(ExpoFac{i}(j,:));
  expo{i,j}=randsample(xout,5000,true,frequency);
      end
  end
 for i=1:9
  expo{1,i}=expo{1,i}+expo{2,i}; %inhalation
  expo{2,i}=expo{3,i}+expo{4,i};%dermal
  expo{3,i}=expo{5,i}+expo{6,i};%ingest
 end 
 %normalized the size of the dataset to 5000 in order to coupled with the
 %following calculation.
 
 %Reform the concentration and normalization


    
 plev = 0:0.1:100;
 for i=1:9
    
     ExposureCal5_inhal(i,:)=Conc5(i,:).*expo{1,i}; 
     ExposureCal5_ingest(i,:)=Conc5(i,:).*expo{2,i};
     ExposureCal5_dermal(i,:)=Conc5(i,:).*expo{3,i};
     ExposureCal5(i,:)=ExposureCal5_inhal(i,:)+ExposureCal5_ingest(i,:)+ExposureCal5_dermal(i,:);
 end   
  for i=1:9
    
     ExposureCal4_inhal(i,:)=Conc4(i,:).*expo{1,i}; 
     ExposureCal4_ingest(i,:)=Conc4(i,:).*expo{2,i};
     ExposureCal4_dermal(i,:)=Conc4(i,:).*expo{3,i};
     ExposureCal4(i,:)=ExposureCal4_inhal(i,:)+ExposureCal4_ingest(i,:)+ExposureCal4_dermal(i,:);
  end   
  for i=1:9
    
     ExposureCal3_inhal(i,:)=Conc3(i,:).*expo{1,i}; 
     ExposureCal3_ingest(i,:)=Conc3(i,:).*expo{2,i};
     ExposureCal3_dermal(i,:)=Conc3(i,:).*expo{3,i};
     ExposureCal3(i,:)=ExposureCal3_inhal(i,:)+ExposureCal3_ingest(i,:)+ExposureCal3_dermal(i,:);
     
  end   
  for i=1:9
    
     ExposureCal2_inhal(i,:)=Conc2(i,:).*expo{1,i}; 
     ExposureCal2_ingest(i,:)=Conc2(i,:).*expo{2,i};
     ExposureCal2_dermal(i,:)=Conc2(i,:).*expo{3,i};
     ExposureCal2(i,:)=ExposureCal2_inhal(i,:)+ExposureCal2_ingest(i,:)+ExposureCal2_dermal(i,:);
    
  end   
  for i=1:9
    
     ExposureCal1_inhal(i,:)=Conc1(i,:).*expo{1,i}; 
     ExposureCal1_ingest(i,:)=Conc1(i,:).*expo{2,i};
     ExposureCal1_dermal(i,:)=Conc1(i,:).*expo{3,i};
     ExposureCal1(i,:)=ExposureCal1_inhal(i,:)+ExposureCal1_ingest(i,:)+ExposureCal1_dermal(i,:);
  end  
 for i=1:9
 sort_exposure1(i,:)=prctile(ExposureCal1(i,:),plev);
sort_exposure2(i,:)=prctile(ExposureCal2(i,:),plev);
sort_exposure3(i,:)=prctile(ExposureCal3(i,:),plev);
sort_exposure4(i,:)=prctile(ExposureCal4(i,:),plev);
sort_exposure5(i,:)=prctile(ExposureCal5(i,:),plev);
 end
 stat_exposure=cell(5,9);
 
for i=1:9
stat_exposure{1,i}=[mean(sort_exposure1(i,:)) std(sort_exposure1(i,:)) sort_exposure1(i,250) sort_exposure1(i,500) sort_exposure1(i,750) sort_exposure1(i,950) ];
stat_exposure{2,i}=[mean(sort_exposure2(i,:)) std(sort_exposure2(i,:)) sort_exposure2(i,250) sort_exposure2(i,500) sort_exposure2(i,750) sort_exposure2(i,950)];
stat_exposure{3,i}=[mean(sort_exposure3(i,:)) std(sort_exposure3(i,:)) sort_exposure3(i,250) sort_exposure3(i,500) sort_exposure3(i,750) sort_exposure3(i,950)];
stat_exposure{4,i}=[mean(sort_exposure4(i,:)) std(sort_exposure4(i,:)) sort_exposure4(i,250) sort_exposure4(i,500) sort_exposure4(i,750) sort_exposure4(i,950)];
 stat_exposure{5,i}=[mean(sort_exposure5(i,:)) std(sort_exposure5(i,:)) sort_exposure5(i,250) sort_exposure5(i,500) sort_exposure5(i,750) sort_exposure5(i,950)];
end
wholeexposure1=[sort_exposure1(1,:) sort_exposure1(2,:) sort_exposure1(3,:) sort_exposure1(4,:) sort_exposure1(5,:) sort_exposure1(6,:) sort_exposure1(7,:) sort_exposure1(8,:) sort_exposure1(9,:)];
wholeexposure2=[sort_exposure2(1,:) sort_exposure2(2,:) sort_exposure2(3,:) sort_exposure2(4,:) sort_exposure2(5,:) sort_exposure2(6,:) sort_exposure2(7,:) sort_exposure2(8,:) sort_exposure2(9,:)];
wholeexposure3=[sort_exposure3(1,:) sort_exposure3(2,:) sort_exposure3(3,:) sort_exposure3(4,:) sort_exposure3(5,:) sort_exposure3(6,:) sort_exposure3(7,:) sort_exposure3(8,:) sort_exposure3(9,:)];
wholeexposure4=[sort_exposure4(1,:) sort_exposure4(2,:) sort_exposure4(3,:) sort_exposure4(4,:) sort_exposure4(5,:) sort_exposure4(6,:) sort_exposure4(7,:) sort_exposure4(8,:) sort_exposure4(9,:)];
wholeexposure5=[sort_exposure5(1,:) sort_exposure5(2,:) sort_exposure5(3,:) sort_exposure5(4,:) sort_exposure5(5,:) sort_exposure5(6,:) sort_exposure5(7,:) sort_exposure5(8,:) sort_exposure5(9,:)];

usmean4=mean(wholeexposure5)
usstd3=std(wholeexposure5)

 save('stat_exposure.mat','stat_exposure');