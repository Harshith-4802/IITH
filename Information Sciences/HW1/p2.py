import math

def nCr(n,r):
    f = math.factorial
    return f(n) // f(r) // f(n-r)

m = 4
n = 11
p = 0.21188490495
N = 1276
M = 632
n = N
m = M
ans = 0

mark = 1- (n*p)/(m+1)

a = m+1-n*p
var = n*p*(1-p)
cheb = 1 - var/a**2

d = ((m+1)/(n*p)) - 1
exp = math.exp(-((d**2)*n*p)/3)
cher = 1 - exp

print(mark)
print(cheb)
print(cher)
print(((d**2)*n*p)/3)
