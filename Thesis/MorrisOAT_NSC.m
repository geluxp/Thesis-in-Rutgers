%This script is used to calculate the normalized sensitivity conefficients
%NSC=[(y2-y1)/y1]/[(x2-x1)/x1]
%-Yong,20130611
function MorrisOAT_NSC(NumTraj,k)
% clear; clc;
NSC_Name='NSC_MorrisOAT';
% NumTraj=500;
% k=21;
%upper and lower percentage bounds of variations in input parameters
UpBound=1.5; LowBound=0.5;
%each input parameter has 10 levels
% p=10;
% %the normalized unit changes of input parameter
% delta=p/(2*(p-1));
OutputFile=strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/NSC_MorrisOAT/',NSC_Name,'.mat');
%%
%Normalized Sensitivity Coefficients
Exposure_1ACH=cell(NumTraj,k+1);
Exposure_29ACH=cell(NumTraj,k+1);
Exposure_RA=cell(NumTraj,k+1);
NSC_1ACH_Inge=nan(NumTraj,k);
NSC_1ACH_Inha=nan(NumTraj,k);
NSC_1ACH_Derm=nan(NumTraj,k);
NSC_1ACH_Total=nan(NumTraj,k);
NSC_29ACH_Inge=nan(NumTraj,k);
NSC_29ACH_Inha=nan(NumTraj,k);
NSC_29ACH_Derm=nan(NumTraj,k);
NSC_29ACH_Total=nan(NumTraj,k);
NSC_RA_Inge=nan(NumTraj,k);
NSC_RA_Inha=nan(NumTraj,k);
NSC_RA_Derm=nan(NumTraj,k);
NSC_RA_Total=nan(NumTraj,k);
%load the daily exposure data
parfor II=1:NumTraj
    for JJ=1:k+1        
        ExpsName=strcat('NSCexps_Traj',num2str(II),'_Step',num2str(JJ));
        %1ACH
        if exist(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults/',ExpsName,'_1ACH-spray'),'dir')
           ExposureTemp_1ACH=load(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults/',ExpsName,'_1ACH-spray/Exposure_Cabin_1_Female_Daily.mat')); 
        else
           ExposureTemp_1ACH=load(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults2/',ExpsName,'_1ACH-spray/Exposure_Cabin_1_Female_Daily.mat'));             
        end
           Exposure_1ACH{II,JJ}=ExposureTemp_1ACH.Exposure;
        %29ACH
        if exist(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults/',ExpsName,'_29ACH-spray'),'dir')
           ExposureTemp_29ACH=load(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults/',ExpsName,'_29ACH-spray/Exposure_Cabin_1_Female_Daily.mat')); 
        else
           ExposureTemp_29ACH=load(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults2/',ExpsName,'_29ACH-spray/Exposure_Cabin_1_Female_Daily.mat'));             
        end
           Exposure_29ACH{II,JJ}=ExposureTemp_29ACH.Exposure;
        %Residual application
        if exist(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults/',ExpsName,'_residual-application'),'dir')
           ExposureTemp_RA=load(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults/',ExpsName,'_residual-application/Exposure_Cabin_1_Female_Daily.mat')); 
        else
           ExposureTemp_RA=load(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults2/',ExpsName,'_residual-application/Exposure_Cabin_1_Female_Daily.mat'));             
        end
           Exposure_RA{II,JJ}=ExposureTemp_RA.Exposure;
    end
end
%%
%load the mean daily exposure for base cases
%load('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/NSC_MorrisOAT/ExpsBase.mat');
%load the Orientation matrix for calculation of changes in input parameters
load('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/NSC_MorrisOAT/BStar.mat');
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
for II=1:NumTraj
    for JJ=1:k
        %Normalized Sensitivity Coefficients
          %Preflight,1ACH
          NSC_1ACH_Inge(II,JJ)=(-mean(Exposure_1ACH{II,JJ}.Inge)+mean(Exposure_1ACH{II,JJ+1}.Inge))/(DeltaInput(II,JJ)*mean(Exposure_1ACH{II,JJ}.Inge));
          NSC_1ACH_Inha(II,JJ)=(-mean(Exposure_1ACH{II,JJ}.Inha)+mean(Exposure_1ACH{II,JJ+1}.Inha))/(DeltaInput(II,JJ)*mean(Exposure_1ACH{II,JJ}.Inha));
          NSC_1ACH_Derm(II,JJ)=(-mean(Exposure_1ACH{II,JJ}.Derm)+mean(Exposure_1ACH{II,JJ+1}.Derm))/(DeltaInput(II,JJ)*mean(Exposure_1ACH{II,JJ}.Derm));
          NSC_1ACH_Total(II,JJ)=(-mean(Exposure_1ACH{II,JJ}.Total)+mean(Exposure_1ACH{II,JJ+1}.Total))/(DeltaInput(II,JJ)*mean(Exposure_1ACH{II,JJ}.Total));
          %Top-of-Descent
          NSC_29ACH_Inge(II,JJ)=(-mean(Exposure_29ACH{II,JJ}.Inge)+mean(Exposure_29ACH{II,JJ+1}.Inge))/(DeltaInput(II,JJ)*mean(Exposure_29ACH{II,JJ}.Inge));
          NSC_29ACH_Inha(II,JJ)=(-mean(Exposure_29ACH{II,JJ}.Inha)+mean(Exposure_29ACH{II,JJ+1}.Inha))/(DeltaInput(II,JJ)*mean(Exposure_29ACH{II,JJ}.Inha));
          NSC_29ACH_Derm(II,JJ)=(-mean(Exposure_29ACH{II,JJ}.Derm)+mean(Exposure_29ACH{II,JJ+1}.Derm))/(DeltaInput(II,JJ)*mean(Exposure_29ACH{II,JJ}.Derm));
          NSC_29ACH_Total(II,JJ)=(-mean(Exposure_29ACH{II,JJ}.Total)+mean(Exposure_29ACH{II,JJ+1}.Total))/(DeltaInput(II,JJ)*mean(Exposure_29ACH{II,JJ}.Total));
          %Residual application
          NSC_RA_Inge(II,JJ)=(-mean(Exposure_RA{II,JJ}.Inge)+mean(Exposure_RA{II,JJ+1}.Inge))/(DeltaInput(II,JJ)*mean(Exposure_RA{II,JJ}.Inge));
          NSC_RA_Inha(II,JJ)=(-mean(Exposure_RA{II,JJ}.Inha)+mean(Exposure_RA{II,JJ+1}.Inha))/(DeltaInput(II,JJ)*mean(Exposure_RA{II,JJ}.Inha));
          NSC_RA_Derm(II,JJ)=(-mean(Exposure_RA{II,JJ}.Derm)+mean(Exposure_RA{II,JJ+1}.Derm))/(DeltaInput(II,JJ)*mean(Exposure_RA{II,JJ}.Derm));
          NSC_RA_Total(II,JJ)=(-mean(Exposure_RA{II,JJ}.Total)+mean(Exposure_RA{II,JJ+1}.Total))/(DeltaInput(II,JJ)*mean(Exposure_RA{II,JJ}.Total));
     end
end
%%
NSC_Inge.ACH1=NSC_1ACH_Inge;
NSC_Inge.ACH29=NSC_29ACH_Inge;
NSC_Inge.RA=NSC_RA_Inge;
NSC_Inha.ACH1=NSC_1ACH_Inha;
NSC_Inha.ACH29=NSC_29ACH_Inha;
NSC_Inha.RA=NSC_RA_Inha;
NSC_Derm.ACH1=NSC_1ACH_Derm;
NSC_Derm.ACH29=NSC_29ACH_Derm;
NSC_Derm.RA=NSC_RA_Derm;
NSC_Total.ACH1=NSC_1ACH_Total;
NSC_Total.ACH29=NSC_29ACH_Total;
NSC_Total.RA=NSC_RA_Total;
%%
%save the data
save(OutputFile,'NSC_Inge','NSC_Inha','NSC_Derm','NSC_Total'); 
