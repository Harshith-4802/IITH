% Implementation of decimation and interpolation on audio signal

% Input audio signal
[x, r] = audioread('msmn1.wav');
% Plotting Magnitude and Impulse responses of input signal
% soundsc(x, r);
% specgram(x, 1024, r);
l_x = length(x); % Num of samples
Q = 28;
% 1. Decimation and interpolation by factor 2 (M=L=2):
M = 2;
L = 2;

% 2. Decimation and interpolation by factor 4 (M=L=4):
% M = 4;
% L = 4;

% 2. Decimation and interpolation by factor 4 (M=L=8):
% M = 8;
% L = 8;

% Anti aliasing Gain = 1, Anti imaging Gain = L

% Low Pass Filter
f_x = bitshift(x,Q);
h_m = LowPassFilter(M, 1);
h_l = LowPassFilter(L, L);
f_h_m = bitshift(h_m,Q);
f_h_l = bitshift(h_l,Q);
% Length of low pass filter
l_h = length(h_m);

% input signal to Anti-aliasing filter
x_f = conv(x, h_m);
x_f = x_f(floor((l_h-1)/2)+1:floor((l_h-1)/2)+l_x);
f_x_f = convolutionfxd(f_x,f_h_m,Q,l_x+l_h-1);
f_x_f = f_x_f(floor((l_h-1)/2)+1:floor((l_h-1)/2)+l_x);

% Downsampling signal
x_d = downsampling(x_f, M);
f_x_d = downsampling(f_x_f,M);
filename = "msmn1_decimated_"+M+".wav";
audiowrite(filename, f_x_d, floor(r/M));
figure()
specgram(f_x_d/(2^Q), 1024, r/M);

% Upsampling signal
x_u = upsampling(x_d, L);
f_x_u  = upsampling(f_x_d, L);


% upsampled signal to Anti-imaging filter
y = conv(h_l, x_u);
y = y(floor((l_h-1)/2)+1:floor((l_h-1)/2)+l_x);
f_y = convolutionfxd(f_x,f_h_l,Q,l_x+l_h-1);
f_y = f_y(floor((l_h-1)/2)+1:floor((l_h-1)/2)+l_x);
f_y = f_y/(2^Q);
figure()
specgram(f_y, 1024, L*r/M);

filename = "msmn1_final_"+M+".wav";
audiowrite(filename, f_y, L*r/M);

figure()
plot(f_y);
e = error(f_y,y);
figure()
plot(e);

% Function @hamming window

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

function Y = convolutionfxd(X,H,Q,lenY)
    lenX = length(X);
    lenH = length(H);
    Y = zeros(lenY,1);
    for n = 0:lenY-1
        for k = 0:n
            if((n-k)>=lenH || k>=lenX)
                continue;
            end
            Y(n+1) = fxdAddScalar(bitshift(Y(n+1),0),fxdMulScalar(X(k+1),Q,H(n-k+1),Q,Q));
        end
    end
end

function[w] = hamming_window(N)
    w = zeros([1, N]);
    for i = 1:N
        w(i) = 0.54-0.46*cos(2*pi*(i-1)/(N-1));
    end
end

% Function @Low Pass Filter
function[h] = LowPassFilter(M, gain)
    N = 101;
    h = zeros([1,N]);
    w_c = pi/M;
    for i = 1:N
        if i-1==(N-1)/2
            h(i) = gain*w_c/pi;
        else
            h(i) = gain*sin(w_c*(i-1-(N-1)/2))/(pi*(i-1-((N-1)/2)));
        end
    end
    w = hamming_window(N);
    h = w.*h;
end

% Function @ downsampling
function[xd] = downsampling(xf, M)  
    lxf = length(xf);
    lxd = floor((lxf-1)/M) + 1;
    xd = zeros(lxd,1);
    for i = 1:lxd
        n = M*(i-1)+1;
        xd(i) = xf(n);
    end
end

% Function @ upsampling
function[x_u] = upsampling(x_d,L)  
    size = length(x_d);
    x_u = zeros(size,1);
    for i = 1:1:size
        x_u((i-1)*L+1) = x_d(i);
        k = (i-1)*L+1;
        for j = k+1:1:k+L-1
            x_u(j) = 0;
        end
    end
end

function e = error(x,y)
    lx = length(x);
    e = zeros(lx,1);
    sum = 0;
    for i = 1:lx
        e(i) = x(i)-y(i);
        sum = sum + (e(i))^2;
    end
    mse = sqrt(sum/lx);
end