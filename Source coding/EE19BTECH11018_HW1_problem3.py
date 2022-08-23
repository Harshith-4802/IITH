import math
import numpy as np

#Function for calculating the entropy of a prabability vector p
def H(p):	
	h = 0
	for x in p:
		if(x > 0):
			h -= x*math.log(x,2)
	return h

def entropies(filename):
	file = open(filename, encoding="utf8")
	data = file.read()
	#Converting the data to ascii format by using ord function
	ascii_data = [ord(c) for c in data]  

	count = 0   		#for storing total number of ascii characters
	p = np.zeros(256)  	#Stores the number of occurences of each ascii character
	for x in ascii_data:
		count += 1
		p[x]+=1
	
	print("Frequency of occurrence of each symbol -")
	for i in range(len(p)):
		if(p[i]>0):
			print("Frequency of " + chr(i) + " = " + str(p[i]))

	px = p/count		#empirical pmf -> p(xi)
	Hx = H(px)
	print("Entropy, H(X) = " + str(Hx))
	print("Optimal filesize(If the source is iid) = " + str(count*Hx/8) + " bytes\n")

	#Matrix for storing the number of pairs of letters
	#For example ascii('a') = 97 and ascii('b') = 98
	# ~ #so px1x2_s[97][98] stores the number of occurences of 'ab'
	px1x2_s = np.zeros((256,256))
	count = 0
	for i in range(len(ascii_data)-1):
		count += 1
		px1x2_s[ascii_data[i],ascii_data[i+1]] += 1
		
	print("Frequency of occurrence of consecutive symbols -")
	for i in range(256):
		for j in range(256):
			if(px1x2_s[i][j]>0):
				print("Frequency of " + chr(i) + chr(j) + " = " + str(px1x2_s[i][j]))
			
	px1x2 = (px1x2_s/count).reshape(256*256)   #Converting the probability matrix to a vector
	Hx1x2 = H(px1x2)
	Hx2gx1 = Hx1x2 - Hx
	print("Conditional entropy, H(X2|X1) = " + str(Hx2gx1))
	print("Optimal filesize(If the source is first-order time-homogeneous markov chain) = " + str(count*Hx2gx1/8) + " bytes\n")

entropies('inputfile_problem3_28.txt')

print("Filesize of zipped inputfile_problem3_28.txt is 1,551 bytes\n")
