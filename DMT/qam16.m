clc;clear;
L = 1e5;
data = randi([0,1],[1,L]);
ak = zeros(2,L/4);

for p = 1:L/4
    
    if data(4*p-1:4*p) == [0,0]
    a = 1;
  elseif data(4*p-1:4*p) == [0,1]
    a = 2;
  elseif data(4*p-1:4*p) == [1,1]
    a = 3;
  else
    a = 4;
    end
  
  if data(4*p-3:4*p-2) == [0,0]
    b = 4;
  elseif data(4*p-3:4*p-2) == [1,0]
    b = 3;
  elseif data(4*p-3:4*p-2) == [1,1]
    b = 2;
  else
    b = 1;
  end
  
 
  ak(:,p) = [2*a-1-4,2*b-1-4];
end

Es = 1;
BER = zeros(1,31);
snrdb = -5:0.5:10;
x = zeros(1,L);

for q = 1:31
  var = Es/10^(snrdb(q)/10);
  sig = sqrt(var);
  for p = 1:2
    vk = randn([1,L/4])*sig;%AWGN
    z(p,:) = ak(p,:) + vk;
  end
  
  for p = 1:L/4
    if z(1,p) <= -2
      x(4*p-1:4*p) = [0,0];
    elseif z(1,p) > -2 && z(1,p) <= 0
      x(4*p-1:4*p) = [0,1];
    elseif z(1,p) > 0 && z(1,p) <= 2
      x(4*p-1:4*p) = [1,1];
    else
      x(4*p-1:4*p) = [1,0];
    end
    
    if z(2,p) <= -2
      x(4*p-3:4*p-2) = [0,1];
    elseif z(1,p) <= 0 && z(2,p) > -2
      x(4*p-3:4*p-2) = [1,1];
    elseif z(1,p) <= 2 && z(2,p) > 0
      x(4*p-3:4*p-2) = [1,0];
    else
      x(4*p-3:4*p-2) = [0,0];
    end
  end
  
  BER(q) = (data-x)*(data-x)'/L;
end

plot(snrdb,BER);