#Exercise 1.6
def f(x):
    return {
	'a':1,
	'b':2,
	'c':3,	
	'd':4,
	'e':5,
	'f':6,
	'g':7,
	'h':8,
	'i':9,
	'j':10,
	'k':11,
	'l':12,
	'm':13,
	'n':14,
	'o':15,
	'p':16,
	'q':17,
	'r':18,
	's':19,
	't':20,
	'u':21,
	'v':22,
	'w':23,
	'x':24,
	'y':25,
	'z':26
    }[x]

pmf = [0]*26
count = 0
file = open('inputfile_85.txt',"r")
data = file.read()
for t in data:
	pmf[f(t)-1] += 1
	count += 1

empericalfreq = [0]*26
for i in range(len(pmf)):
	empericalfreq[i] = pmf[i] / count
print(empericalfreq)
