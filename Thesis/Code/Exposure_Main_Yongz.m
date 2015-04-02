%Calculate the flight attendant's exposure to pesticide during the flight
%Note1: Addpath analysis & external
function [Exposure, ConcsAveAll, tAll]=Exposure_Main(cabinType,configName,ExpsName,CabinNumber,Sex,Duration,ExposureFactor)
% addpath analysis; addpath external; addpath external\export_fig
% addpath analysis; addpath external; addpath external/export_fig
% clear;clc;
% %cabinTypes = {'residual-application', '1ACH-spray', '29ACH-spray'};
% cabinType = '1ACH-spray';
% configName='TEbase';
% CabinNumber='1';
% Sex='Female';
% Duration='Hourly';
% ExposureFactor=[1 1 1 1 1 1 1 1 1 1 1 1];%used for sensitivity analysis
% ExpsName='ExpsBase';
% InputFile = strcat('\\n30\store6\yongz\FAA_Exposure\FAA_SSI\simData\',configName,'-',cabinType,'\vcabin-',CabinNumber,'.mat');
FB = @GenUtils.foldBoth;
InputFile = strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/simData/',configName,'-',cabinType,'/vcabin-',CabinNumber,'.mat');
% ExposureFolder=strcat('\\n30\store6\yongz\FAA_Exposure\FAA_SSI\ExposureResults\',ExpsName,'_',cabinType,'\');
ExposureFolder=strcat('/indirect/store6/yongz/FAA_Exposure/FAA_SSI/ExposureResults/',ExpsName,'_',cabinType,'/');
if ~exist(ExposureFolder,'dir'), mkdir(ExposureFolder); end
ExpsOptName=strcat(ExposureFolder,'Exposure_Cabin','_',CabinNumber,'_',Sex,'_',Duration);
CabinI = AirCraftCabin.loadCabin(InputFile);
%if ~exist('iLegs','var'), iLegs = 1:length(C.CabinPar.flightStartTimes); end
%if ~exist('reqFields','var'), reqFields = fields(C.xref); end % all Fields
  iLegs = 1:length(CabinI.CabinPar.flightStartTimes);
  reqFields = fields(CabinI.xref);
  ef=CabinI.config.ef;
%%
  %t_all = []; c_all = [];
  %get transient concentrations for all fields for each leg
  for i=1:length(iLegs)
    [t{i}, c{i}] = CabinI.getLegConcsAll(i,100);
    %t_all = [t_all, t{i}+ (iLegs(i)-1)*CabinI.CabinPar.totTime];
    %c_all = [c_all, c{i}];
  end
  %get aveaged concentrations for each field (average multiple value with same field name) for each leg, 
 for Legi=1:length(iLegs) 
   for j=1:length(reqFields)
     idx = CabinI.xref.(reqFields{j});
     if length(idx) == 1 % single number at each time
        if strcmp(reqFields{j},'vol'), c_ave{Legi}(j,:) = c{Legi}(idx,:); %Air concentration: mug/m3
        else c_ave{Legi}(j,:) = c{Legi}(idx,:)/1E4;%Surface loading: ug/cm2
        end
     else c_ave{Legi}(j,:) = mean(c{Legi}(idx,:))/1E4; %mean surface loading: ug/cm2
     end
   end
 end 
 %%
 %get surface loadings on hand surface from the surface loadings on human
 xref_ave={'aisle','ceiling','floorCenter','floorSide','human','lap','seat','seatBack','seatTop','sides','vol','wall','hand'};
 c_ave_human=[];
 Idx_human=strmatch('human',xref_ave);%find the 
 for Legi=1:length(iLegs)
    f_scale = FB(ExposureFactor(1)*ef.f(1),1.5,3.0);
    c_ave_human=f_scale*c_ave{Legi}(Idx_human,:); 
    %append surface loading on human into the last line of c_ave
    c_ave{Legi}(end+1,:)=c_ave_human;
 end
 
 %%
%calculate instaneous exposure intensity (ug/(h.kgBodyWeight)) for a virtual flight attendant
%
%exposure parameters
%BodyWeight: Assume body weight of a flight attandent accross the all the legs on same
%filgt will not change
if strcmp(Sex,'Female')
    BW=FB(ExposureFactor(2)*ef.BW_F(1),38.9,93.0);%Female body weight, kg
    S_H=ExposureFactor(3)*ef.S_H_F;
else
    BW=FB(ExposureFactor(2)*ef.BW_M(1),51.1,106.2);%Male body weight
    S_H=ExposureFactor(3)*ef.S_H_M;
end
% %Hand surface area
%  S_H_F=ExposureFactor(3)*ef.S_H_F;
%  S_H_M=ExposureFactor(3)*ef.S_H_M;
% %The portion of hand area contacted with mouthP_H
 P_H=ExposureFactor(4)*ef.P_H;
% %Hand-to-Mouth sigle contact transfer efficiency TE_HM
% TE_HM=ef.TE_HM(1);
% %Hand-to-Mouth contact frequency TN_HM
% TN_HM=ef.TN_HM(1);
% %Exposed (flight attendant) human surface area, S_Hum
% S_Hum=ef.S_Hum(1);% S_Hum=BW*F_BS*P_EX
% %Adsorb effeciency from dermal to skin (dermal adsorbtion) TE_DS
% TE_DS=ef.TE_DS(1);
% %The probability of a flight attendant being on duty on any given leg:
% %P_Duty
% %P_Duty=ef.P_Duty(1);
% %oral adsorption rate, P_OAR Wei's Thesis
% P_OAR=ef.P_OAR(1);
%
%Exposure intensity (Integrand in the exosure formulations)
%
for Legi=1:length(iLegs)
%find exposure time    
[T_Idx_prflt, T_Idx_drflt, T_Idx_Spry, T_Idx_psflt, T_Idx_rest]=exposure_time(CabinI,Legi);
%On duty probability; %For international flight: Here we treat each leg
%(flight time + rest time) approximate 1 day
P_Duty=FB(ExposureFactor(5)*ef.P_Duty(1),0.5,0.65);
%other exposure factors
%During the rest period, the flight attendants will not expose to pesticide
T_Idx={T_Idx_prflt, T_Idx_drflt, T_Idx_Spry, T_Idx_psflt};
for TI=1:length(T_Idx)
    TE_HM{TI} = FB(ExposureFactor(6)*ef.TE_HM(1,length(T_Idx{TI})),0.4,0.6);
    TN_HM{TI} = FB(ExposureFactor(7)*ef.TN_HM(1,length(T_Idx{TI})),1,3);
    P_OAR{TI} = FB(ExposureFactor(8)*ef.P_OAR(1,length(T_Idx{TI})),0.4,0.85);
    if strcmp(Sex,'Female')
     In{TI} = FB(ExposureFactor(9)*ef.In_F(1,length(T_Idx{TI})),1.06,1.6);
    else
     In{TI} = FB(ExposureFactor(9)*ef.In_M(1,length(T_Idx{TI})),1.16,1.74);    
    end      
    F_BS{TI} = FB(ExposureFactor(10)*ef.F_BS(1,length(T_Idx{TI})),0.03,0.08);
    TE_DS{TI} = FB(ExposureFactor(11)*ef.TE_DS(1,length(T_Idx{TI})),0.05,0.15);
    P_EX{TI} = FB(ExposureFactor(12)*ef.P_EX(1,length(T_Idx{TI})),0.185,0.395);    
end
%Identity variable It to indicate whether a flight attendant is on duty 
%on a given leg, 1-on duty, 0-off duty 
It=randsample([0 1],1,true,[1-P_Duty,P_Duty]);
  if It
     %Ingestion
     for IdxI=1:length(T_Idx); 
     %Ingestion    
     E_Inge{Legi}(1,T_Idx{IdxI})=c_ave{Legi}(strmatch('hand',xref_ave),T_Idx{IdxI})*S_H*P_H.*...
         (1-(1-TE_HM{IdxI}).^(TN_HM{IdxI})).*(P_OAR{IdxI})/BW;
     %Inhalation
     E_Inha{Legi}(1,T_Idx{IdxI})=c_ave{Legi}(strmatch('vol',xref_ave),T_Idx{IdxI}).*(In{IdxI})/BW;
     %Dermal
     E_Derm{Legi}(1,T_Idx{IdxI})=c_ave{Legi}(strmatch('human',xref_ave),T_Idx{IdxI}).*(F_BS{IdxI})*1E4.*...
         (P_EX{IdxI}).*(TE_DS{IdxI});%1E4 convert m2 to cm2; surface loading on human (ug/cm2)
     end
     E_Inge{Legi}(1,T_Idx_rest)=zeros(1,length(T_Idx_rest));
     E_Inha{Legi}(1,T_Idx_rest)=zeros(1,length(T_Idx_rest));
     E_Derm{Legi}(1,T_Idx_rest)=zeros(1,length(T_Idx_rest));
  else
     E_Inge{Legi}=zeros(1,length(t{Legi}));
     E_Inha{Legi}=zeros(1,length(t{Legi})); 
     E_Derm{Legi}=zeros(1,length(t{Legi})); 
  end
     % Total
     E_T{Legi}=E_Inge{Legi}+E_Inha{Legi}+ E_Derm{Legi};
end
%%
%Get time series of averaged concentrations, exposures for all the legs
  t_all = []; c_ave_all = []; E_Inge_all=[]; E_Inha_all=[]; E_Derm_all=[]; E_T_all=[];
  %get transient concentrations for all fields for each leg
  for i=1:length(iLegs)
    t_all = [t_all, t{i}+ (iLegs(i)-1)*CabinI.CabinPar.totTime];
    c_ave_all = [c_ave_all, c_ave{i}];
    E_Inge_all = [E_Inge_all, E_Inge{i}];
    E_Inha_all = [E_Inha_all, E_Inha{i}];
    E_Derm_all = [E_Derm_all, E_Derm{i}];
    E_T_all = [E_T_all, E_T{i}];
  end
  ConcsAveAll=c_ave_all;
  %Concs.Ave=c_ave;
  tAll=t_all;
  %Times.tSep=t;
  %%
  %get exposures (integration) using exposure intensity
  switch Duration
      case {'Hourly'}
          [Time_Inge Exps_Inge]=Exps_Integ(t_all,E_Inge_all,Duration,CabinI);
          [Time_Inha Exps_Inha]=Exps_Integ(t_all,E_Inha_all,Duration,CabinI);
          [Time_Derm Exps_Derm]=Exps_Integ(t_all,E_Derm_all,Duration,CabinI);
          [Time_T Exps_T]=Exps_Integ(t_all,E_T_all,Duration,CabinI);
      case {'Daily'}
          [Time_Inge Exps_Inge]=Exps_Integ(t,E_Inge,Duration,CabinI);
          [Time_Inha Exps_Inha]=Exps_Integ(t,E_Inha,Duration,CabinI);
          [Time_Derm Exps_Derm]=Exps_Integ(t,E_Derm,Duration,CabinI);
          [Time_T Exps_T]=Exps_Integ(t,E_T,Duration,CabinI);
      otherwise 
          disp('Error: Duraton can either be Daily or Hourly');
  end
  Exposure.Inge=Exps_Inge;
  Exposure.Inha=Exps_Inha;
  Exposure.Derm=Exps_Derm;
  Exposure.Total=Exps_T;
    %%
  %visualization of the exposure intensity
%   plotExposure(Time_Inge,Exps_Inge,'Ingestion',Duration,CabinNumber,Sex,ExposureFolder,CabinI);
%   plotExposure(Time_Inha,Exps_Inha,'Inhalation',Duration,CabinNumber,Sex,ExposureFolder,CabinI);
%   plotExposure(Time_Derm,Exps_Derm,'Dermal',Duration,CabinNumber,Sex,ExposureFolder,CabinI);
%   plotExposure(Time_T,Exps_T,'Multiple Pathways',Duration,CabinNumber,Sex,ExposureFolder,CabinI);  
%%save the data
save(ExpsOptName,'Exposure', 'ConcsAveAll', 'tAll'); 
%for sensitivity analyses MorrisOAT, only to save Exposure
%save(ExpsOptName,'Exposure'); 
end


