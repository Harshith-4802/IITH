%Q1
n = 0;
x = 1.2;
exact = exp(x);
approx = 0;
while((abs(exact-approx)/exact)>=0.01)
    approx = approx + x^n/factorial(n);
    n=n+1;
end
n