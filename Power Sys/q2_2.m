% %QZ2_DS_G2_19
clc;clear all;close all
%Q1
% w = 2*pi*50;
% 
% r = 15;
% l = 0.04;
% c = 0.005;
% V = 240;
% 
% xl = w*l;
% xc = 1/(w*c);
% z = sqrt(r^2+(xl-xc)^2)
% I = V/z;
% P = V*I;
% angle = atan((xl-xc)/r);
% Q = P*tan(angle)

%Q2

S_old = 300;
V_old = 300;
S_new = 400;
V_new = 500;

Z_old = 0.7;

Z_new = (V_old/V_new)(V_old/V_new)(S_new/S_old)*Z_old

Z_base = V_new * V_new / S_new;

Z = Z_new * Z_base

% Q3
% k1 = 70
% k2 = 20
% k3 = 20
% 
% avg = (k1*24 + 16*k3/pi)/24
% peak = k1 + sqrt(k2^2 + k3^2)
% 
% load_factor = avg/peak

% Q4

% k11 = 15
% k12 = 8
% k21 = 12
% k22 = 4
% 
% P_p_1 = k11 + k12
% P_p_2 = k21 + k22
% t_p = k11 + k21 + sqrt(k12^2 + k22^2)
% diversity_factor = ((P_p_1+P_p_2)/t_p)

% Q5

% a = exp(1j*2*pi/3);
% C = [1, 1, 1;1, a^2, a;1, a, a^2];
% 
% Va = 1 + 0j
% Vb = 0 -1.6j
% Vc = -0.8 + 1.4j
% zhv = -2.3 +0.2j
% zlv = 0.25 +0.6j
% zps = 1.2 + 0.2j
% 
% V012_a = a_seq([Va; Vb; Vc])
% 
% i0 = 0
% i1 = V012_a(2)/(zhv + zlv + zps)
% i2 = V012_a(3)/(zhv + zps*exp(-1j*2*pi/3))
% 
% Iphase_hv = C*[i0;i1;i2]
% Iphase_lv = Iphase_hv*exp(-1j*pi/3)

function F012_a = a_seq(Fabc)
    a = exp(1j*2*pi/3);
    C = [1, 1, 1;1, a^2, a;1, a, a^2];
    F012_a = C\Fabc;
end