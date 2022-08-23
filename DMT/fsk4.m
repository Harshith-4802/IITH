clc;clear;
L = 1e5;
data = randi([0,1],[1,L]);
ak = zeros(4,L/2);

for p = 1:L/2
  if data(2*p-1:2*p) == [0,0]
    ak(:,p) = [1,0,0,0];
  elseif data(2*p-1:2*p) == [0,1]
    ak(:,p) = [0,1,0,0];
  elseif data(2*p-1:2*p) == [1,1]
    ak(:,p) = [0,0,1,0];
  else
    ak(:,p) = [0,0,0,1];
  end
end

Es = 0.25;
BER = zeros(1,31);
snrdb = (-5:0.5:10);
x = zeros(1,L);

for q = 1:31
  var = Es/10^(snrdb(q)/10);
  sig = sqrt(var);
  for p = 1:4
    vk = randn([1,L/2])*sig;%AWGN
    z(p,:) = ak(p,:) + vk;
  end
  
  for p = 1:L/2
    [m,index] = max(z(:,p));
    if index == 1
      x(2*p-1:2*p) = [0,0];
    elseif index == 2
      x(2*p-1:2*p) = [0,1];
    elseif index == 3
      x(2*p-1:2*p) = [1,1];
    else
      x(2*p-1:2*p) = [1,0];
    end
  end
  BER(q) = ((data-x)*(data-x)')/L;
end

plot(snrdb,BER);
