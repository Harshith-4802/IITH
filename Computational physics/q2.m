%Q2
f = @(x) 2*x^3;
h = 1;
N_iter = 1;
error = 1;
%for 2 significant digits relative error<0.5%
while(error>=0.5)
   diff1 = (f(2+h)-f(2))/h; 
   h = h/2;
   diff2 = (f(2+h)-f(2))/h;
   error = (abs(diff1-diff2)/diff2)*100;
   N_iter = N_iter+1;
end
N_iter