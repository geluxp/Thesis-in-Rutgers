%This script is used to calculate the normalized sensitivity conefficients
%NSC=[(y2-y1)/y1]/[(x2-x1)/x1]
%-Yong,20130611
%function MorrisOAT_NSC(NSC_Name,NumTraj,k)
 clear; clc;
NSC_Name='NSC_MorrisOAT';
 NumTraj=200;
 k=18;
%upper and lower percentage bounds of variations in input parameters
UpBound=1.5; LowBound=0.5;
%each input parameter has 10 levels
% p=10;
% %the normalized unit changes of input parameter
% delta=p/(2*(p-1));
OutputFile=strcat('D:\Thesis\Code',NSC_Name,'.mat');
%%
%Normalized Sensitivity Coefficients
Exposure=cell(NumTraj,k+1);

ExposureInha=cell(NumTraj,k+1);
ExposureDerm=cell(NumTraj,k+1);
ExposureIngest=cell(NumTraj,k+1);
ExposureTotal=cell(NumTraj,k+1);

%load the daily exposure data
for II=1:NumTraj
    for JJ=1:k+1        
        ExpsName=strcat('NSCexps_Traj',num2str(II),'_Step',num2str(JJ),'test_1.20');
        %1ACH
      
           ExposureTemp1=load(strcat('D:\Thesis\Code\Cache\',ExpsName,'.mat')); 
           ExposureTemp1.Exposurem(:,2)=ExposureTemp1.Exposurem(:,2)/100;
           ExposureTemp1.Exposurem(:,3)=ExposureTemp1.Exposurem(:,3)*40;
           
           ExposureInha{II,JJ}=ExposureTemp1.Exposurem(:,1);
           ExposureDerm{II,JJ}=ExposureTemp1.Exposurem(:,2);
           ExposureIngest{II,JJ}=ExposureTemp1.Exposurem(:,3);
           ExposureTotal{II,JJ}=ExposureTemp1.Exposurem(:,1)+ExposureTemp1.Exposurem(:,2)+ExposureTemp1.Exposurem(:,3);
    end
end
%%
%load the mean daily exposure for base cases
%load('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/NSC_MorrisOAT/ExpsBase.mat');
%load the Orientation matrix for calculation of changes in input parameters
load('D:\Thesis\Code\BStar.mat');
%calculate the chages in parameters for each step and trajectory\
DeltaInput=nan(NumTraj,k);
for II=1:NumTraj
    for JJ=1:k
        deltaV=BStar{II}(JJ+1,:)-BStar{II}(JJ,:);
        deltaP=sum(deltaV);
        NormInputP=BStar{II}(JJ,deltaV~=0);
        DeltaInput(II,JJ)=deltaP*(UpBound-LowBound)/(NormInputP*(UpBound-LowBound)+LowBound);
    end
end        
%%


% for II=1:NumTraj
%     for JJ=1:k    
%         %Normalized Sensitivity Coefficients
%           for i=1:9
%               %9 differenet climate zones
%              
%                   % 5 different species
%                   %Betula
%           NSC.Inha{II,JJ}(i,1)=(-mean(Exposure1{II,JJ}(i,1))+mean(Exposure1{II,JJ+1}(i,1)))/(DeltaInput(II,JJ)*mean(Exposure1{II,JJ}(i,1)));
%           NSC.Derm{II,JJ}(i,1)=(-mean(Exposure1{II,JJ}(i,2))+mean(Exposure1{II,JJ+1}(i,2)))/(DeltaInput(II,JJ)*mean(Exposure1{II,JJ}(i,2)));
%           NSC.Total{II,JJ}(i,1)=(-mean(Exposure1{II,JJ}(i,3))+mean(Exposure1{II,JJ+1}(i,3)))/(DeltaInput(II,JJ)*mean(Exposure1{II,JJ}(i,3))); 
%        %Ambrosia
%            NSC.Inha{II,JJ}(i,2)=(-mean(Exposure2{II,JJ}(i,1))+mean(Exposure2{II,JJ+1}(i,1)))/(DeltaInput(II,JJ)*mean(Exposure2{II,JJ}(i,1)));
%           NSC.Derm{II,JJ}(i,2)=(-mean(Exposure2{II,JJ}(i,2))+mean(Exposure2{II,JJ+1}(i,2)))/(DeltaInput(II,JJ)*mean(Exposure2{II,JJ}(i,2)));
%           NSC.Total{II,JJ}(i,2)=(-mean(Exposure2{II,JJ}(i,3))+mean(Exposure2{II,JJ+1}(i,3)))/(DeltaInput(II,JJ)*mean(Exposure2{II,JJ}(i,3))); 
%           %Artemisia
%            NSC.Inha{II,JJ}(i,3)=(-mean(Exposure3{II,JJ}(i,1))+mean(Exposure3{II,JJ+1}(i,1)))/(DeltaInput(II,JJ)*mean(Exposure3{II,JJ}(i,1)));
%           NSC.Derm{II,JJ}(i,3)=(-mean(Exposure3{II,JJ}(i,2))+mean(Exposure3{II,JJ+1}(i,2)))/(DeltaInput(II,JJ)*mean(Exposure3{II,JJ}(i,2)));
%           NSC.Total{II,JJ}(i,3)=(-mean(Exposure3{II,JJ}(i,3))+mean(Exposure3{II,JJ+1}(i,3)))/(DeltaInput(II,JJ)*mean(Exposure3{II,JJ}(i,3))); 
%           %Gramineae
%            NSC.Inha{II,JJ}(i,4)=(-mean(Exposure4{II,JJ}(i,1))+mean(Exposure4{II,JJ+1}(i,1)))/(DeltaInput(II,JJ)*mean(Exposure4{II,JJ}(i,1)));
%           NSC.Derm{II,JJ}(i,4)=(-mean(Exposure4{II,JJ}(i,2))+mean(Exposure4{II,JJ+1}(i,2)))/(DeltaInput(II,JJ)*mean(Exposure4{II,JJ}(i,2)));
%           NSC.Total{II,JJ}(i,4)=(-mean(Exposure4{II,JJ}(i,3))+mean(Exposure4{II,JJ+1}(i,3)))/(DeltaInput(II,JJ)*mean(Exposure4{II,JJ}(i,3))); 
%           %Quercus
%            NSC.Inha{II,JJ}(i,5)=(-mean(Exposure5{II,JJ}(i,1))+mean(Exposure5{II,JJ+1}(i,1)))/(DeltaInput(II,JJ)*mean(Exposure5{II,JJ}(i,1)));
%           NSC.Derm{II,JJ}(i,5)=(-mean(Exposure5{II,JJ}(i,2))+mean(Exposure5{II,JJ+1}(i,2)))/(DeltaInput(II,JJ)*mean(Exposure5{II,JJ}(i,2)));
%           NSC.Total{II,JJ}(i,5)=(-mean(Exposure5{II,JJ}(i,3))+mean(Exposure5{II,JJ+1}(i,3)))/(DeltaInput(II,JJ)*mean(Exposure5{II,JJ}(i,3))); 
%           
%            NSC.Inha{II,JJ}(i,1)=(-mean(Exposure1{II,JJ}(i,1))+mean(Exposure1{II,JJ+1}(i,1)))/(DeltaInput(II,JJ)*mean(Exposure1{II,JJ}(i,1)));
%           NSC.Derm{II,JJ}(i,1)=(-mean(Exposure1{II,JJ}(i,2))+mean(Exposure1{II,JJ+1}(i,2)))/(DeltaInput(II,JJ)*mean(Exposure1{II,JJ}(i,2)));
%           NSC.Total{II,JJ}(i,1)=(-mean(Exposure1{II,JJ}(i,3))+mean(Exposure1{II,JJ+1}(i,3)))/(DeltaInput(II,JJ)*mean(Exposure1{II,JJ}(i,3))); 
%          end
%     end
% end
for i=1:9
  for II=1:NumTraj
    for JJ=1:k    
        %Normalized Sensitivity Coefficients
          
          NSC.Inha{II,JJ}(i)=(-mean(ExposureInha{II,JJ}(i))+mean(ExposureInha{II,JJ+1}(i)))/(DeltaInput(II,JJ)*mean(ExposureInha{II,JJ}(i)));
          NSC.Derm{II,JJ}(i)=(-mean(ExposureDerm{II,JJ}(i))+mean(ExposureDerm{II,JJ+1}(i)))/(DeltaInput(II,JJ)*mean(ExposureDerm{II,JJ}(i)));
          NSC.Ingest{II,JJ}(i)=(-mean(ExposureIngest{II,JJ}(i))+mean(ExposureIngest{II,JJ+1}(i)))/(DeltaInput(II,JJ)*mean(ExposureIngest{II,JJ}(i)));
          NSC.Total{II,JJ}(i)=(-mean(ExposureTotal{II,JJ}(i))+mean(ExposureTotal{II,JJ+1}(i)))/(DeltaInput(II,JJ)*mean(ExposureTotal{II,JJ}(i))); 
     end
   end
end

%%
% NSC_Inge.ACH1=NSC_1ACH_Inge;
% NSC_Inge.ACH29=NSC_29ACH_Inge;
% NSC_Inge.RA=NSC_RA_Inge;
% NSC_Inha.ACH1=NSC_1ACH_Inha;
% NSC_Inha.ACH29=NSC_29ACH_Inha;
% NSC_Inha.RA=NSC_RA_Inha;
% NSC_Derm.ACH1=NSC_1ACH_Derm;
% NSC_Derm.ACH29=NSC_29ACH_Derm;
% NSC_Derm.RA=NSC_RA_Derm;
% NSC_Total.ACH1=NSC_1ACH_Total;
% NSC_Total.ACH29=NSC_29ACH_Total;
% NSC_Total.RA=NSC_RA_Total;
%%
%save the data
save(OutputFile,'NSC'); 
