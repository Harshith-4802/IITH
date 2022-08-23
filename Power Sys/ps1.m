xclc;clear all; close all;
%Impedance/admittance matrix of three-phase line 

r2p = @(x) [abs(x) rad2deg(angle(x))];                      % Rectangular -> Phasor
p2r = @(x) x(1)*exp(1i*deg2rad(x(2)));                      % Phasor -> Rectangular 
pm = @(x,y) [x(1)*y(1) x(2)+y(2)];                          % Phasor Multiply
pd = @(x,y) [x(1)/y(1) x(2)-y(2)];                          % Phasor Divide
p2r([1 90]);
% Vln_a = 
% Vln_b = 
% Vln_c = 


% Vln_abc = [Vln_a;Vln_b;Vln_c]

Zln_aa = 1 + 3i;  
Zln_bb = Zln_aa;
Zln_cc = Zln_aa;
Zln_ab = 4 + 1i;
Zln_bc = Zln_ab;
Zln_ca = Zln_ab;
% Zln_ab = 1 + 1i ;Zln_bb = 2 + 1i ;
% Zln_ca = 2 + 1i ;Zln_bc = 1 + 1i ; Zln_cc = 1 + 1i;

Zln_abc =  [Zln_aa  Zln_ab  Zln_ca ;
            Zln_ab  Zln_bb  Zln_bc ;
            Zln_ca  Zln_bc  Zln_cc ];
        
Yln_abc = inv(Zln_abc)

% Iln_a = 2;
% Iln_b = 2;
% Iln_c = 2;
% Iln_abc = [Iln_a;Iln_b;Iln_c];
% 
% Vln_abc = Zln_abc * Iln_abc;
% Iln_abc = Yln_abc * Vln_abc
a = (-1+1j*sqrt(3))/2;
C = [1 1 1;1 (a.^2) a;1 a (a.^2)];
seq_Yln_abc = inv(C)*Yln_abc*C





