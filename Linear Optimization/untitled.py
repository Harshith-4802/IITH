# Assignment 1

import numpy as np
from scipy.linalg import null_space

# A = np.array([[-1, -1],[1, 1],[-1, 0],[0, -1]])
# c = np.array([5, 2])
# b = np.array([-1, 2, 0, 0])
# z = np.array([0.5, 0.5])
TINY_VALUE = 1e-7

def get_row():
	splitted = input().split('\t')
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
        tight,untight = tight_rows(A,b,z)

        if(len(tight)>0):
            if(np.linalg.matrix_rank(A[tight,:])==len(z)):
                return z
        
        u = null_space(A[tight,:])[:,0]
        alpha = -1
        tight_index = 0
        for i in range(len(untight)):
            curr_alpha = -1*(A[untight[i],:]@z)/(A[untight[i],:]@u + 1e-50)
            if curr_alpha>=0:
                if alpha<0:
                    alpha = curr_alpha
                if curr_alpha < alpha:
                    alpha = curr_alpha
                    tight_index = i
        z = z+alpha*u

def direction_vector(A,b,c,z):
    tight,untight = tight_rows(A,b,z)
    A_lid = A[tight]
    A_lid_inv = np.linalg.inv(A_lid.T)
    alphas = np.dot(A_lid_inv,c)
    neg_alphas = np.where(alphas < 0)[0]

    if(len(neg_alphas)==0):
        return None
    
    neg_alphas = neg_alphas[0]
    v = -A_lid_inv[neg_alphas]  
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
