%Implementation of the NLMS for Prediction

clear all
clc
emin = 0.001;
x = dataSS';
%x = dataLS'
sample = 15;
ord = 8;
x1 = x(1:sample);
w = zeros(1,ord);
y = zeros(1,sample);
e = zeros(1,sample);
m = zeros(1,sample);
sum = 0;
for i = (ord+1):1:sample
    for j = 1:1:ord
        sum = sum + w(1,j)*x(1,(i-j));
    end
    y(1,i) = sum;
    sum = 0;
    e(1,i) = x(1,i) - y(1,i);
    xx = 0;
    for j = 1:1:ord
        xy(1,j) = x(1,i-j);
        xx = xy(1,j)^2 + xx;
    end
    m(i) = 1/(emin + xx);
    uek = m(i)*e(1,i);
    for j = 1:1:ord
        w(1,j) = w(1,j) + uek*xy(1,j);
    end
    i
    w'
end
sq =0;
for mm = ord+1:1:sample
    sq = sq +(e(1,mm))^2;
end
mse = sq/(sample-ord)
figure
plot(e)