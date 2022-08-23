clc;clear all; close all;

w = 2*pi*50;

r = 5;
l = 0.02;
c = 0.0025;
V = 100;

xl = w*l;
xc = 1/(w*c);
z = sqrt(r^2+(xl-xc)^2)
I = V/z;
P = V*I;
angle = atan((xl-xc)/r);
Q = P*tan(angle)