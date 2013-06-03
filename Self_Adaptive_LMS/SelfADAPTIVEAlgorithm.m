format short e;
clc
clear all;
sample = 200;
x = dataSS';

ord = 8;
x1 = x(1:200);
w = zeros(1,ord);
y = zeros(1,sample);
e = zeros(1,sample);
sum = 0;
m = zeros(1,sample);
uek = zeros(1,sample);

uinit = 0.023602;

s = 0.001;
for i = ord+1:1:sample
    for j = 1:1:ord
        sum = sum + w(1,j)*x(1,(i-j));
    end
    y(1,i) = sum;
    sum = 0;
    e(1,i) = x(1,i) - y(1,i);
    m(1,i) = 1/[x(1,i)^2+s]*uinit;
    uek(1,i) = 2*m(i)*e(1,i);
    for j = 1:1:ord
        w(1,j) = w(1,j) + uek(1,i)*x(1,(i-j+1));

    end
end
plot(e);
sq = 0;
for m1 = ord+1:1:sample
    sq = sq + (e(1,m1))^2;
    erper1(m1)=((e(m1)/x(m1))*100);
end
mse = sq/(sample-ord)
msedata = mse;