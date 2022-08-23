import math
import numpy as np

#Function for calculating the entropy of a prabability vector p
def H(p):	
	h = 0
	for x in p:
		if(x > 0):
			h -= x*math.log(x,2)
	return h	

def pmf(data):
	#Converting the data to ascii format by using ord function
	ascii_data = [ord(c) for c in data]  
	count = 0   		#for storing total number of ascii characters
	p = np.zeros(256)  	#Stores the number of occurences of each ascii character
	for x in ascii_data:
		count += 1
		p[x]+=1
	px = p/count		#Empirical pmf -> p(xi)
	Hx = H(px)
	print("pmf = ")
	for i in range(256):
		if(px[i]>0):
			print(chr(i)+" = " + str(px[i]))
	print("Entropy = ",Hx)

# Takes the input file data and the code design as input and outputs encoded binary string
def encode(data,codes):
	encoded = ""
	for c in data:
		encoded = encoded + codes[c]
	return encoded
	
# Takes encoded string and the code design as input and outputs decoded ascii string
def decode(encoded,codes):
	decodes = {}
	for c in codes:
		decodes[codes[c]] = c
	curr = ""
	decoded = ""
	for c in encoded:
		curr += c
		if curr in decodes:
			decoded += decodes[curr]
			curr = ""
	return decoded
	
####################################### Problem -1 ################################################
file = open("inputfile_problem1_28.txt")
data1 = file.read()
print('problem 1 -')
pmf(data1)
print()

# The code desingn was done manually
shannon_codes1 = {'a':'00','b':'010','c':'011','d':'10100','e':'100'}
huffman_codes1 = {'a':'10','b':'00','c':'110','d':'111','e':'01'}
shannon_fano_elias_codes1 = {'a':'001','b':'0111','c':'1010','d':'110010','e':'1110'}

shannon_encoded1 = encode(data1,shannon_codes1)
shannon_decoded1 = decode(shannon_encoded1,shannon_codes1)
with open('EE19BTECH11018_HW2_problem1_shannon_compressed.txt', 'w') as f:
    f.write(shannon_encoded1)
with open('EE19BTECH11018_HW2_problem1_shannon_decoded.txt', 'w') as f:
    f.write(shannon_decoded1)
    
print("Problem1 shannon compressed sequence length = ",len(shannon_encoded1))    

huffman_encoded1 = encode(data1,huffman_codes1)
huffman_decoded1 = decode(huffman_encoded1,huffman_codes1)
with open('EE19BTECH11018_HW2_problem1_huffman_compressed.txt', 'w') as f:
    f.write(huffman_encoded1)
with open('EE19BTECH11018_HW2_problem1_huffman_decoded.txt', 'w') as f:
    f.write(huffman_decoded1)
    
print("Problem1 huffman compressed sequence length = ",len(huffman_encoded1))

shannon_fano_elias_encoded1 = encode(data1,shannon_fano_elias_codes1)
shannon_fano_elias_decoded1 = decode(shannon_fano_elias_encoded1,shannon_fano_elias_codes1)
with open('EE19BTECH11018_HW2_problem1_shannon_fano_elias_compressed.txt', 'w') as f:
    f.write(shannon_fano_elias_encoded1)
with open('EE19BTECH11018_HW2_problem1_shannon_fano_elias_decoded.txt', 'w') as f:
    f.write(shannon_fano_elias_decoded1)
print("Problem1 shannon fano elias compressed sequence length = ",len(shannon_fano_elias_encoded1))

####################################### Problem - 2 ################################################
file = open("inputfile_problem2_28.txt")
data2 = file.read()

print('\nproblem 2 -')
pmf(data2)
print()

# The code desingn was done manually
shannon_codes2 = {'a':'00','b':'100','c':'01','d':'11000','e':'101'}
huffman_codes2 = {'a':'00','b':'10','c':'01','d':'110','e':'111'}
shannon_fano_elias_codes2 = {'a':'001','b':'0110','c':'101','d':'110011','e':'1101'}

shannon_encoded2 = encode(data2,shannon_codes2)
shannon_decoded2 = decode(shannon_encoded2,shannon_codes2)
with open('EE19BTECH11018_HW2_problem2_shannon_compressed.txt', 'w') as f:
    f.write(shannon_encoded2)
with open('EE19BTECH11018_HW2_problem2_shannon_decoded.txt', 'w') as f:
    f.write(shannon_decoded2)
    
print("Problem2 shannon compressed sequence length = ",len(shannon_encoded2))

huffman_encoded2 = encode(data2,huffman_codes2)
huffman_decoded2 = decode(huffman_encoded2,huffman_codes2)
with open('EE19BTECH11018_HW2_problem2_huffman_compressed.txt', 'w') as f:
    f.write(huffman_encoded2)
with open('EE19BTECH11018_HW2_problem2_huffman_decoded.txt', 'w') as f:
    f.write(huffman_decoded2)
    
print("Problem2 huffman compressed sequence length = ",len(huffman_encoded2))

shannon_fano_elias_encoded2 = encode(data2,shannon_fano_elias_codes2)
shannon_fano_elias_decoded2 = decode(shannon_fano_elias_encoded2,shannon_fano_elias_codes2)
with open('EE19BTECH11018_HW2_problem2_shannon_fano_elias_compressed.txt', 'w') as f:
    f.write(shannon_fano_elias_encoded2)
with open('EE19BTECH11018_HW2_problem2_shannon_fano_elias_decoded.txt', 'w') as f:
    f.write(shannon_fano_elias_decoded2)
    
print("Problem2 shannon fano elias compressed sequence length = ",len(shannon_fano_elias_encoded2))

print("\nChecking the decoder by comparing input files and decodes sequences")
print(data1 == shannon_decoded1 and data1 == huffman_decoded1 and data1 == shannon_fano_elias_decoded1 and data2 == shannon_decoded2 and data2 == huffman_decoded2 and data2 == shannon_fano_elias_decoded2)

