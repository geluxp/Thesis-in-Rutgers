
subplot(3,3,5) 
hold on
axis([0,1000,-1,1000])
a=length(RegionArtemisia.Central);
 plot(interp1(1:a,RegionArtemisia.Central,1:a/1000:a),'y');
legend('Central','Location','NorthEast');
hold off


subplot(3,3,6)
hold on
axis([0,1000,-1,1000])
a=length(RegionArtemisia.EastNorthCentral);
set(plot(interp1(1:a,RegionArtemisia.EastNorthCentral,1:a/1000:a)),'Color',[0.5,0.5,0.5]);
legend('EastNorthCentral')
hold off

subplot(3,3,3)
hold on
axis([0,1000,-1,1000])
a=length(RegionArtemisia.Northeast);
plot(interp1(1:a,RegionArtemisia.Northeast,1:a/1000:a),'b');
legend('Northeast');
hold off

subplot(3,3,1)
hold on
axis([0,1000,-1,1000])
a=length(RegionArtemisia.Northwest);
 plot(interp1(1:a,RegionArtemisia.Northwest,1:a/1000:a),'-b');
 legend('Northwest');
 hold off
 
 subplot(3,3,8)
hold on
axis([0,1000,-1,1000])
a=length(RegionArtemisia.South);
 plot(interp1(1:a,RegionArtemisia.South,1:a/1000:a),'m');legend('South');
 xlabel('Flowering Season Period(Day)');
 hold off
 
subplot(3,3,9)
hold on
axis([0,1000,-1,1000])
a=length(RegionArtemisia.Southeast);
plot(interp1(1:a,RegionArtemisia.Southeast,1:a/1000:a),'c');legend('Southeast');
 hold off
 
subplot(3,3,7)
hold on
axis([0,1000,-1,1000])
a=length(RegionArtemisia.Southwest);
 plot(interp1(1:a,RegionArtemisia.Southwest,1:a/1000:a),'r');legend('Southwest');
 hold off

 
subplot(3,3,4)
hold on
axis([0,1000,-1,1000])
a=length(RegionArtemisia.West);

 plot(interp1(1:a,RegionArtemisia.West,1:a/1000:a),'g');
legend('West');
ylabel('Pollen Density of Artemisia(Number/m3)');
hold off

subplot(3,3,2)
hold on
axis([0,1000,-1,1000])
a=length(RegionArtemisia.WestNorthCentral);
 plot(interp1(1:a,RegionArtemisia.WestNorthCentral,1:a/1000:a),'-k');legend('WestNorthCentral');
 hold off