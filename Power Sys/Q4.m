clc;clear all;close all;

U = eye(3);
a = exp(1j*2*pi/3);
C = [1, 1, 1;1, a^2, a;1, a, a^2];

% aseq = [1; 5+7j; 9-8j]
% bseq = a_to_bseq(aseq);
% cseq = b_to_cseq(bseq);
% c_to_aseq(cseq)


zld_abc_seq = z_stargnd_seq(0+1i,2+4i,0+3i)
%Ild_abc = Yld_abc * Vld_abc
function z = z_line(Zaa,Zab,Zbb,Zbc,Zcc,Zca)
    switch nargin
        case 6
            z = [Zaa,Zab,Zca;Zab,Zbb,Zbc;Zca,Zbc,Zcc];
        case 2
            z = [Zaa,Zab,Zab;Zab,Zaa,Zab;Zab,Zab,Zaa];
        otherwise
            z = zeros(3);
    end
end

function z = z_stargnd(Zn,Zaa,Zab,Zbb,Zbc,Zcc,Zca)
    switch nargin
        case 7
            z = [Zaa+Zn,Zab+Zn,Zca+Zn;Zab+Zn,Zbb+Zn,Zbc+Zn;Zca+Zn,Zbc+Zn,Zcc+Zn];
        case 3
            z = [Zaa+Zn,Zab+Zn,Zab+Zn;Zab+Zn,Zaa+Zn,Zab+Zn;Zab+Zn,Zab+Zn,Zaa+Zn];
        otherwise
            z = zeros(3);
    end
end

function y = y_star(Zaa,Zab,Zbb,Zbc,Zcc,Zca)
    switch nargin
        case 6
            z = [1,1,1;Zaa-Zab,Zab-Zbb,Zca-Zbc;Zaa-Zca,Zab-Zbc,Zca-Zcc];
            y = z\[0,0,0;1,-1,0;1,0,-1];
        case 2
            z = [1,1,1;Zaa-Zab,Zab-Zaa,0;Zaa-Zab,0,Zab-Zaa];
            y = z\[0,0,0;1,-1,0;1,0,-1];
        otherwise
            y = zeros(3);
    end
end

function y = y_delta(Za1a1,Za1b1,Zb1b1,Zb1c1,Zc1c1,Zc1a1)
    switch nargin
        case 6
            z = [Za1a1,Za1b1,Zc1a1;Za1b1,Zb1b1,Zb1c1;Zc1a1,Zb1c1,Zc1c1];
            y1 = z\[1,-1,0;0,1,-1;-1,0,1];
            y = [1,0,-1;-1,1,0;0,-1,1]*y1;
        case 2
            z = [Za1a1,Za1b1,Za1b1;Za1b1,Za1a1,Za1b1;Za1b1,Za1b1,Za1a1];
            y1 = z\[1,-1,0;0,1,-1;-1,0,1];
            y = [1,0,-1;-1,1,0;0,-1,1]*y1;
        otherwise
            y = zeros(3);
    end
end

function z = z_source(Zn,Za,Zb,Zc)
    switch nargin
        case 4
            z = [Za+Zn,Zn,Zn;Zn,Zb+Zn,Zn;Zn,Zn,Zc+Zn];
        case 2
            z = [Za+Zn,Zn,Zn;Zn,Za+Zn,Zn;Zn,Zn,Za+Zn];
        otherwise
            z = zeros(3);
    end
end

function z = rnd(x)
    z = round(x,4);
end

function z = z_line_seq(Zs,Zm)
    z = [Zs+(2*Zm);Zs-Zm;Zs-Zm];
end

function z = z_stargnd_seq(Zn,Zs,Zm)
    z = [Zs+(2*Zm)+(3*Zn);Zs-Zm;Zs-Zm];
end

function z = z_star_seq(Zs,Zm)
    z = [inf;Zs-Zm;Zs-Zm];
end

function z = z_delta_seq(Zs1,Zm1)
    z = [inf;(Zs1-Zm1)/3;(Zs1-Zm1)/3];
end

function z = z_source_seq(Zn,Zs)
    z = [Zs+(3*Zn);Zs;Zs];
end

function F012_a = a_seq(Fabc)
    F012_a = C/Fabc;
end

function fab = a_to_bseq(F012_a)
    a = exp(1j*2*pi/3);
    fab = [1, a, a^2;1, 1, 1;1, a^2, a]\[1, 1, 1;1, a, a^2;1, a^2, a]*F012_a;
end

function fbc = b_to_cseq(F012_b)
    a = exp(1j*2*pi/3);
    fbc = [1, a^2, a;1, a, a^2; 1, 1, 1]\[1, a, a^2;1, 1, 1;1, a^2, a]*F012_b;
end

function fca = c_to_aseq(F012_c)
    a = exp(1j*2*pi/3);
    fca = [1, 1, 1;1, a, a^2;1, a^2, a]\[1, a^2, a;1, a, a^2; 1, 1, 1]*F012_c;
end

function P = power(Vabc, Iabc)
    P = (Vabc.')*(conj(Iabc));
    fprintf("3-phase active power/ Modified sequence domain active power: %f\n", real(P));
    fprintf("3-phase reactive power/ Modified sequence domain reactive power: %f\n", imag(P));
    fprintf("Sequence domain active power: %f\n", real(P/3));
    fprintf("Sequence domain reactive power: %f\n", imag(P/3));
end