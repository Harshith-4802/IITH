clc;clear;close all;
%constants
Efi = 1;%eV
kB = 8.617*10^(-5);%eV/K
T = 300;%K

ni = 1.05*10^10;
n = 10^13:10^10:10^14;
Ef = Efi + kB*T*log(n/ni);

set(0,'DefaultAxesFontSize',30,'DefaultAxesFontWeight','normal','DefaultAxesLineWidth',3);
plot(n,Ef,'LineWidth',2);
%After converting to required units
xlabel('n(eV^{-1}cm^{-3})');
ylabel('E_{F}(ev)');