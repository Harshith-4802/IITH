import math

px = [0.18856824122916885, 0.43099776899690856, 0.38043398977392257]

pygx = []

pygx.append(0.2660881484608951)
pygx.append(0.7325093198152685)
pygx.append(0.3022785415855426)
pygx.append(0.0031082292346422)
pygx.append(0.23575786472530666)
pygx.append(0.04618600931728754)
pygx.append(0.7308036223044626)
pygx.append(0.031732815459424885)
pygx.append(0.6515354490971698)
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

