import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

tau = 1e-9
tr = np.linspace(1e-11, 1e-8, 100)

tp = tau * np.log(2 * (np.exp(tr/tau) - 1)/(tr/tau))

df = pd.read_excel("Q5_b.xlsx")

plt.figure()
plt.title("Effect of Rise time")
plt.grid()
plt.ylabel(r'$t_p$(in nA)')
plt.xlabel(r'$t_{r,in}$(in nA)')
plt.plot(df['tr_in']/1000, df['tp']/1000, label="Simulated")
plt.plot(tr*1e9, tp*1e9, "--", label="Analytical")
plt.legend()
plt.savefig('../tex/figs/Q5_b.eps')
plt.show()