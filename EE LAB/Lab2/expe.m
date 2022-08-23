clc;clear;clear all;
L = 1e5;
data = randi(2,[1,L])-1;
fsk = zeros(1,4*L);

n = 1;
for p = 1:2:(L-1)
    if data(1,p) == 0
            if data(1,p+1) == 0
                fsk(1,n) = 1;
                fsk(1,n+1) = 0;
                fsk(1,n+2) = 0;
                fsk(1,n+3) = 0;
            else
                fsk(1,n) = 0;
                fsk(1,n+1) = 1;
                fsk(1,n+2) = 0;
                fsk(1,n+3) = 0;
            end
        else 
            if data(1,p+1) == 0
                fsk(1,n) = 0;
                fsk(1,n+1) = 0;
                fsk(1,n+2) = 1;
                fsk(1,n+3) = 0;
            else
                fsk(1,n) = 0;
                fsk(1,n+1) = 0;
                fsk(1,n+2) = 0;
                fsk(1,n+3) = 1;
            end
    end
    n = n+4;
end

%given 
%10*log_10(snr) = snrdb
%snr = 10^(snrdb/10)= (2*Es)/No
snrdb = -5:0.5:10;
Es = 0.25;
z = zeros(31,L);
n = 1;
BER = zeros(1,31);
for i = 1:31
    for j = 1:2:L-1
        No = (2*Es*10^(-snrdb(i)/10));
        sig = sqrt(No/2);
        y = zeros(31,4*L);
        for i = 1:31
            y = fsk + randn([i,4*L])*sig;
        end
        
        if y(i,j)>y(i,j+1) && y(i,j)>y(i,j+2) && y(i,j)>y(i,j+3)
             z(i,j) = 0;
             z(i,j+1) = 0;
        elseif y(i,j+1)>y(i,j) && y(i,j+1)>y(i,j+2) && y(i,j+1)>y(i,j+3)
             z(i,j) = 0;
             z(i,j+1) = 1;
        elseif y(i,j+2)>y(i,j) && y(i,j+2)>y(i,j+1) && y(i,j+2)>y(i,j+3)
             z(i,j) = 1;
             z(i,j+1) = 0;
        elseif y(i,j+3)>y(i,j) && y(i,j+3)>y(i,j+1) && y(i,j+3)>y(i,j+2)
             z(i,j) = 1;
             z(i,j+1) = 1;
        end
        BER(1,i) = ((z(i,j)-data(1,j))*(z(i,j)-data(1,j))')/L;
    end
end


plot(snrdb,BER);
