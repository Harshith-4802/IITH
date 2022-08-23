import math

px = []

#p(x)
px.append(0.152056483000583)
px.append(0.310198790469654)
px.append(0.537744726529763)
# px.append(1/2)
# px.append(1/2)
# px.append(0)

pygx = []

pygx.append(0.466943167150955)
pygx.append(0.270498597736653)
pygx.append(0.262558235112392)
pygx.append(0.340821708203059)
pygx.append(0.054047868976964)
pygx.append(0.605130422819977)
pygx.append(0.192235124645986)
pygx.append(0.675453533286383)
pygx.append(0.132311342067631)
###########################################################################
pxy = []
pxy.append(pygx[0]*px[0])
pxy.append(pygx[1]*px[1])
pxy.append(pygx[2]*px[2])
pxy.append(pygx[3]*px[0])
pxy.append(pygx[4]*px[1])
pxy.append(pygx[5]*px[2])
pxy.append(pygx[6]*px[0])
pxy.append(pygx[7]*px[1])
pxy.append(pygx[8]*px[2])



py0 = pygx[0]*px[0]+pygx[1]*px[1]+pygx[2]*px[2]
py1 = pygx[3]*px[0]+pygx[4]*px[1]+pygx[5]*px[2]
py2 = pygx[6]*px[0]+pygx[7]*px[1]+pygx[8]*px[2]
py = []
py.append(py0)
py.append(py1)
py.append(py2)


def H(p,q):	
	h = 0
	for i in range(len(p)):
		if(p[i]!=0 and q[i]!=0):
			h -= p[i]*math.log(q[i],2)
	return h

HX = H(px,px)
HY = H(py,py)
HYgX = H(pxy,pygx)
HXY = HX + HYgX
HXgY = HXY - HY
IXY = HX - HXgY
print("H(X) = " + str(HX))
print("H(Y) = " + str(HY))
print("H(Y/X) = " + str(HYgX))
print("H(X,Y) = " + str(HXY))
print("H(X/Y) = " + str(HXgY))
print("I(X;Y) = "+str(IXY))

