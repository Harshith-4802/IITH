x = input(100,200,300,2400,96);

%M = L = 2
lpf1 = LPF(600,2400,101);
xd1 = decimator(lpf1,x,2);
y1 = interpolator(lpf1,xd1,2);
e1 = error(x,y1);

%M = L = 4
lpf2 = LPF(300,2400,101);
xd2 = decimator(lpf2,x,4);
y2 = interpolator(lpf2,xd2,4);
e2 = error(x,y2);

%M = L = 8
lpf3 = LPF(150,2400,101);
xd3 = decimator(lpf3,x,8);
y3 = interpolator(lpf3,xd3,8);
e3 = error(x,y3);

figure;
stem(x,'filled');
figure;
stem(xd3,'filled') 
figure;
stem(y3,'filled')
figure;
stem(e3,'filled')

function x = input(f0,f1,f2,fs,N)
    x = zeros(N,1);
    for i = 1:N
        n = i - 1;
        x(i) = sin(2*pi*f0*n/fs)+0.5*sin(2*pi*f1*n/fs)+0.6*sin(2*pi*f2*n/fs);
    end
end

function xd = decimator(lpf,x,M)
    lx = length(x);
    lh = length(lpf);
    xf = conv(lpf,x);
    %Discarding first and last (lh−1)/2 samples from xf[n]
    temp_xd = zeros(lx,1);
    for i = 1:lx
        n = (lh-1)/2 + i;
        temp_xd(i) = xf(n);
    end
    xd = downsampler(temp_xd,M);
end
function xd = downsampler(xf,M)
    lxf = length(xf);
    lxd = floor((lxf-1)/M) + 1;
    xd = zeros(lxd,1);
    for i = 1:lxd
        n = M*(i-1)+1;
        xd(i) = xf(n);
    end
end

function y = interpolator(lpf,xd,L)
    xu = upsampler(xd,L);
    lpf = lpf*L;    %Anti imaging Gain = L
    temp_y = conv(xu,lpf);
    lh = length(lpf);
    ly = length(temp_y)-lh+1;
    y = zeros(ly,1);
    %Discarding first and last (lh−1)/2 samples from y[n]
    for i = 1:ly
        n = (lh-1)/2 + i;   
        y(i) = temp_y(n);
    end
end
function xu = upsampler(xd,L)
    lxd = length(xd);
    xu = zeros(lxd*L,1);
    for i = 1:lxd
        n =  L*(i-1)+1;
        xu(n) = xd(i);
    end
end

function e = error(x,y)
    lx = length(x);
    e = zeros(lx,1);
    sum = 0;
    for i = 1:lx
        e(i) = y(i)-x(i);
        sum = sum + abs(e(i));
    end
    average_error = sum/lx
end

function hn = LPF(fc,fs,N)
    wc = 2*pi*fc/fs;
    hn = zeros(N,1);
    hdn = zeros(N,1);
    w = hamming(N);
    for i = 1:N
        n = i-((N+1)/2);
        if(n==0)
            hdn(i) = wc/pi;
        else
            hdn(i) =  sin(wc*n)/(pi*n);
        end
        hn(i) = hdn(i)*w(i); 
    end
end

function w = hamming(N)
    w = zeros(N,1);
    for i = 1:N
        w(i) = 0.54 - 0.46*cos( (2*pi*(i-1)) / (N-1) );
    end
end


