%Conc Pics Drawing Ambrosia

subplot(3,3,1) 
hold on
axis([0,1000,-1,1200])
plot(RegionAmbrosia.Central,'y');
legend('Central','Location','NorthEast');
hold off


subplot(3,3,2)
hold on
axis([0,1000,-1,1200])

set(plot(RegionAmbrosia.EastNorthCentral),'Color',[0.5,0.5,0.5]);
legend('EastNorthCentral')
hold off

subplot(3,3,3)
hold on
axis([0,1000,-1,1200])
plot(RegionAmbrosia.Northeast,'b');
legend('Northeast');
hold off

subplot(3,3,4)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.Northwest,'-b');
 legend('Northwest');
 hold off
 
 subplot(3,3,5)
hold on
axis([0,1000,-1,1000])
 plot(RegionAmbrosia.South,'m');legend('South');
 hold off
 
subplot(3,3,6)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.Southeast,'c');legend('Southeast');
 hold off
 
subplot(3,3,7)
hold on
axis([0,1000,-1,1200])
 plot(interp1(1:359,RegionAmbrosia.Southwest,1:0.3:359),'r');legend('Southwest');
 hold off

 
subplot(3,3,8)
hold on
axis([0,1000,-1,1200])
plot(interp1(1:628,RegionAmbrosia.West,1:0.5:628),'g');legend('West');
hold off

subplot(3,3,9)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.WestNorthCentral,'-k');legend('WestNorthCentral');
 hold off
 

 %%RegionArtemisia
 %Conc Pics Drawing Ambrosia

subplot(3,3,1) 
hold on
axis([0,1000,-1,100])
 if length(RegionArtemisia.Central)<1000
    plot(interp1(1:length(RegionArtemisia.Central),RegionArtemisia.Central,1:RegionArtemisia.Central/1000:RegionArtemisia.Central),'r');
 else
plot(RegionArtemisia.Central,'y');
 end
legend('Central','Location','NorthEast');
hold off


subplot(3,3,2)
hold on
axis([0,1000,-1,1200])

set(plot(RegionArtemisia.EastNorthCentral),'Color',[0.5,0.5,0.5]);
legend('EastNorthCentral')
hold off

subplot(3,3,3)
hold on
axis([0,1000,-1,1200])
plot(RegionArtemisia.Northeast,'b');
legend('Northeast');
hold off

subplot(3,3,4)
hold on
axis([0,1000,-1,1200])
 plot(RegionArtemisia.Northwest,'-b');
 legend('Northwest');
 hold off
 
 subplot(3,3,5)
hold on
axis([0,1000,-1,1000])
 plot(RegionArtemisia.South,'m');legend('South');
 hold off
 
subplot(3,3,6)
hold on
axis([0,1000,-1,1200])
 plot(RegionArtemisia.Southeast,'c');legend('Southeast');
 hold off
 
subplot(3,3,7)
hold on
axis([0,1000,-1,1200])
 plot(interp1(1:359,RegionArtemisia.Southwest,1:0.3:359),'r');legend('Southwest');
 hold off

 
subplot(3,3,8)
hold on
axis([0,1000,-1,1200])
plot(interp1(1:628,RegionArtemisia.West,1:0.5:628),'g');legend('West');
hold off

subplot(3,3,9)
hold on
axis([0,1000,-1,1200])
 plot(RegionArtemisia.WestNorthCentral,'-k');legend('WestNorthCentral');
 hold off
 
%% Conc Pics Drawing RegionArtemisia

subplot(3,3,1) 
hold on
axis([0,1000,-1,1200])
plot(RegionArtemisia.Central,'y');
legend('Central','Location','NorthEast');
hold off


subplot(3,3,2)
hold on
axis([0,1000,-1,1200])

set(plot(RegionArtemisia.EastNorthCentral),'Color',[0.5,0.5,0.5]);
legend('EastNorthCentral')
hold off

subplot(3,3,3)
hold on
axis([0,1000,-1,1200])
plot(RegionArtemisia.Northeast,'b');
legend('Northeast');
hold off

subplot(3,3,4)
hold on
axis([0,1000,-1,1200])
 plot(RegionArtemisia.Northwest,'-b');
 legend('Northwest');
 hold off
 
 subplot(3,3,5)
hold on
axis([0,1000,-1,1000])
 plot(RegionArtemisia.South,'m');legend('South');
 hold off
 
subplot(3,3,6)
hold on
axis([0,1000,-1,1200])
 plot(RegionArtemisia.Southeast,'c');legend('Southeast');
 hold off
 
subplot(3,3,7)
hold on
axis([0,1000,-1,1200])
 plot(interp1(1:359,RegionArtemisia.Southwest,1:0.3:359),'r');legend('Southwest');
 hold off

 
subplot(3,3,8)
hold on
axis([0,1000,-1,1200])
plot(interp1(1:628,RegionArtemisia.West,1:0.5:628),'g');legend('West');
hold off

subplot(3,3,9)
hold on
axis([0,1000,-1,1200])
 plot(RegionArtemisia.WestNorthCentral,'-k');legend('WestNorthCentral');
 hold off
 

%%
 %Conc Pics Drawing Ambrosia

subplot(3,3,1) 
hold on
axis([0,1000,-1,1200])
plot(RegionAmbrosia.Central,'y');
legend('Central','Location','NorthEast');
hold off


subplot(3,3,2)
hold on
axis([0,1000,-1,1200])

