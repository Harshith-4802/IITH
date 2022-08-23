clc;clear;close all;
%Constants
m = 9.31*10^-31;%kg
h = 4.13*10^-15;%eV.s
hbar= h/(2*pi)

E = 0:0.005:2;%eV

D = (1/(2*pi^2))*(2*m/hbar^2)^(1.5)*(E.^0.5);

set(0,'DefaultAxesFontSize',30,'DefaultAxesFontWeight','normal','DefaultAxesLineWidth',3);
figure(1);
plot(E,D,'LineWidth',2)
xlim([0 2]);
%After converting to required units
xlabel('E(eV)'); 
ylabel('D(E)*10^{-6}eV^{-1}cm^{-3}');



