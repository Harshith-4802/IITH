clc;clear;clear all;
L = 100;
pcm = randi(63,1,L);%100 samples
ps = dec2bin(pcm,6) - '0';%6*100 = 600bits
n = 1;
pam = zeros(1,3*L);%4PAM = 2 bit,1 stwmbol ;300 Symbols

for p = 1:L
    for q = 1:2:5
        if ps(p,q) == 0
            if ps(p,q+1) == 0
                pam(1,n) = -3;
            else
                pam(1,n) = -1;
            end
        else 
            if ps(p,q+1) == 0
                pam(1,n) = 1;
            else
                pam(1,n) = 3;
            end
        end
        n = n + 1;
    end
end

%Transmitter waveform
tw = zeros(1,4*3*L);
k = 1;
for n = 1:4:(12*L)
    temp = pam(1,k);
    tw(1,n) = temp;
    tw(1,n+1) = temp;
    tw(1,n+2) = temp;
    tw(1,n+3) = temp;
    k = k + 1;
end

%Sampling time
Ts = 1/8000;
t = 0:Ts/12:(1199/12)*Ts;
subplot(4,1,1);
plot(t,tw)
title('Transmitted Waveform')

%SNR
Es = (tw*(tw)')*(Ts/12);
%given 
%10*log_10(snr) = 6
%(2*Es)/No = 10^(3/5)
No = (2*Es*10^(-3/5));
var = sqrt(No/2);
y = tw + randn([1 12*L])*var;

subplot(4,1,2);
plot(t,y)
title('Transmitted Waveform with noise')

%Implementing Matched Filter
z = zeros(1,12*L);
m = [1 1 1 1];%match filter
for i = 1:3*L
    z(4*i-3:4*i) = filter(y(4*i-3:4*i),4,m);
end

subplot(4,1,3);
plot(t,z)
title('Matched Filter output')

output = zeros(1,12*L);
x = [-3 -1 1 3];
[minValue,closestIndex] = min(abs(z-x'));
output = x(closestIndex);

subplot(4,1,4);
plot(t,output)
title('Decoded Output')

%recieved output
outputpam = zeros(1,300);
n = 1;
for i = 4:4:1200
        outputpam(1,n) = output(1,i);
        n = n + 1;
end

%Calculating errors

%Symbol Errorrate
Symbolerror = pam-outputpam;
n = 0;
for i=1:300
    if Symbolerror(i)~=0
        n = n+1;
    end
end
Ser = n/300 ;


pstr = (ps)';
%converting PCM matrix into array
bitsequence = zeros(1,6*L); 
for i = 1:6*L  
    bitsequence(1,i) = pstr(i);
end
routbit = zeros(1,6*L); %output bits
for i = 1:3*L
    if outputpam(1,i) == -3
        routbit(1,2*i-1) = 0;
        routbit(1,2*i) = 0;
    elseif outputpam(1,i) == -1
        routbit(1,2*i-1) = 0;
        routbit(1,2*i) = 1;
    elseif outputpam(1,i) == 1
        routbit(1,2*i-1) = 1;
        routbit(1,2*i) = 0;
    else
        routbit(1,2*i-1) =3;
        routbit(1,2*i) = 1;
    end
       
end

%Bit Errorrate
biterror = (bitsequence - routbit)*(bitsequence - routbit)' ;
Ber = biterror/(6*L) ;

outpcm = zeros(1,L);
for i = 1:L
    outpcm(i) = bin2dec(int2str(routbit(6*i-5:6*i)));
end

%PCM error rate
n = 0;
PCMerror = pcm - outpcm;
for i = 1:L
    if PCMerror(i) ~= 0
        n = n + 1;
    end
end
PCMer = n/L ;
