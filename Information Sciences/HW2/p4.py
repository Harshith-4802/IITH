import networkx as nx
import numpy as np
import matplotlib.pyplot as plt 

#A = np.array([[1, 2, 2, 45], [2, 3, 1, 0], [3, 4, 1, 0], [4, 5, 1, 0], [5, 6, 0.4, -18], [8, 6, 1, 0], [8, 1, 0.5, -60], [1, 4, 2, 45], [4, 7, 1.5, 45], [8, 7, 2, 30], [7, 6, 0.5, -30]])
A = np.array([[1, 2, 4, 30], [2, 3, 1, 180], 
			  [3, 4, 2, 0], [4, 5, 2, -30], [5, 2, 32, 0], 
			  [5, 6, 0.5, 150], [6, 7, 4, -60], [7, 8, 1, 180], 
			  [8, 1, 4, 0], [8, 5, 0.5, 30], [4, 9, 0.5, 90], [6, 9, 4, -30]])
G = nx.Graph()

for i in range(A.shape[0]):
	G.add_edge(A[i, 0], A[i, 1], amplitude=A[i, 2], phase=A[i, 3])

nx.draw(G, with_labels=True)
#plt.show()
def is_it_in(A, s, d):
	bool = False
	for i in range(A.shape[0]):
		if (A[i, 0:2] == [s, d]).all():
			bool = True
	return bool
def loop_check(G, loop):
	phase = 0
	amp = 1
	for j in range(len(loop)):
		if j < len(loop)-1:
			s = loop[j]
			d = loop[j+1]
			#print(s, d)
			if is_it_in(A, s, d):
				phase += G.get_edge_data(s, d)['phase']
				amp *= G.get_edge_data(s, d)['amplitude']
				#print('same direction')
			else:
				phase -= G.get_edge_data(s, d)['phase']
				amp /= G.get_edge_data(s, d)['amplitude']
				#print('opposite direction')
		else: 
			s = loop[j]
			d = loop[0]
			#print(s, d)
			if is_it_in(A, s, d):
				phase += G.get_edge_data(s, d)['phase']
				amp *= G.get_edge_data(s, d)['amplitude']
				#print('same direction')
			else:
				phase -= G.get_edge_data(s, d)['phase']
				amp /= G.get_edge_data(s, d)['amplitude']
				#print('opposite direction')
	print(' Phase:', phase)
	print(' Amplitude', amp, 'or ', 1/amp)
loops = nx.cycle_basis(G)
for idx, loop in enumerate(loops):
	print('Loop '+str(idx+1)+': ', loop)
	loop_check(G, loop)