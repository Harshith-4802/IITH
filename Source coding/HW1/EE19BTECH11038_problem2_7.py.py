import numpy as np

f = open("inputfile_problem3_28.txt", 'r')					#Opening the input file
x = f.read()										#Reading the contents of the file 

emp_count = np.array([x.count(chr(i)) for i in range(256)])

total_count = np.sum(emp_count)

emp_pmf = emp_count/total_count

def entropy(pmf):
	pmf = pmf[pmf != 0]
	return -1*np.dot(pmf, np.log2(pmf))

hx = entropy(emp_pmf)
print('H(X):- ', hx)

px1x2_mat = []

for i in range(0, 256):
	for j in range(0, 256):
		chk = chr(i) + chr(j)
		px1x2_mat.append(x.count(chk))

px1x2_mat = np.array(px1x2_mat)	
px1x2 = px1x2_mat[px1x2_mat != 0]/np.sum(px1x2_mat)
hx1x2 = entropy(px1x2)
print("H(X1, X2):", hx1x2)
hx2gx1 = hx1x2 - hx
print("H(X2|X1):", hx2gx1)

print("Commpressed filesize: ", 3648)
print("Optimal compressed filesize with individual entropy in bytes: ", total_count*hx/8)
print("Optimal compressed filesize with conditional entropy in bytes: ", (total_count-1)*hx2gx1/8)
