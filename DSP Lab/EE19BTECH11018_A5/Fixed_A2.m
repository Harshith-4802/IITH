clc;clear;
x = input(100,200,300,2400,96);

f_y = output(x,2,2,2400,28);
f_y = output(x,4,4,2400,28);
f_y = output(x,8,8,2400,28);

function fxd_y = output(x,M,L,fs,Q)
    fxd_x = bitshift(x,Q);
    lpf_d = LPF(fs/(2*M),fs,101,1);
    fxd_lpf_d = fxd_LPF(fs/(2*M),fs,101,1,Q);
    xd = decimator(lpf_d,x,M);
    fxd_xd = fxd_decimator(fxd_lpf_d,fxd_x,M,Q);

    lpf_i = LPF(fs/(2*L),fs,101,L);
    fxd_lpf_i = fxd_LPF(fs/(2*M),fs,101,L,Q);
    y = interpolator(lpf_i,xd,L);
    fxd_y = fxd_interpolator(fxd_lpf_i,fxd_xd,L,Q);
    fxd_y = fxd_y/(2^Q);
    e = mse_error(fxd_y,y);

    figure("Name","Fixed point output, M = "+M)
    stem(fxd_y,'fill');
    figure("Name","Fixed point error vector, M = "+M)
    stem(e,'fill');
end


function res = fxdMulScalar(num1, q1, num2, q2,resq)
	temp = double(num1)*double(num2);
	res = int32(temp/(2^(q1+q2-resq)));
end


function res = bitshift(num,shift)
    res = int32(num*(2^shift));
end

function res = fxdAddScalar(num1,num2)
    res = int32(num1+num2);
end

function Y = fxd_conv(X,H,Q)
    lenX = length(X);
    lenH = length(H);
    lenY = lenX+lenH-1;
    Y = zeros(lenY,1);
    for n = 0:lenY-1
        for k = 0:n
            if((n-k)>=lenH || k>=lenX)
                continue;
            end
            % Y(n) = Y(n) + X(k)*H(n-k)
            Y(n+1) = fxdAddScalar(bitshift(Y(n+1),0),fxdMulScalar(X(k+1),Q,H(n-k+1),Q,Q));
        end
    end
end

function fxd_xd = fxd_decimator(fxd_lpf,fxd_x,M,Q)
    lx = length(fxd_x);
    lh = length(fxd_lpf);
    fxd_xf = fxd_conv(fxd_x,fxd_lpf,Q);
    %Discarding first and last (lh−1)/2 samples from xf[n]
    fxd_temp_xd = zeros(lx,1);
    for i = 1:lx
        n = (lh-1)/2 + i;
        fxd_temp_xd(i) = fxd_xf(n);
    end
    fxd_xd = downsampler(fxd_temp_xd,M);
end

function fxd_y = fxd_interpolator(fxd_lpf,fxd_xd,L,Q)
    fxd_xu = upsampler(fxd_xd,L);
    fxd_temp_y = fxd_conv(fxd_xu,fxd_lpf,Q);
    lh = length(fxd_lpf);
    ly = length(fxd_temp_y)-lh+1;
    fxd_y = zeros(ly,1);
    %Discarding first and last (lh−1)/2 samples from y[n]
    for i = 1:ly
        n = (lh-1)/2 + i;   
        fxd_y(i) = fxd_temp_y(n);
    end
end

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

function e = mse_error(x,y)
    lx = length(x);
    e = zeros(lx,1);
    sum = 0;
    for i = 1:lx
        e(i) = x(i)-y(i);
        sum = sum + (e(i))^2;
    end
    mean_square_error = sqrt(sum/lx)
end

function fxd_hn = fxd_LPF(fc,fs,N,gain,Q)
    wc = 2*pi*fc/fs;
    fxd_hn = zeros(N,1);
    hdn = zeros(N,1);
    w = hamming(N);
    for i = 1:N
        n = i-((N+1)/2);
        if(n==0)
            hdn(i) = wc/pi;
        else
            hdn(i) =  sin(wc*n)/(pi*n);
        end
        fxd_hn(i) = fxdMulScalar(bitshift(hdn(i),Q),Q,bitshift(gain*w(i),Q),Q,Q);
    end
end

function hn = LPF(fc,fs,N,gain)
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
        hn(i) = gain*hdn(i)*w(i); 
    end
end

function w = hamming(N)
    w = zeros(N,1);
    for i = 1:N
        w(i) = 0.54 - 0.46*cos( (2*pi*(i-1)) / (N-1) );
    end
end
