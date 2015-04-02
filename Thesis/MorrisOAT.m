%Script used to do sensitivity analyses based on Morris's OAT design, Morris (1991)
% input parameters changes between 0.5 and 1.5 of their base values -Yong, 2013/06/05
%(1)each run of faa_main generates 2 cabins with 20 trips (2)each run of
%exposure saves inge, inha, derm and total exposures for three
%different scenario 
%WARNING: before run this change (1)faa_main, Outputfolder, ncbin=2, numDaysAircraft=20,comment out the plot function;
%(2)Exposure_Main, OutputFolder
function MorrisOAT(NumTraj,RunFromBreak)
%%
%Parameters
% clear;clc
% %number of trajectories
% NumTraj=10;
% RunFromBreak=false;
% NSC_Name='NSC_MorrisOAT';
% time_display;
%upper and lower percentage bounds of variations in input parameters
UpBound=1.5; LowBound=0.5;
%each input parameter has 10 levels
p=10;
%input parameter number
k=21;
%OutputFile
%OutputFile=strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/NSC_MorrisOAT/',NSC_Name,'.mat');
%%
%generate orientation matrix BStar
%the normalized unit changes of input parameter
delta=p/(2*(p-1));
%base set of normlized input parameters
baseSet=0:1/(p-1):(1-delta);
if ~RunFromBreak
%generate different normalized base values 
baseValue=nan(NumTraj,k);
for i=1:NumTraj
   baseValue(i,:) = randsample(baseSet,k,true); 
