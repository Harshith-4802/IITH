N = 39;   %Number of taps
n = linspace(-(N-1)/2,(N-1)/2,N);
lpf1 = LPF(400,4000,N,n);
lpf2 = LPF(400,4000,N,n);
fvtool(lpf1,1);
fvtool(lpf2,1);

function hn = LPF(fc,fs,N,n)
    wc = 2*pi*fc/fs;
    hn = zeros(N,1);
    hdn = zeros(N,1);
    w = hamming(N);
    for i = 1:N
        x = n(i);
        %x = i-((N+1)/2);
        if(x==0)
            hdn(i) = wc/pi;
        else
            hdn(i) =  sin(wc*x)/(pi*x);
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

