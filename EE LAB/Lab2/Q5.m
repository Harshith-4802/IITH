clc;clear;close all;
%constants
kB = 8.617*10^-5;%eV/K
Ef = 0;%eV
m = 9.31*10^-31;%kg
h = 4.13*10^-15;%eV.s
hbar= h/(2*pi);
T1 = 300;%K
T2 = 400;%K
T3 = 500;%K
E = 0:0.001:1;%eV

%Multiplying factors to get units to required value
n1 = (1/1000000)*(1/(2*(pi)^2))*((2*m/hbar^2)^(1.5))*(sqrt(E)).*(1./(1 + exp((E-Ef)/(kB*T1))));
n2 = (1/1000000)*(1/(2*(pi)^2))*((2*m/hbar^2)^(1.5))*(sqrt(E)).*(1./(1 + exp((E-Ef)/(kB*T2))));
n3 = (1/1000000)*(1/(2*(pi)^2))*((2*m/hbar^2)^(1.5))*(sqrt(E)).*(1./(1 + exp((E-Ef)/(kB*T3))));

set(0,'DefaultAxesFontSize',30,'DefaultAxesFontWeight','normal','DefaultAxesLineWidth',1);
hold on;
plot(E,n1,'linewidth',3);
plot(E,n2,'linewidth',3);
plot(E,n3,'linewidth',3);
legend('T=300 K','T=400 K','T=500 K','Location','NorthEast')
%After converting to required units
xlabel('E(eV)'); 
ylabel('n(ev^{-1}cm^{-3})');