end
%%%steps to generate oritentation matrix BStar
MatrixB=tril(ones(k+1,k),-1);
MatrixJ=ones(k+1,k);
MatrixJ1=ones(k+1,1);
%PStar=eye(k);
%DStar=diag([-1*ones(1,floor(k/2)) ones(1,ceil(k/2))],0);
%Orientation Matrix, Formula (4.5), Saltelli (2001), P71
BStar=cell(1,NumTraj);
for j=1:NumTraj;
%
xStar=baseValue(j,:);
%
PStar=eye(k);
idx=randperm(k);
PStar=PStar(idx,:);
%
DStar=diag(randsample([-1 1],k,true),0);
%
BStar{j} = (MatrixJ1*xStar+(delta/2)*((2*MatrixB-MatrixJ)*DStar+MatrixJ))*PStar;
end
save(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/NSC_MorrisOAT/BStar.mat'),'BStar'); 
else
load(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/NSC_MorrisOAT/BStar.mat')); 
end
%%
%calculate the concentrations, surface loadings and expoures
% Exposure_1ACH=cell(NumTraj,k+1);
% Exposure_29ACH=cell(NumTraj,k+1);
% Exposure_RA=cell(NumTraj,k+1);
parfor I=251:500
    %BStarI=BStar{I};
    for J=1:k+1
          %convert the normalized parameter values to original values, the first nine parameters
          %were used for generating concentrations and surface loadings
          teFactors=BStar{I}(J,1:9)*(UpBound-LowBound)+LowBound;        
          %the last 12 parameters were used for exposures
          ExposureFactor=BStar{I}(J,10:21)*(UpBound-LowBound)+LowBound;
          configName=strcat('NSCconc_Traj',num2str(I),'_Step',num2str(J));
          ExpsName=strcat('NSCexps_Traj',num2str(I),'_Step',num2str(J));
          %Concentrations and surface loadings
           if ((~exist(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/simData2/',configName,'-1ACH-spray'),'dir'))...
               ||(~exist(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/simData2/',configName,'-29ACH-spray'),'dir'))...
               ||(~exist(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/simData2/',configName,'-residual-application'),'dir')))
             faa_main('generate', configName, teFactors);
           end
          %Exposures
          %the last 12 parameters were used for exposures
            if ~exist(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults2/',ExpsName,'_1ACH-spray'),'dir')
              Exposure_Main('1ACH-spray',configName,ExpsName,'1','Female','Daily',ExposureFactor);
            end
          %
            if ~exist(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults2/',ExpsName,'_29ACH-spray'),'dir')
              Exposure_Main('29ACH-spray',configName,ExpsName,'1','Female','Daily',ExposureFactor);
            end
          %
            if ~exist(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults2/',ExpsName,'_residual-application'),'dir')
              Exposure_Main('residual-application',configName,ExpsName,'1','Female','Daily',ExposureFactor);
            end
    end
end
%%
%Normalized Sensitivity Coefficients
% NSC_1ACH_Inge=nan(NumTraj,k);
% NSC_1ACH_Inha=nan(NumTraj,k);
% NSC_1ACH_Derm=nan(NumTraj,k);
% NSC_1ACH_Total=nan(NumTraj,k);
% NSC_29ACH_Inge=nan(NumTraj,k);
% NSC_29ACH_Inha=nan(NumTraj,k);
% NSC_29ACH_Derm=nan(NumTraj,k);
% NSC_29ACH_Total=nan(NumTraj,k);
% NSC_RA_Inge=nan(NumTraj,k);
% NSC_RA_Inha=nan(NumTraj,k);
% NSC_RA_Derm=nan(NumTraj,k);
% NSC_RA_Total=nan(NumTraj,k);
% for II=1:NumTraj
%     for JJ=1:k
%         if JJ<=k/2
%         %Normalized Sensitivity Coefficients
%           %Caveat: the first 10 rows are stepwisely decreased by delta at
%           %each step, so the NSC=(y1-y2)/delta. This structure depends on
%           %the way in which BStar was constructed  
%           %Preflight,1ACH
%           NSC_1ACH_Inge(II,JJ)=(mean(Exposure_1ACH{II,JJ}.Inge)-mean(Exposure_1ACH{II,JJ+1}.Inge))/(delta*(UpBound-LowBound));
%           NSC_1ACH_Inha(II,JJ)=(mean(Exposure_1ACH{II,JJ}.Inha)-mean(Exposure_1ACH{II,JJ+1}.Inha))/(delta*(UpBound-LowBound));
%           NSC_1ACH_Derm(II,JJ)=(mean(Exposure_1ACH{II,JJ}.Derm)-mean(Exposure_1ACH{II,JJ+1}.Derm))/(delta*(UpBound-LowBound));
%           NSC_1ACH_Total(II,JJ)=(mean(Exposure_1ACH{II,JJ}.Total)-mean(Exposure_1ACH{II,JJ+1}.Total))/(delta*(UpBound-LowBound));
%           %Top-of-Descent
%           NSC_29ACH_Inge(II,JJ)=(mean(Exposure_29ACH{II,JJ}.Inge)-mean(Exposure_29ACH{II,JJ+1}.Inge))/(delta*(UpBound-LowBound));
%           NSC_29ACH_Inha(II,JJ)=(mean(Exposure_29ACH{II,JJ}.Inha)-mean(Exposure_29ACH{II,JJ+1}.Inha))/(delta*(UpBound-LowBound));
%           NSC_29ACH_Derm(II,JJ)=(mean(Exposure_29ACH{II,JJ}.Derm)-mean(Exposure_29ACH{II,JJ+1}.Derm))/(delta*(UpBound-LowBound));
%           NSC_29ACH_Total(II,JJ)=(mean(Exposure_29ACH{II,JJ}.Total)-mean(Exposure_29ACH{II,JJ+1}.Total))/(delta*(UpBound-LowBound));
%           %Residual application
%           NSC_RA_Inge(II,JJ)=(mean(Exposure_RA{II,JJ}.Inge)-mean(Exposure_RA{II,JJ+1}.Inge))/(delta*(UpBound-LowBound));
%           NSC_RA_Inha(II,JJ)=(mean(Exposure_RA{II,JJ}.Inha)-mean(Exposure_RA{II,JJ+1}.Inha))/(delta*(UpBound-LowBound));
%           NSC_RA_Derm(II,JJ)=(mean(Exposure_RA{II,JJ}.Derm)-mean(Exposure_RA{II,JJ+1}.Derm))/(delta*(UpBound-LowBound));
%           NSC_RA_Total(II,JJ)=(mean(Exposure_RA{II,JJ}.Total)-mean(Exposure_RA{II,JJ+1}.Total))/(delta*(UpBound-LowBound));
%         else
%           %Normalized Sensitivity Coefficients
%           %Preflight,1ACH
%           NSC_1ACH_Inge(II,JJ)=(-mean(Exposure_1ACH{II,JJ}.Inge)+mean(Exposure_1ACH{II,JJ+1}.Inge))/(delta*(UpBound-LowBound));
%           NSC_1ACH_Inha(II,JJ)=(-mean(Exposure_1ACH{II,JJ}.Inha)+mean(Exposure_1ACH{II,JJ+1}.Inha))/(delta*(UpBound-LowBound));
%           NSC_1ACH_Derm(II,JJ)=(-mean(Exposure_1ACH{II,JJ}.Derm)+mean(Exposure_1ACH{II,JJ+1}.Derm))/(delta*(UpBound-LowBound));
%           NSC_1ACH_Total(II,JJ)=(-mean(Exposure_1ACH{II,JJ}.Total)+mean(Exposure_1ACH{II,JJ+1}.Total))/(delta*(UpBound-LowBound));
%           %Top-of-Descent
%           NSC_29ACH_Inge(II,JJ)=(-mean(Exposure_29ACH{II,JJ}.Inge)+mean(Exposure_29ACH{II,JJ+1}.Inge))/(delta*(UpBound-LowBound));
%           NSC_29ACH_Inha(II,JJ)=(-mean(Exposure_29ACH{II,JJ}.Inha)+mean(Exposure_29ACH{II,JJ+1}.Inha))/(delta*(UpBound-LowBound));
%           NSC_29ACH_Derm(II,JJ)=(-mean(Exposure_29ACH{II,JJ}.Derm)+mean(Exposure_29ACH{II,JJ+1}.Derm))/(delta*(UpBound-LowBound));
%           NSC_29ACH_Total(II,JJ)=(-mean(Exposure_29ACH{II,JJ}.Total)+mean(Exposure_29ACH{II,JJ+1}.Total))/(delta*(UpBound-LowBound));
%           %Residual application
%           NSC_RA_Inge(II,JJ)=(-mean(Exposure_RA{II,JJ}.Inge)-mean(Exposure_RA{II,JJ+1}.Inge))/(delta*(UpBound-LowBound));
%           NSC_RA_Inha(II,JJ)=(-mean(Exposure_RA{II,JJ}.Inha)-mean(Exposure_RA{II,JJ+1}.Inha))/(delta*(UpBound-LowBound));
%           NSC_RA_Derm(II,JJ)=(-mean(Exposure_RA{II,JJ}.Derm)-mean(Exposure_RA{II,JJ+1}.Derm))/(delta*(UpBound-LowBound));
%           NSC_RA_Total(II,JJ)=(-mean(Exposure_RA{II,JJ}.Total)-mean(Exposure_RA{II,JJ+1}.Total))/(delta*(UpBound-LowBound));
%         end
%      end
% end
% %
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
% %%
% %save the data
% save(OutputFile,'NSC_Inge','NSC_Inha','NSC_Derm','NSC_Total'); 
time_display;


