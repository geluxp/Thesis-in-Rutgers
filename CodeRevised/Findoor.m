% [nfemale,~,~]=xlsread('D:\Thesis\CodeRevised\Activity_Ventilation','female');
% [nmale,~,~]=xlsread('D:\Thesis\CodeRevised\Activity_Ventilation','male');
% [n1,~,~]=xlsread('D:\Thesis\CodeRevised\activity_pattern');


function [Fint ,Fout]=Findoor(sf)
load('inhaltionoutdoor.mat','nfemale','nmale','n1');
nint=n1(1:5,1); nout=n1(8:12,1);ntotal=nint+nout;
%sf=ones(18,1)*100;
%% extracting data of inhaltion rate of different activities.
%a:resting b:light c:moderate d:heavy
a_m=nmale(1:14,3);
b_m=nmale(17:30,3);
c_m=nmale(33:46,3);
d_m=nmale(49:62,3);


a_m_t=nmale(1:14,2);
b_m_t=nmale(17:30,2);
c_m_t=nmale(33:46,2);
d_m_t=nmale(49:62,2);
total_m_t=a_m_t+b_m_t+c_m_t+d_m_t;

a_f=nfemale(1:14,3);
b_f=nfemale(17:30,3);
c_f=nfemale(33:46,3);
d_f=nfemale(49:62,3);

a_f_t=nfemale(1:14,2);
b_f_t=nfemale(17:30,2);
c_f_t=nfemale(33:46,2);
d_f_t=nfemale(49:62,2);
total_f_t=a_f_t+b_f_t+c_f_t+d_f_t;


%% male
Inhal_int_m=(a_m.*a_m_t*nint(1)*sf(8)/ntotal(1)+b_m.*b_m_t*nint(2)*sf(8)/ntotal(2)+c_m.*c_m_t*nint(3)/ntotal(3)+d_m.*d_m_t*nint(4)/ntotal(4))./...
(a_m_t*nint(1)*sf(8)/ntotal(1)+b_m_t*nint(2)*sf(8)/ntotal(2)+c_m_t*nint(3)/ntotal(3)+d_m_t*nint(4)/ntotal(4));

Inhal_out_m=(a_m.*a_m_t*nout(1)*sf(8)/ntotal(1)+b_m.*b_m_t*nout(2)*sf(8)/ntotal(2)+c_m.*c_m_t*nout(3)/ntotal(3)+d_m.*d_m_t*nout(4)/ntotal(4))./...
(a_m_t*nout(1)*sf(8)/ntotal(1)+b_m_t*nout(2)*sf(8)/ntotal(2)+c_m_t*nout(3)/ntotal(3)+d_m_t*nout(4)/ntotal(4));

Inhal_total_m=(a_m.*a_m_t+b_m.*b_m_t+c_m.*c_m_t+d_m.*d_m_t)./...
(a_m_t+b_m_t+c_m_t+d_m_t);

Fint_m=Inhal_int_m./Inhal_total_m;
Fout_m=Inhal_out_m./Inhal_total_m;
%% female
Inhal_int_f=(a_f.*a_f_t*nint(1)*sf(8)/ntotal(1)+b_f.*b_f_t*nint(2)*sf(8)/ntotal(2)+c_f.*c_f_t*nint(3)/ntotal(3)+d_f.*d_f_t*nint(4)/ntotal(4))./...
(a_f_t*nint(1)*sf(8)/ntotal(1)+b_f_t*nint(2)*sf(8)/ntotal(2)+c_f_t*nint(3)/ntotal(3)+d_f_t*nint(4)/ntotal(4));

Inhal_out_f=(a_f.*a_f_t*nout(1)*sf(8)/ntotal(1)+b_f.*b_f_t*nout(2)*sf(8)/ntotal(2)+c_f.*c_f_t*nout(3)/ntotal(3)+d_f.*d_f_t*nout(4)/ntotal(4))./...
(a_f_t*nout(1)*sf(8)/ntotal(1)+b_f_t*nout(2)*sf(8)/ntotal(2)+c_f_t*nout(3)/ntotal(3)+d_f_t*nout(4)/ntotal(4));

Inhal_total_f=(a_f.*a_f_t+b_f.*b_f_t+c_f.*c_f_t+d_f.*d_f_t)./...
(a_f_t+b_f_t+c_f_t+d_f_t);

Fint_f=Inhal_int_f./Inhal_total_f;
Fout_f=Inhal_out_f./Inhal_total_f;

Fint=[Fint_m ;Fint_f];
Fout=[Fout_m ;Fout_f];

end

% save('C:\Documents and Settings\kunmei\My Documents\Thesis\CodeRevised\FactorIndoor.mat','Findoor_m','Foutdoor_m','Findoor_f','Foutdoor_f');










    

