lc;clear;clear all;
r = randi(63,1,100);
PCM = dec2bin(r)-'0';
PCMtranspose = (PCM)' ;
originalbitsequence = zeros(1,600);
Symboltranspose = zeros(3,100);
Symbol = zeros(1,300);
Fs = 8000;
Ts = 1/Fs ;
t = 0:Ts/12:(1199/12)*Ts ;
for i = 0:2
    for j = 1:100
       if PCMtranspose(2*i+1,j)==0 && PCMtranspose(2*i+2,j)==0
           Symboltranspose(i+1,j) = -1 ;
       elseif PCMtranspose(2*i+1,j)==0 && PCMtranspose(2*i+2,j)==1
           Symboltranspose(i+1,j) = 1 ;
       elseif PCMtranspose(2*i+1,j)==1 && PCMtranspose(2*i+2,j)==0
           Symboltranspose(i+1,j) = -3 ;
       else
           Symboltranspose(i+1,j) = 3;
       end  
    end
end

for i = 1:300
    Symbol(1,i) = Symboltranspose(i);
end

symbolsampled = repelem(Symbol,4);
Energysymbol = symbolsampled*symbolsampled'*(Ts/12) ;
No = 2*Energysymbol/10^(6/10);
y = symbolsampled + randn(1,1200)*sqrt(No/2);

%subplot(2,1,1);
%plot(t,u)
%subplot(2,1,2);
%plot(t,y)

M = symbolsampled(end:-1:1);
Z = filter(M,1,y);
output = zeros(1,1200);
for i = 1:1200
    if abs(-1-Z(i)) < abs(1-Z(i)) && abs(-1-Z(i)) < abs(3-Z(i)) && abs(-1-Z(i)) < abs(-3-Z(i))
        output(1,i) = -1 ;
    elseif abs(1-Z(i)) < abs(-1-Z(i)) && abs(1-Z(i)) < abs(3-Z(i)) && abs(1-Z(i)) < abs(-3-Z(i))
        output(1,i) = 1;
    elseif abs(3-Z(i)) < abs(-1-Z(i)) && abs(3-Z(i)) < abs(1-Z(i)) && abs(3-Z(i)) < abs(-3-Z(i))
        output(1,i) = 3;
    else
        output(1,i) = -3;
    end
end

compoutput = zeros(1,300);
j = 1;
k = 0;
for i = 4:4:1200
        compoutput(1,j) = output(1,i);
        j = j + 1;
end
time = 0:Ts/3:(1199/12)*Ts ;
error = Symbol-compoutput ;
for i=1:300
    if error(i)~=0
        k = k+1;
    end
end
symbolerrorrate = k/300 ;

subplot(2,1,1);
plot(time,Symbol)
subplot(2,1,2);
plot(time,compoutput)