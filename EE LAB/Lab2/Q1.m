clc;clear;close all;
%Constants
kB = 8.617*10^-5;%eV/K
Ef = 1;%eV
T1 = 100;%K
T2 = 300;%K  
T3 = 500;%K
T4 = 1000;%K

E = 0:0.001:2;%eV

f1 = 1./(1 + exp((E-Ef)/(kB*T1)));
f2 = 1./(1 + exp((E-Ef)/(kB*T2)));
f3 = 1./(1 + exp((E-Ef)/(kB*T3)));
f4 = 1./(1 + exp((E-Ef)/(kB*T4)));

set(0,'DefaultAxesFontSize',30,'DefaultAxesFontWeight','normal','DefaultAxesLineWidth',3);
figure(1);
hold on;
plot(E,f1,'LineWidth',3);
plot(E,f2,'LineWidth',3);
plot(E,f3,'LineWidth',3);
plot(E,f4,'LineWidth',3);
xlim([0 2]);
ylim([0 1]);
xlabel('E(eV)'); 
ylabel('f(E)');
legend('T=100 K','T=300 K','T=500 K','T=1000 K','Location','NorthEast')

%Boltzman statistics
T = 30;%K
f = 1./(1 + exp((E-Ef)/(kB*T)));
b  = 1./exp((E-Ef)/(kB*T));
figure(2);
plot(E,f,'LineWidth',3,E,b,'LineWidth',3);
xlim([0 2]);
ylim([0 1]);
xlabel('E(eV)'); 
ylabel('f(E)');
legend('Fermi-Dirac','Maxwell Boltzman','Location','Southeast');