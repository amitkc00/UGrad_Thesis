%  Implementation of the Basic Error Performance Surface for LMS: 10:01:07
clc
clear all;
%x = dataWGN';umax = 20e-5;umin = 2e-6;
%x = dataLSe';umax = .2e-5;umin = 2e-7;%umin = .0235 , MSE min. = .009066
x = dataSS';umax = .03;umin = .02;%umin = .0235 , MSE min. = .009066
%x = dataLS';umax = 20e-8;umin = 2e-8;%uOpt=1.07e-7 , MSE min. = 3703
sample = 200;
% Imp. Conclusion  - No of samples does not matter in finding the optimum u. It only
% gets fine tunned, but min. mse decreases as the no. of iterations increases
ord = 8;
z = 1;
m = 0;
step = 0;
format short;
nos = 300;
step =(umax-umin)/nos ;
for  k = 1:1:nos
    w = zeros(1,ord);
    y = zeros(1,sample);
    e = zeros(1,sample);
    sq = 0;
    sum =0;
    if k == 1
        m1(1,k) = umin;
    else
        m1(1,k) = m1(1,k-1) + step;
    end
    for i = (ord+1):1:sample
        for j = 1:1:ord
            sum = sum + w(1,j)*x(1,(i-j));
        end
        y(1,i) = sum;
        sum = 0;
        e(1,i) = x(1,i) - y(1,i);
        sq = sq + (e(1,i)^2);
        uek = 2*m1(1,k)*e(1,i);
        for j =1:1:ord
            w(1,j) = w(1,j) + uek*x(1,(i-(j-1)));
        end
    end
    mse(1,z) = sq/(sample-ord);
    z = z+1;
end
plot(m1,mse);
grid on