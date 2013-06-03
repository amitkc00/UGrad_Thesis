clc
clear
sample = 200;
x = dataSS';
ord = 8;
w = zeros(1,ord);
y = zeros(1,sample);
e = zeros(1,sample);
uek = zeros(1,sample);
sum = 0;
m(1,10) = .00095;
%m(1,10) = 0.023602;
for i = 11:1:sample
    for j = 1:1:ord
        if ((i-j)<0)
            x(1,(i-j)) = 0;
        end
        sum = sum + w(1,j)*x(1,(i-j));
    end
        y(1,i) = sum;
        sum = 0;
        e(1,i) = x(1,i) - y(1,i);
        m(1,i) = m(1,i-1)/(1+x(1,i)^2*m(1,i-1));
        uek(1,i) = 2*m(1,i)*e(1,i);
        for j = 1:1:ord
            if((i-j)<0)
                x(1,(i-j)) = 0;
            end
            w(1,j) = w(1,j) + uek(1,i)*x(1,(i-j));
        end
end
sq = 0;
for m = 11:1:sample
    sq = sq + square(e(1,m));
    erper1(m)=((e(m)/x(m))*100);
end
mse = sq/(sample-ord);
title ('System Identfication of an FIR Filter');
subplot(2,2,1);
plot(1:sample,y);
axis([0 sample -2 2]);
%legend('Output');
xlabel('Time index');
ylabel('Output Signal');
subplot(2,2,2);
plot(x);
axis([0 sample 1.60 1.64]);
%legend('Desired');
xlabel('Time index');
ylabel('Desired Signal');
subplot(2,2,3);
plot(1:sample,e);
axis([0 sample -2 2]);
%legend('Error');
xlabel('Time index');
ylabel('Error Percentage')
subplot(2,2,4);
stem(w)
axis([1 10 0 .2]);
xlabel('Coefficient #');
ylabel('Coefficient value');
grid on 
sq = 0;



