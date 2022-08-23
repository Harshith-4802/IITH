import math
import numpy as np

#Function for calculating the entropy of prabability vector p
def H(p):	
	h = 0
	for x in p:
		if(x > 0):
			h -= x*math.log(x,2)
	return h
file = open('inputfile_85.txt','r')

def entropies(filename):
	file = open(filename, encoding="utf8")
	data = file.read()
	#Converting the data to ascii format by using ord function
	ascii_data = [ord(c) for c in data]  

	count = 0   #for storing total number of ascii characters
	ascii_count = 0
	p = np.zeros(256)  #Stores the number of occurences of each ascii character
	for x in ascii_data:
		if(x < 256):
			count += 1
			p[x]+=1

	px = p/count
	for i in px:
		if(i > 0):
			ascii_count+=1
	Hx = H(px)
	print("Entropy of " + filename + " = " + str(Hx))
	print("Total number of characters is " + str(count))
	print("Number of characters ASCII is " + str(ascii_count))
	print("optimal filesize = " + str(count*Hx/8) + " bytes")

	#Matrix for storing the number of pairs of letters
	#For example ascii('a') = 97
	#so px1x2_s[97][97] stores the number of occurences of 'aa'
	px1x2_s = np.zeros((256,256))
	count = 0
	for i in range(len(ascii_data)-1):
		if ascii_data[i] < 256 and ascii_data[i+1]<256:
			count += 1
			px1x2_s[ascii_data[i],ascii_data[i+1]] += 1


	px1x2 = (px1x2_s/count).reshape(256*256)   #Converting the probability matrix to a vector
	Hx1x2 = H(px1x2)
	Hx2gx1 = Hx1x2 - Hx
	print("Conditional entropy of " + filename + " = " + str(Hx2gx1))
	print("optimal filesize = " + str(count*Hx2gx1/8) + " bytes")

entropies('inputfile_85.txt')
print("Filesize of zipped inputfile_85.txt is 2846 bytes")
print()
entropies('file2.txt')
print("Filesize of zipped file2.txt is 1254510 bytes")
