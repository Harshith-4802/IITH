#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<math.h>
#define _USE_MATH_DEFINES

const int MAXLEN = 10000;

void convolutionflt(float X[MAXLEN], float H[MAXLEN], float Y[MAXLEN], int lenX, int lenH, int lenY){
	for(int n=0;n<lenY;++n){
		Y[n] = 0;
		for(int k=0;k<=n;++k){
			if((n-k)>=lenH||k>=lenX)
				continue;
			Y[n] = Y[n]+(X[k]*H[n-k]);
		}
	}
}

int fxdMulScalar(int num1, int q1, int num2, int q2, int resq){
	long long temp = (long long) num1*num2;
	int res;
	res = temp/(1<<(q1+q2-resq));
	return res;
}


int bitshift(int num,int shift){
    return num*(1<<shift);
}

int fxdAddScalar(int num1,int num2){
    return num1+num2;
}

void convolutionfxd(int X[MAXLEN], int H[MAXLEN], int Y[MAXLEN], int lenX, int lenH, int lenY, int Q){
	for(int n=0;n<lenY;++n){
		Y[n] = 0;
		for(int k=0;k<=n;++k){
			if((n-k)>=lenH||k>=lenX)
				continue;
			Y[n] = fxdAddScalar(bitshift(Y[n],0),fxdMulScalar(X[k],Q,H[n-k],Q,Q));
		}
	}
}


int main(){
	
	float X[MAXLEN] = {};
	float H[MAXLEN] = {};
	float Y[2*MAXLEN-1] = {};
	for(int i=0;i<MAXLEN;i++){
		int n = i-MAXLEN/2+1;
		if(n==0) X[i] = 0.5;
		else{
			X[i] = ((sin(M_PI/7)*n))/(M_PI*n);
		}
	}
	for(int i=0;i<MAXLEN;i++){
		int n = i-MAXLEN/2+1;
		if(n==0) H[i] = 0;
		else{
			H[i] = 3*sin((M_PI/10)*n);
		}
	}
	
	convolutionflt(X,H,Y,MAXLEN,MAXLEN,2*MAXLEN-1);
	
	int F_X[MAXLEN] = {};
	int F_H[MAXLEN] = {};
	int F_Y[2*MAXLEN-1] = {};
	float error[MAXLEN] = {};
	
	printf("Mean square Errors -\n");
	for(int Q = 1;Q<=31;Q++){
		error[Q] = 0;
		for(int i=0;i<MAXLEN;i++)	
			F_X[i] = (int)(X[i]*(1<<Q));
		
		for(int i=0;i<MAXLEN;i++)	
			F_H[i] = (int)(H[i]*(1<<Q));
			
		convolutionfxd(F_X,F_H,F_Y,MAXLEN,MAXLEN,2*MAXLEN-1,Q);
		for(int i=0;i<2*MAXLEN-1;i++){
			float fxd_Y = (float)F_Y[i]/(1<<Q);
			error[Q] += (fxd_Y-Y[i])*(fxd_Y-Y[i]);
		}
		printf("For Q = %d is %0.10f\n",Q,sqrt(error[Q]/(2*MAXLEN-1)));
	}
	
	return 0;
}




