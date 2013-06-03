sample = 200;
x1 = dataSS';
x = x1(1:sample);

ord = 8;
w = zeros(1,ord);
w1 = zeros(1,ord);
y = zeros(1,sample);
e = zeros(1,sample);
ep = zeros(1,sample);
ee = zeros(1,sample);
y1 = zeros(1,sample);
ef = zeros(1,sample);
sum = 0;
m = .00095;
for i = 11:1:sample
    for j = 1:1:ord
        sum = sum + w(1,j)*x(1,(i-j));
    end
    y(1,i) = sum;
    sum = 0;
    e(1,i) = x(1,i) - y(1,i);%First stage error
    uek = 2*m*e(1,i);
    for j = 1:1:ord
       w(1,j) = w(1,j) + uek*x(1,(i-j));
    end
    for k = 1:1:ord
        sum = sum + w1(1,k)*e(1,(i-k));
    end
    ep(1,i) = sum;%second stage output
    y1(1,i) = y(1,i)+ep(1,i);%Final output of the entire system
    ef(1,i) = x(1,i)-y1(1,i);
    sum = 0;
    ee(1,i) = e(1,i) - ep(1,i);
    uek = 2*m*ee(1,i);
    for k = 1:1:ord
        if((i-k)<0)
            e(1,(i-k)) = 0;
        end
        w1(1,k) = w1(1,k) + uek*e(1,(i-k));
    end

end
sq =0;
for m = 11:1:sample
    sq = sq + square(ef(1,m));
    erper2(m)=((ef(m)/x(m))*100);
end
mse = sq/(sample-10);
plot(ef);%Final Prediction Error
