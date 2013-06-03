%Study of Effect of u on the Error Performance based on the size of u ( Large or Small)
clc
clear all
x = dataSS';
sample = 200;
ord = 8;
w = zeros(1,ord);
y = zeros(1,sample);
e = zeros(1,sample);
sum = 0;
%m = .0009;  % Small Step Size Parameter
m = .023602; % Lage Step Size Parameter
%No nitial training :5/1/07

for i = (ord+1):1:sample
    for j = 1:1:ord
        sum = sum + w(1,j)*x(1,(i-j));
    end
        y(1,i) = sum;
        sum = 0;
        e(1,i) = x(1,i) - y(1,i);
        uek = 2*m*e(1,i);
        for j = 1:1:ord
            w(1,j) = w(1,j) + uek*x(1,(i-(j-1)));
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