#Exercise 1.3
from numpy import random
num_trials = 10000
samples = random.rand(num_trials)
p_a = 0.0620559982962137
p_b = 0.469015909097925
p_c = 0.387569407614275
p_d = 0.081358684991586
output = ""
for s in samples:
	if(s < p_a):
		output += 'a'
	elif (s < p_a + p_b):
		output += 'b'
	elif (s < p_a + p_b + p_c):
		output += 'c'
	else:
		output += 'd'
print(output)