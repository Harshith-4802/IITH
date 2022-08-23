clc;clear all; close all;
%delta to Y
% Zab = 1+2j;
% Zbc = 1+3j;
% Zca = 1+2j;
% Za = (Zab*Zca)/(Zab+Zbc+Zca)
% Zb = (Zbc*Zab)/(Zab+Zbc+Zca)
% Zc = (Zca*Zbc)/(Zab+Zbc+Zca)

Yab = 1+2j;
Ybc = 1+3j;
Yca = 1+2j;
Ya = (Yab*Yca+Ybc*Yab+Yca*Ybc)/Ybc
Yb = (Yab*Yca+Ybc*Yab+Yca*Ybc)/Yca
Yc = (Yab*Yca+Ybc*Yab+Yca*Ybc)/Yab

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Y to delta

% Za = 1+2j;
% Zb = 1+3j;
% Zc = 1+2j;
% Zab = (Za*Zb+Zb*Zc+Zc*Za)/Zc
% Zbc = (Za*Zb+Zb*Zc+Zc*Za)/Za
% Zca = (Za*Zb+Zb*Zc+Zc*Za)/Zb

% Ya = 1+2j;
% Yb = 1+3j;
% Yc = 1+2j;
% Yab = (Ya*Yb)/(Ya+Yb+Yc)
% Ybc = (Yb*Yc)/(Ya+Yb+Yc)
% Yca = (Yc*Ya)/(Ya+Yb+Yc)