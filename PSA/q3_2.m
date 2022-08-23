clc; clear all;close all;   

% Y = 1j*[-15.18, 4, 0, 11.43;4,-16.49, 12.49, 0;0, 12.69, -17.29, 5; 11.43, 0, 5, -15.93];
% r = [0,0,-1.58;0,0,0;1.58,0,0];   
% im = 1j*[-27.54,21.05,5.76;21.05,-60.32,39.47;5.76,39.47,-44.23];
% Y = r+im
% % Y = 1j*[-9.8, 0, 4, 5;0, -8.3, 2.5, 5;4, 2.5, -14.5, 8;5, 5, 8, -18]
% % QZ3_Q1_ANS_G1_10
% QZ3_Q2_ANS = Kron_reduction(Y,3)

U = eye(3);
U2 = eye(2);
a = exp(1j*2*pi/3);
C = [1,1,1;1,a^2,a;1,a,a^2];
   
Y11=0.0000 -27.5400i;
Y21=0.0000 +21.0500i;
Y31=1.5800 + 5.7600i;
Y12=0.0000 +21.0500i;
Y22=0.0000 -60.3200i;
Y32=0.0000 +39.4700i;
Y13=-1.5800 + 5.7600i;
Y23=0.0000 +39.4700i;
Y33=0.0000 -44.2300i;

Ys1s1 = [Y11,Y12;Y21,Y22];
Ys1s2 = [Y13;Y23];
Ys2s1 = [Y31,Y32];
Ys2s2 = Y33;

QZ3_Q2_ANS = (U2-(Ys1s2*[1,0]/Ys2s2))\(Ys1s1-(Ys1s2*Ys2s1/Ys2s2))

function YredB = Kron_reduction(Y, busnumbers)
    Yred = Y;
    x = size(busnumbers);
    for i=1:x(2)
        busnumber = busnumbers(i);
        Yred = change(Yred, busnumber);
    end
    
    ys1s1 = Yred(1:end-x(2), 1:end-x(2));
    ys1s2 = Yred(1:end-x(2),end-x(2)+1:end);
    ys2s1 = Yred(end-x(2)+1:end, 1:end-x(2));
    ys2s2 = Yred(end-x(2)+1:end, end-x(2)+1:end);
    YredB = ys1s1 - ys1s2*(ys2s2^-1)*ys2s1;
end

function Yred = change(Y, busnumber) 
    rneciB = Y(busnumber,:);
    Yred = vertcat(Y(1:busnumber-1, :), Y(busnumber+1:end, :), rneciB);
    cneciB = Yred(:, busnumber);
    Yred = [Yred(:, 1:busnumber-1), Yred(:,busnumber+1:end), cneciB];
end