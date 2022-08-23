clc;clear;

L = 100000;
data = randi([0,1],[1,L]);
ak = zeros(4,L/2);

for i = 1:L/2
  if data(2*i-1:2*i) == [0 0]
    ak(:,i) = [1;0;0;0];
  elseif data(2*i-1:2*i) == [0 1]
    ak(:,i) = [0;1;0;0];
  elseif data(2*i-1:2*i) == [1 1]
    ak(:,i) = [0;0;1;0];
  else
    ak(:,i) = [0;0;0;1];
  end
end

Es = 0.25;
BER = zeros(1,16);
SNR_ar = (-5:10);
Q = zeros(1,16);
outbin = zeros(1,L);

for j = 1:16
  SNR = 10^(SNR_ar(j)/10);
  var = Es/SNR;
  sig = sqrt(var);
  Q(j) = 1.5*0.5*erfc(sqrt(SNR/4));
  
  for i = 1:4
    z(i,:) = ak(i,:) + sig*randn([1,L/2]);
  end
  
  for i = 1:L/2
    [m, index] = max(z(:,i));
    if index == 1
      outbin(2*i-1:2*i) = [0 0];
    elseif index == 2
      outbin(2*i-1:2*i) = [0 1];
    elseif index == 3
      outbin(2*i-1:2*i) = [1 1];
    else
      outbin(2*i-1:2*i) = [1 0];
    end
  end
  
  BER(j) = (data-outbin)*(data-outbin)'/L;
end

plot(SNR_ar,BER);
hold on
plot(SNR_ar,Q);