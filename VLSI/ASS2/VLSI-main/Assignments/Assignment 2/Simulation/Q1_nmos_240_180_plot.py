import numpy as np
import matplotlib.pyplot as plt
from scipy import integrate
import matplotlib.ticker as ticker

data_points = [0.5, 0.55, 0.6, 0.65, 0.75, 0.8, 0.9, 1, 1.25, 1.4, 1.50, 1.75, 1.8, 1.9, 2]



def read_txt(data_point):
	file = open('Q1_nmos_400_180_{}.txt'.format(data_point), 'r')
	string = file.read()
	string = string.split('\n')
	n = len(string)
	vdd = []
	ids = []
	for i in range(1, n-1):
		d = string[i].split("\t")
		print(d)
		vdd.append(float(d[1]))
		ids.append(float(d[2]))
	vdd = np.array(vdd)
	ids = np.array(ids)
	idx = vdd >= (data_point/2)
	# print(ids[idx], vdd[idx])
	Req = -2*integrate.cumtrapz(vdd[idx]/ids[idx], vdd[idx])/data_point
	print(Req)
	file.close()
	# plt.plot(vdd, ids, "--*")
	# plt.plot(vdd[idx][1:], Req)
	# plt.show()
	return np.max(np.absolute(Req))

Req = []
for d in data_points:
	print("_____________{}___________".format(d))
	Req.append(read_txt(d))
fig = plt.figure()
plt.title(r'W = 400nm, L = 180nm')
plt.plot(data_points, Req)
plt.plot(data_points, Req, "^", color='r')
plt.xlabel(r'$V_{dd}$')
plt.ylabel(r'$R_{eq}$')
plt.ticklabel_format(axis="y", style="sci", scilimits=(0,0))
plt.grid()
plt.savefig('../tex/figs/Q1_nmos_400_180_Req.eps')
plt.show()