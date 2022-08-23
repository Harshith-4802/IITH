import numpy as np
import matplotlib.pyplot as plt

def f(x):
	return 4e-11 * (np.exp(1000*x/25.9) - 1) + 2*x - 2.5
def df(x):
	return (4e-8/25.9)*np.exp(1000*x/25.9) + 2

plt.figure()
plt.plot(np.linspace(0.4, 0.8, 1000), f(np.linspace(0.4, 0.8, 1000)))
plt.grid()
plt.xlabel('x')
plt.ylabel('f(x)')
x0 = 0.8
itr = 13
for i in range(itr):
	print("x{} is {} and f(x{}) is {}".format(i, x0, i, f(x0)))
	plt.plot(x0, f(x0), "*")
	x0 -= f(x0)/df(x0)
plt.text(x0-0.1, f(x0)+25, "After {} iterations,\n     x0={}".format(itr, np.round(x0, 3)))
plt.savefig('../tex/figs/Q2_solv.eps')
plt.show()