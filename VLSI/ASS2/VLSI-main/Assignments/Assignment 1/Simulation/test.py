import cmath as cm


def polar_c(c):
	r, t = cm.polar(c)
	return r, 180*t/cm.pi
# x = (1 + 100*1j)/(1 + 1100*1j)
f = 145.89
x = (10000 + 2*cm.pi*f*1j)/(10000 + 2*cm.pi*f*11*1j)
print(polar_c(x))

import numpy as np

print(np.roots([4.796e-7, 3.72e-8, 2, -2.5]))