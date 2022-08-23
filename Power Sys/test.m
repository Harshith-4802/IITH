clc; clear all;close all;   

v = [0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5];
f1 = [0,157.5,312,475.4,627,783,941.5,1090,1250,1410,1570].*(0.001);
f2 = [0,157.3,311.6,469.3,629.4,779.7,942.7,1100,1250,1410,1570].*(0.001);
f3 = [0,157,312.7,472.3,649.3,786.9,940.2,1100,1260,1410,1570].*(0.001);

% coefficients = polyfit(v,f1, 1);
% slope1 = coefficients(1)
% 
% coefficients = polyfit(v,f2, 1);
% slope2 = coefficients(1)
% 
% coefficients = polyfit(v,f3, 1);
% slope3 = coefficients(1)

plot(v,f1,'b-*')
% plot(v,f2,'r-*')
% plot(v,f3,'g-*')
xlabel("Input voltage Amplitude(V)")
ylabel("Average Vo(V)")