# Assignment 2

import numpy as np
from scipy.linalg import null_space

TINY_VALUE = 1e-7

# ~ A = np.array([[-1,-1],[2,-1],[-1,0],[0,-1]])
# ~ c = np.array([2,1])
# ~ b = np.array([10,40,0,0])
# ~ z = np.array([10,0])

# A = np.array([[2, 1],[1, 1],[-1, 0],[0, -1]])
# c = np.array([1, 2])
# b = np.array([8, 5, 0, 0])
# z = np.array([4, 0])

A = np.array([[-1, -1],[-1, 0],[0, -1]]).astype(np.float64)
b = np.array([-4, -1, -1]).astype(np.float64)
c = np.array([-5, -2]).astype(np.float64)
z = np.array([2, 2]).astype(np.float64)


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

# ~ def move_to_vertex(A,b,z):
    # ~ while(True):
        # ~ tight,untight = tight_rows(A,b,z)

        # ~ if(len(tight)>0):
            # ~ if(np.linalg.matrix_rank(A[tight,:])==len(z)):
                # ~ return z
        
        # ~ u = null_space(A[tight,:])[:,0]
        # ~ alpha = -1
        # ~ tight_index = 0
        # ~ for i in range(len(untight)):
            # ~ curr_alpha = -1*(A[untight[i],:]@z)/(A[untight[i],:]@u + 1e-50)
            # ~ if curr_alpha>=0:
                # ~ if alpha<0:
                    # ~ alpha = curr_alpha
                # ~ if curr_alpha < alpha:
                    # ~ alpha = curr_alpha
                    # ~ tight_index = i
        # ~ z = z+alpha*u

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
    A_lid = A[tight]
    A_lid_inv = np.linalg.inv(A_lid.T)
    alphas = np.dot(A_lid_inv,c)
    neg_alphas = np.where(alphas < 0)[0]

    if(len(neg_alphas)==0):
        return None
    
    neg_alphas = neg_alphas[0]
    v = -A_lid_inv[neg_alphas]  
    if len(np.where( A @ v > 0)[0]) == 0:  # Checking the boundedness of polytope
            return "unbounded"

    A_s = A[untight]
    b_s = b[untight]
    t = (b_s - A_s @ z) / (A_s @ v + 1e-50)
    t = t[t >= 0]
    # if len(t) == 0:
    #     return "unbounded"
    min_t = np.min(t)
    return min_t * v
	
def vertex_marching(A,b,c,z):
    while True:
        v = direction_vector(A,b,c,z) 
        if v is None:   
            break
        elif v == "unbounded":
            print("Cost is unbounded. Exiting Algorithm")
            return 
        else:
            z = z + v  

    print("Optimal value is obtained at z = ",z)
    print("Optimal Value is c.z = ",np.dot(c,z))
    
# ~ A,b,c,z = get_input()
z = move_to_vertex(A,b,z)
vertex_marching(A,b,c,z)
