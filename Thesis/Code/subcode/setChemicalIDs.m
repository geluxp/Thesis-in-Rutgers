function [ID, ChemList, MW] = setChemicalIDs

%% chemical IDs
ID.Trichlorobenzene = 1;
ID.Trichlorophenoxyaceticacid = 2;
ID.TwoFourD = 3;
ID.Fluorotelomeracid = 4;
ID.Aldicarb = 5;
ID.Aroclor_1254 = 6;
ID.Aroclor_1260 = 7;
ID.Arsenic = 8;
ID.Atrazine = 9;
ID.Benzenemethoxypropenyl = 10;
ID.BisphenolA = 11;
ID.Butylhydroxyanisole = 12;
ID.Chloroalkanes = 13;
ID.Cadmium = 14;
ID.Carbaryl = 15;
ID.DDT = 16;
ID.decaBDE = 17;
ID.DEHP = 18;
ID.DEP = 19;
ID.DBP = 20;
ID.EthaneTetrachloro = 21;
ID.Perc = 22;
ID.EthyleneThiourea = 23;
ID.Ethylparaben = 24;
ID.Formaldehyde = 25;
ID.gammaHexachlorocyclohexane = 26;
ID.Hexabromocyclododecane = 27;
ID.Hexachlorobenzene = 28;
ID.Lead = 29;
ID.Malathion = 30;
ID.Manganese = 31;
ID.Methoxychlor = 32;
ID.MethylMercury = 33;
ID.Methylparaben = 34;
ID.nHexane = 35;
ID.Nonylphenol = 36;
ID.octaBDE = 37;
ID.Parathion = 38;
ID.Pentachlorophenol = 39;
ID.pentaBDE = 40;
ID.AmmoniumPerchlorate = 41;
ID.MagnesiumPerchlorate = 42;
ID.PotassiumPerchlorate = 43;
ID.SodiumPerchlorate = 44;
ID.Permethrin = 45;
ID.PFOS = 46;
ID.Phenoldimethylethylmethoxy = 47;
ID.ptertPentylphenol = 48;
ID.Styrene = 49;
ID.TetrabromobisphenolA = 50;
ID.Trifluralin = 51;
ID.Trisdichloropropylphosphate = 52;
ID.Trischloroethylphosphate = 53;
ID.Vinclozolin = 54;
ID.VinylChloride = 55;

ChemList = {'Trichlorobenzene','Trichlorophenoxyaceticacid','TwoFourD',...
'Fluorotelomeracid','Aldicarb','Aroclor_1254','Aroclor_1260','Arsenic',...
'Atrazine','Benzenemethoxypropenyl','BisphenolA','Butylhydroxyanisole',...
'Chloroalkanes','Cadmium','Carbaryl','DDT','decaBDE','DEHP','DEP','DBP',...
'EthaneTetrachloro','Perc','EthyleneThiourea','Ethylparaben','Formaldehyde',...
'gammaHexachlorocyclohexane','Hexabromocyclododecane','Hexachlorobenzene','Lead','Malathion',...
'Manganese','Methoxychlor','MethylMercury','Methylparaben','nHexane','Nonylphenol',...
'octaBDE','Parathion','Pentachlorophenol','pentaBDE','AmmoniumPerchlorate',...
'MagnesiumPerchlorate','PotassiumPerchlorate','SodiumPerchlorate','Permethrin','PFOS',...
'Phenoldimethylethylmethoxy','ptertPentylphenol','Styrene','TetrabromobisphenolA','Trifluralin',...
'Trisdichloropropylphosphate','Trischloroethylphosphate','Vinclozolin','VinylChloride'};

MW = [181.45, 255.5, 221.0, 478.10, 190.27, 326, 375.7, 74.9, 215.7, 148.2, 228.29, 180.24, 400, 112.41, ... 
    201.2, 354.49, 959.17, 390.5, 222.3, 278.34, 167.9, 165.8, 102.2, 166.17, 30, 290.8, 641.7, 284.78, ... 
    207.2, 330.4, 54.9, 345.7, 215.63, 152.15, 86.2, 220.35, 801.31, 291.3, 266.4, 564.69, 117.49, 223.206,...
    138.55, 122.44, 391.3, 500.13, 180.24, 164.24, 104.15, 543.88, 335.28, 430.90, 285.5, 286.11, 62.5];

%% environmental media
ID.OutdoorAir = 1;
ID.IndoorAir = 2;
ID.DermalrateOut = 3;
ID.DermalrateIn = 4;
ID.IngestOut=5;
ID.IngestIn=6;
ID.OutdoorAir_alt = 8;
ID.IndoorAir_alt = 9;
ID.Dermalrate=7;


ID.num_grps = 10;
ID.num_per_grp = 11;
ID.nMonte = 12;