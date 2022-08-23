# Assignment 1
# Team Members :-
# SV Harshith - EE19BTECH11018
# Patlola Yagneek - EE19BTECH11031
# Prashant A - EE19BTECH11003
# Arun Sakthi Anand M - EE19BTECH11009

import numpy as np
from scipy.linalg import null_space

TINY_VALUE = 1e-7

def get_row():
	splitted = input().split(' ')
	mapped = list(map(float,splitted))
	return np.asarray(mapped)
 
def get_input():
	m = int(input())
	n = int(input())
	A = []
	for _ in range(m):
		A.append(get_row())
	A = np.asarray(A)
	b = np.asarray(get_row())
	c = np.asarray(get_row())
	z = np.asarray(get_row())
	return A,b,c,z

def tight_rows(A,b,z):
    tight = []	
    untight = []
    for i in range(len(A)):
        if abs(b[i]-(A[i,:]@z))<TINY_VALUE:
            tight.append(i)
        else:
            untight.append(i)
    return tight,untight

def move_to_vertex(A,b,z):
    while(True):
        tight = []
        untight = []
        for i in range(len(A)):
            if abs(b[i]-(A[i,:]@z))<TINY_VALUE:
                tight.append(i)
            else:
                untight.append(i)
                
        if(len(tight)>0):
            if(np.linalg.matrix_rank(A[tight,:])==len(z)):
                return z
        
        if(len(tight)>0):
            u = null_space(A[tight,:])[:,0]
        else:
            u = null_space(np.asmatrix(A[0,:]))[:,0]
        alpha = -1
        for i in untight:
            feasible = True
            curr_alpha = (b[i]-1*(A[i,:]@z))/(A[i,:]@u + 1e-50)
            if curr_alpha>0:
                for j in untight:
                    if (A[j,:]@(z+curr_alpha*u))-b[j]>TINY_VALUE:
                        feasible = False
                if feasible==True:
                    alpha = curr_alpha
                    break
        if alpha>0:
            z = z+alpha*u
        else:
            return -1*np.ones(len(z))

def direction_vector(A,b,c,z):
    tight,untight = tight_rows(A,b,z)
    A_tight = A[tight]
    A_tight_inv = np.linalg.inv(A_tight.T)
    alphas = np.dot(A_tight_inv,c)
    neg_alphas = np.where(alphas < 0)[0]

    if(len(neg_alphas)==0):
        return None
    
    neg_alphas = neg_alphas[0]
    v = -A_tight_inv[neg_alphas]  
    A_s = A[untight]
    b_s = b[untight]
    t = (b_s - A_s @ z) / (A_s @ v + 1e-50)
    t = t[t >= 0]
    min_t = np.min(t)
    return min_t * v
	
def vertex_marching(A,b,c,z):
    while True:
        v = direction_vector(A,b,c,z) 
        if v is None:   
            break
        else:
            z = z + v  
            
    print("Optimal value is obtained at z = ",z)
    print("Optimal Value is c.z = ",np.dot(c,z))

A,b,c,z = get_input()
z = move_to_vertex(A,b,z)
vertex_marching(A,b,c,z)
