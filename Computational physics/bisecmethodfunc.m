%Q6
f = @(x)(x^3-6*x^2+11*x-6);
[xc,fc,N_iter] = BisecMethod (f,2.5,4,1e-1,1e-1)
function [xc, fc, N_iter] = BisecMethod (f, xa, xb, eps_f, eps_x)
    xc=(xb+xa)/2; 
    fc=f(xc);
    N_iter=1;
    while ( (abs(xc-xb) > eps_x) || (abs (fc) > eps_f) )
        if (fc>0)
            xb=xc; 
        else
            xa=xc; 
        end
        xc=(xb+xa)/2;
        fc=f(xc);
        N_iter =N_iter +1;
    end
end

