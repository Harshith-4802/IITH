clc;clear;close all;
%constants
kB = 8.617*10^-5;%eV/K
Eg = 1.1;%eV

Nc = 2.8e19;%cm^3
Nv = 1.8e19;%cm^-3

T = 1000:100:5000;

ni = (Nc*Nv)^(0.5).*exp(-Eg./(2*kB*T));
Tinv = 1000./T;

set(0,'DefaultAxesFontSize',30,'DefaultAxesFontWeight','normal','DefaultAxesLineWidth',3);
semilogy(Tinv,ni,'LineWidth',2);
xlabel('1000/T(K^{-1})');
ylabel('Carrier concentration');