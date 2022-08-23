clc;clear;
L = 1e5;
data = randi([0,1],[1,L]);
ak = zeros(1,L);

for p = 1:L
  if data(p) == 0
    ak(p) = 1;
  elseif data(p) == 1
    ak(p) = -1;
  end
end

Es = 1;
BER = zeros(1,31);
snrdb = -5:0.5:10;
x = zeros(1,L);

for q = 1:31
  var = Es/10^(snrdb(q)/10);
  sig = sqrt(var);
  for p = 1:4
    vk = randn([1,L])*sig;%AWGN
    z = ak + vk;
  end
  
  for p = 1:L
    if z(p) > 0
      x(p) = 0;  
    else
      x(p) = 1;
    end
  end
  BER(q) = ((data-x)*(data-x)')/L;
end

plot(snrdb,BER);
