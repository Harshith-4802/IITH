clc;clear all; close all;
a = exp(1j*2*pi/3);
f0a = 100+0i;
f1b = 0+140i;
f2c = 20+25i;
f1a = f1b*a;
f2a = f2c*a;
fa = f1a + f0a + f2a
fb = f0a + ((a^2)*f1a) + a*f2a
fc = f0a + ((a^2)*f2a) + a*f1a