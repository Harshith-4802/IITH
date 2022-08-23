clc;clear all; close all;

%Admittance matrix of an ungrounded star-connected load
%%%%%Yld_abc = y_star(8 + 4i,0 + 3i,5.5 + 3.5i,0 + 2i,3 + 2i,0 + 4.75i)
r2p = @(x) [abs(x) rad2deg(angle(x))];                      % Rectangular -> Phasor
p2r = @(x) x(1)*exp(1i*deg2rad(x(2)));                      % Phasor -> Rectangular 
pm = @(x,y) [x(1)*y(1) x(2)+y(2)];                          % Phasor Multiply
pd = @(x,y) [x(1)/y(1) x(2)-y(2)];                          % Phasor Divide

Vld_a = 0 + 180i;
Vld_b = 163 -163i;
Vld_c = -202-147i;

Vld_abc = [Vld_a;Vld_b;Vld_c];

Zld_aa = 8 + 4i ;  
% Zld_bb = Zld_aa;
% Zld_cc = Zld_aa;
% Zld_ab = 4 + 1i;
% Zld_bc = Zld_ab;
% Zld_ca = Zld_ab;
Zld_ab = 0 + 3i ;Zld_bb = 5.5 + 3.5i ;
Zld_ca = 0 + 4.75i ;Zld_bc = 0 + 2i ; Zld_cc = 3 + 2i;

Zld_abc =  [1  1  1 ;
            Zld_aa - Zld_ab  Zld_ab - Zld_bb  Zld_ca - Zld_bc ;
            Zld_aa - Zld_ca  Zld_ab - Zld_bc  Zld_ca - Zld_cc ];
Yld_abc = inv(Zld_abc)*[0 0 0;1 -1 0;1 0 -1]
% Ild_a = 
% Ild_b = 
% Ild_c = 
% Ild_abc = [Ild_a;Ild_b;Ild_c]

% Vld_abc = Zld_abc * Ild_abc;
Ild_abc = Yld_abc * Vld_abc

% a = (-1+1j*sqrt(3))/2;
% C = [1 1 1;1 (a.^2) a;1 a (a.^2)];
% seq_Yld_abc = inv(C)*Yld_abc*C