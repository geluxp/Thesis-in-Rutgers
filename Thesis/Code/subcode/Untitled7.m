[Inhal, ~, ~] = xlsread('EFHcalculation_MK','Inhalation');
[surface, ~, ~] = xlsread('EFHcalculation_MK','Dermal');
[frequency, ~, ~] = xlsread('EFHcalculation_Mk','nondietary');

save('C:\Documents and Settings\kunmei\My Documents\Thesis\Code\subcode\EFHdata.mat','Inhal','surface','frequency');