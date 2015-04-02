
%each input parameter has 10 levels
p=10;
% Exposure_RA=cell(NumTraj,k+1);=10;
RunFromBreak=0
NumTraj=2;
UpBound=1.5; LowBound=0.5;
%each input parameter has 10 levels
%input parameter number
k=17;
%%
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
save('D:\Thesis\Code\BStar.mat','BStar'); 
else
load('D:\Thesis\Code\BStar.mat'); 
end
%%
%calculate the concentrations, surface loadings and expoures
% Exposure_1ACH=cell(NumTraj,k+1);
% Exposure_29ACH=cell(NumTraj,k+
for I=1:NumTraj
    %BStarI=BStar{I};
    for J=1:2
          %convert the normalized parameter values to original values, the first nine parameters
          %were used for generating concentrations and surface loadings
          %teFactors=BStar{I}(J,1:7)*(UpBound-LowBound)+LowBound;        
          %the last 12 parameters were used for exposures
          ExposureFactor=BStar{I}(J,1:16)*(UpBound-LowBound)+LowBound;
          configName=strcat('NSCconc_Traj',num2str(I),'_Step',num2str(J));
          ExpsName=strcat('NSCexps_Traj',num2str(I),'_Step',num2str(J));
          %Concentrations and surface loadings
%            if ((~exist(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/simData2/',configName,'-1ACH-spray'),'dir'))  
%              faa_main('generate', configName, teFactors);
%            end
          %Exposures
          %the last 12 parameters were used for exposures
           % if ~exist(strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults2/',ExpsName,'_1ACH-spray'),'dir')
              Exposure_Main(ExpsName,ExposureFactor);
            end
          
    end

