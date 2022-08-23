%Q9
y0 = 2;
x0 = 0.2;
h = 0.2;
xn = 0.8;
f = @(x,y) ((sin(x)-5*y)/3); 
[x,y] = Euler(f,x0,y0,h,xn)
function [x, y] = Euler (f,x0, y0, h, xn)
    x = (x0:h:xn)';
    y = zeros(size(x));
    y(1) = y0;
    for i=1:1: length(x) - 1
        y(i+1)= y(i) + h * f(x(i),y(i));
    end
end