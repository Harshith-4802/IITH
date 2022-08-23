import numpy as np
import matplotlib.pyplot as plt

beta = 2*170.1e-6
W_L = 1.5
beta_W_L = beta*W_L
Vdd = 2.5
R = 75e3
n = int(1e3)
Vt = 0.4

Vin = np.linspace(0, Vdd, n)
Vout = []
g = []

Vm = Vt + (np.sqrt(1 + 2*beta_W_L*R*(Vdd-Vt))-1)/(beta_W_L*R)
Vst = Vt + (np.sqrt(1 + 2*beta_W_L*R*(Vdd))-1)/(beta_W_L*R)
Vost = Vdd - 0.5*beta_W_L*R*np.power(Vst-Vt, 2)
Vil = Vt + 1/(beta_W_L*R)
Vih = Vt - 1/(beta_W_L*R) + 2*np.sqrt(2*Vdd/(3*beta_W_L*R))

Voh = Vdd - 0.5*beta_W_L*R*np.power(Vil-Vt, 2)
Vol = (1 + beta_W_L*R*(Vih-Vt) - np.sqrt(np.power(1 + beta_W_L*R*(Vih-Vt), 2) - 2*beta_W_L*R*Vdd))/(beta_W_L*R)

print("____NMOS Inverter analysis____")
print("VM is {}V".format(np.round(Vm, 3)))
print("Vin at which regions change from saturation to linear is {}V".format(np.round(Vst, 3)))
print("VIL is {}V and VIH is {}V".format(np.round(Vil, 3), np.round(Vih, 3)))
print("VOL is {}V and VOH is {}V".format(np.round(Vol, 3), np.round(Voh, 3)))
print("\nNoise margins")
print("NML is {}V".format(np.round(Vil - Vol, 3)))
print("NMH is {}V".format(np.round(Vih - Voh, 3)))

for i in range(n):
	if Vin[i] > Vst:
		x = 1 + beta_W_L*R*(Vin[i]-Vt)
		Vout.append((x - np.sqrt(np.power(x, 2) - 2*beta_W_L*R*Vdd))/(beta_W_L*R))
		g.append(1 - (1+x)/np.sqrt(np.power(x, 2) - 2*beta_W_L*R*Vdd))
	elif Vin[i] > Vt:
		Vout.append(Vdd - 0.5*beta_W_L*R*np.power(Vin[i]-Vt, 2))
		g.append(-1*beta_W_L*R*(Vin[i]-Vt))
	else:
		Vout.append(Vdd)
		g.append(0)

Vout = np.array(Vout)
g = np.array(g)

plt.figure()
plt.title("NMOS Inverter DC characteristics")
plt.plot(Vin, Vout)
plt.plot(Vm, Vm, "*")
plt.text(Vm, Vm, r'$V_{M}$')
plt.plot(Vih, Vol, "*")
plt.text(Vih, Vol, r'$V_{IH}, V_{OL}$')
plt.plot(Vil, Voh, "*")
plt.text(Vil, Voh, r'$V_{IL}, V_{OH}$')
plt.plot(Vst, Vost, "*")
plt.text(Vst, Vost, r'$V_{Sat->Lin}$')
plt.xlabel(r'$V_{in}$')
plt.ylabel(r'$V_{out}$')
plt.grid()
plt.savefig('../tex/figs/Q4.eps')

pg = 1 - np.sqrt(1 + beta_W_L*2*R*Vdd)
print("Peak gain is {}".format(np.round(pg, 3)))
plt.figure()
plt.title("NMOS Inverter gain")
plt.plot(Vin, g)
plt.axhline(y=-1, color="red")
plt.plot(Vst, pg, "*")
plt.text(Vst, pg, "Peak gain of {}".format(np.round(pg, 3)))
plt.plot(Vih, -1, "*")
plt.text(Vih, -1, r'$V_{IH}, V_{OL}$')
plt.plot(Vil, -1, "*")
plt.text(Vil, -1, r'$V_{IL}, V_{OH}$')
plt.grid()
plt.savefig('../tex/figs/Q4_gain.eps')
plt.show() 