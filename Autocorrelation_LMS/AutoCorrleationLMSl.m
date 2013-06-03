clc
clear all
%x = dataLS'; % Large Spread Database
x = dataSS'; % Small Spread Database
format short;
sample = 200;
x1 = x(1:sample);
ord = 8;
w = zeros(1,ord);
y = zeros(1,sample);
e = zeros(1,sample);
sum = 0;

for j = 1:1:ord
    X1(1,j) = x(1,9-j);
end
for j = 1:1:ord
    for jj = 1:1:ord
        XX(j,jj) = X1(1,j)*X1(1,jj);
        if j == jj
            XX(j,jj) = XX(j,jj) +1;
        end
    end
end
R = det(XX);
m = 1/R;

for i = (ord+1):1:sample
    for j = 1:1:ord
        sum = sum + w(1,j)*x(1,(i-j));
    end
    for j = 1:1:ord
        X(1,j) = x(1,i-j);
    end
    x2 = X*X';
    m = m/(1+x2*m);
    y(1,i) = sum;
    sum = 0;
    e(1,i) = x(1,i) - y(1,i);
    uek = 2*m*e(1,i);
    for j = 1:1:ord
        w(1,j) = w(1,j) + uek*x(1,(i-j));
    end
end
plot(e)
sq = 0;
for m1 = ord+1:1:sample
    sq = sq + square(e(1,m1));
    erper1(m1)=((e(m1)/x(m1))*100);
end
mse = sq/(sample-10);
msedata =mse
y1 =y;