set(plot(RegionAmbrosia.EastNorthCentral),'Color',[0.5,0.5,0.5]);
legend('EastNorthCentral')
hold off

subplot(3,3,3)
hold on
axis([0,1000,-1,1200])
plot(RegionAmbrosia.Northeast,'b');
legend('Northeast');
hold off

subplot(3,3,4)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.Northwest,'-b');
 legend('Northwest');
 hold off
 
 subplot(3,3,5)
hold on
axis([0,1000,-1,1000])
 plot(RegionAmbrosia.South,'m');legend('South');
 hold off
 
subplot(3,3,6)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.Southeast,'c');legend('Southeast');
 hold off
 
subplot(3,3,7)
hold on
axis([0,1000,-1,1200])
 plot(interp1(1:359,RegionAmbrosia.Southwest,1:0.3:359),'r');legend('Southwest');
 hold off

 
subplot(3,3,8)
hold on
axis([0,1000,-1,1200])
plot(interp1(1:628,RegionAmbrosia.West,1:0.5:628),'g');legend('West');
hold off

subplot(3,3,9)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.WestNorthCentral,'-k');legend('WestNorthCentral');
 hold off
 %%
 %Conc Pics Drawing Ambrosia

subplot(3,3,1) 
hold on
axis([0,1000,-1,1200])
plot(RegionAmbrosia.Central,'y');
legend('Central','Location','NorthEast');
hold off


subplot(3,3,2)
hold on
axis([0,1000,-1,1200])

set(plot(RegionAmbrosia.EastNorthCentral),'Color',[0.5,0.5,0.5]);
legend('EastNorthCentral')
hold off

subplot(3,3,3)
hold on
axis([0,1000,-1,1200])
plot(RegionAmbrosia.Northeast,'b');
legend('Northeast');
hold off

subplot(3,3,4)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.Northwest,'-b');
 legend('Northwest');
 hold off
 
 subplot(3,3,5)
hold on
axis([0,1000,-1,1000])
 plot(RegionAmbrosia.South,'m');legend('South');
 hold off
 
subplot(3,3,6)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.Southeast,'c');legend('Southeast');
 hold off
 
subplot(3,3,7)
hold on
axis([0,1000,-1,1200])
 plot(interp1(1:359,RegionAmbrosia.Southwest,1:0.3:359),'r');legend('Southwest');
 hold off

 
subplot(3,3,8)
hold on
axis([0,1000,-1,1200])
plot(interp1(1:628,RegionAmbrosia.West,1:0.5:628),'g');legend('West');
hold off

subplot(3,3,9)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.WestNorthCentral,'-k');legend('WestNorthCentral');
 hold off
 

 %
 %Conc Pics Drawing Ambrosia

subplot(3,3,1) 
hold on
axis([0,1000,-1,1200])
plot(RegionAmbrosia.Central,'y');
legend('Central','Location','NorthEast');
hold off


subplot(3,3,2)
hold on
axis([0,1000,-1,1200])

set(plot(RegionAmbrosia.EastNorthCentral),'Color',[0.5,0.5,0.5]);
legend('EastNorthCentral')
hold off

subplot(3,3,3)
hold on
axis([0,1000,-1,1200])
plot(RegionAmbrosia.Northeast,'b');
legend('Northeast');
hold off

subplot(3,3,4)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.Northwest,'-b');
 legend('Northwest');
 hold off
 
 subplot(3,3,5)
hold on
axis([0,1000,-1,1000])
 plot(RegionAmbrosia.South,'m');legend('South');
 hold off
 
subplot(3,3,6)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.Southeast,'c');legend('Southeast');
 hold off
 
subplot(3,3,7)
hold on
axis([0,1000,-1,1200])
 plot(interp1(1:359,RegionAmbrosia.Southwest,1:0.3:359),'r');legend('Southwest');
 hold off

 
subplot(3,3,8)
hold on
axis([0,1000,-1,1200])
plot(interp1(1:628,RegionAmbrosia.West,1:0.5:628),'g');legend('West');
hold off

subplot(3,3,9)
hold on
axis([0,1000,-1,1200])
 plot(RegionAmbrosia.WestNorthCentral,'-k');legend('WestNorthCentral');
 hold off
 
 

 

 
 %%
 plev = 0:0.1:100;
 fnt_sze = 20;
lne_wdth = 1.5;
lne_styl = {'-b','-r','k','c','g','--k','c','m','k'};
m=1;
h1=figure;
for i=1:9
 semilogy(plev,prctile((RegionAmbrosia.(deblank(Area(i,:)))),plev),lne_styl{i},'LineWidth',lne_wdth); hold on;
     
 end
 hold off
 h2=figure;
for i=1:9
 semilogy(plev,prctile((RegionArtemisia.(deblank(Area(i,:)))),plev),lne_styl{i},'LineWidth',lne_wdth); hold on;
     
 end
 hold off
 
 h3=figure;
for i=1:9
 semilogy(plev,prctile((RegionBetula.(deblank(Area(i,:)))),plev),lne_styl{i},'LineWidth',lne_wdth); hold on;
     
 end
 hold off
 
 h4=figure;
for i=1:9
 semilogy(plev,prctile((RegionGramineae.(deblank(Area(i,:)))),plev),lne_styl{i},'LineWidth',lne_wdth); hold on;
     
 end
 hold off
 
 h5=figure;
for i=1:9
 semilogy(plev,prctile((RegionQuercus.(deblank(Area(i,:)))),plev),lne_styl{i},'LineWidth',lne_wdth); hold on;
     
 end
 hold off
 
 

