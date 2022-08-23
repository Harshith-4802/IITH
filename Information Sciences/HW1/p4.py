#Exercise 1.4.3
from numpy import random
num_trials = 10000
samples = random.rand(num_trials)
p_a = 0.0620559982962137
p_b = 0.469015909097925
p_c = 0.387569407614275
p_d = 0.081358684991586
output = ""
a_count = 0
b_count = 0
c_count = 0
d_count = 0
for s in samples:
	if(s < p_a):
		output += 'a'
		a_count += 1
	elif (s < p_a + p_b):
		output += 'b'
		b_count += 1
	elif (s < p_a + p_b + p_c):
		output += 'c'
		c_count += 1
	else:
		output += 'd'
		d_count += 1

ans = abs(((a_count/num_trials)-p_a))+abs(((b_count/num_trials)-p_b)) + abs(((c_count/num_trials)-p_c)) + abs(((d_count/num_trials)-p_d))
print(ans)
print(p_a+p_b+p_c+p_d)