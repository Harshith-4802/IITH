# Assignment 3

import numpy as np

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
	return A,b,c

def tight_rows(A,b,z):
    tight = []	
    untight = []
    for i in range(len(A)):
        if abs(b[i]-(A[i,:]@z))<TINY_VALUE:
            tight.append(i)
        else:
            untight.append(i)
    return tight,untight

def feasible_point(A,b,c):

    if np.all((b >= 0)):
        return np.zeros(c.shape)    

    else:
        for _ in range(50):
            m = A.shape[0]
            n = A.shape[1]
            rand_ind = np.random.choice(m, n)
            A_rand = A[rand_ind]
            b_rand = b[rand_ind]
            try:
                possible_z = np.dot(np.linalg.inv(A_rand), b_rand)

                if (np.all((np.dot(A, possible_z) - b <= 0))):
                    return possible_z
                else:
                    continue
            except:
                pass

def is_degenerate(A, b, c):
    z = feasible_point(A, b, c)

    tight,_ = tight_rows(A,b,z)

    if len(tight) == A.shape[1]:
        return False
    return True

def get_non_degenerate(A,b,c):

    r = A.shape[0]-A.shape[1]

    num_iter = 0
    while True:
        if(num_iter < 1000):
            num_iter += 1
            temp_b = b
            temp_b[:r] = temp_b[:r] + np.random.uniform(1e-6, 1e-5, size=r)
        else:
            temp_b = b
            temp_b[:r] += np.random.uniform(0.1, 10, size=r)

        if not is_degenerate(A, temp_b, c):
            print('Degeneracy removed')
            break
    return temp_b

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
    if len(np.where( A @ v > 0)[0]) == 0:  # Checking if the polytope is bounded
            return "unbounded"

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
        elif v == "unbounded":
            print("Cost is unbounded. Exiting Algorithm")
            return 
        else:
            z = z + v  

    print("Optimal value is obtained at z = ",z)
    print("Optimal Value is c.z = ",np.dot(c,z))

# A,b,c = get_input()
A = np.array([[1, 4],[1, 2],[-1, 0],[0, -1]]).astype(np.float64)
b = np.array([8, 4, 0, 0]).astype(np.float64)
c = np.array([3, 9]).astype(np.float64)
b = get_non_degenerate(A,b,c)
z = feasible_point(A,b,c)
vertex_marching(A,b,c,z)
