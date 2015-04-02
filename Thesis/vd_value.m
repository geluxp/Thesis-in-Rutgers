function [vd] =vd_value(vdfactor)
%calculate the vd value
ustar=117/100*vdfactor(1);
% unit:m
k=0.41*vdfactor(2);
%von karman constant
Dp=20/1000000*vdfactor(3);
% diameter unit:m
Pp=840*vdfactor(4);
%density of pollen unit: kg/m3
g=9.8;
%gravitational acceleration unit:m/s2
mu=1.81*0.00001*vdfactor(5);
%viscosity of air unit:m/s
namda=68*10^(-8)*vdfactor(6);
% mean free path of air molecules
pa=1.145*vdfactor(7);
%density of air ,kg/m3
kb=1.38*10^(-23);
%boltzman constant ,JK
T=298*vdfactor(8);
%mean temperature
Cc=1+2*namda*(1.257+0.4*exp(1)^(-0.55*Dp/namda));
% slip correction factor
D=kb*T*Cc/(3*3.14*mu*Dp);
%diffusivity of the particle
sc=mu/(pa*D);
%schimit number
vs=Pp*Dp^2*g*Cc/(18*mu);

st=vs*ustar^2*pa/(g*mu);
%stokes number
ra=1/(k*ustar)*log(2/0.01);
%calculation of ra
rb=1/(ustar*(sc^(-2/3)+10^(-3/st)));
%calculation of rb
%vd=1/(ra+rb+ra*rb*vs)+vs
vd=(1/(ra+rb+ra*rb*vs))+vs;


end