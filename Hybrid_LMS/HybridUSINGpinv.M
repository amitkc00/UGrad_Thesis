clc
clear
format short e;
%x1 = dataLS'; % Large Spread Database
x1 = dataSS';  % Small Spread Database
sample = 200;
x = x1(1:sample);

ord = 8;
w =  zeros(1,ord-2);
w0 = zeros(1,ord-2);
w1 = zeros(1,ord-2);
w2a = zeros(1,ord-2);
w2b = zeros(1,ord-2);
y = zeros(1,sample);
e = zeros(1,sample);
uek1 = zeros(1,sample);
uek2 = zeros(1,sample);
m0 = zeros(1,sample);
sum = 0;

for i = (ord+1):1:sample

    % wo = r(6)*x(6)vector
    for j = 1:1:ord-2
        X1(1,j) = x(1,i-2-j);
    end
    X1inv = pinv(X1);
    X1binv = X1inv';

    for j = 1:1:ord-2
        w0(1,j) = x(1,i-2)*X1binv(1,j);
    end

    % w1 = r(7)*x(7)vector
    for j = 1:1:ord-2
        X2(1,j) = x(1,i-1-j);
    end
    X2inv = pinv(X2);
    X2binv = X2inv';

    for j = 1:1:ord-2
        w1(1,j) = x(1,i-1)*X2binv(1,j);
    end

    sum = 0;
    for j = 1:1:ord-2
        sum = sum + w0(1,j)*x(1,(i-j-2));
    end
    y0(1,i-2) = sum;%y0(1,i) = x(7)
    sum = 0;
    e0(1,i) = x(1,i-2) - y0(1,i-2); 

    % getting m0
    for j = 1:1:ord-2
        ex(1,j) = e0(1,i)*x(1,(i-2-j));
    end
    EXinv = pinv(ex);
    EXbinv = EXinv';

    w01 = (w0-w1);
    EXbinv;
    %m0(1,i) = w01*EXbinv';
    m0(1,i) = w01*EXbinv'*10e-8;

    %e1 = w1*x(7) -r(7)
    sum = 0;
    for j = 1:1:ord-2
        sum = sum + w1(1,j)*x(1,(i-j-1));
    end
    
    %y1(1,i) = x(8)
    y1(1,i-1) = sum;
    sum = 0;
    e1(1,i) = x(1,i-1) - y1(1,i-1);

    %Final uek is obtained
    uek1(1,i) = m0(1,i)*e1(1,i);

    % Finding semi-final coeffiecients for Prediction w
    for j = 1:1:ord-2
        w2a(1,j) = w1(1,j) + uek1(1,i)*x(1,(i-j-1)) ;
    end

    sum = 0;
    for j = 1:1:ord-2
        sum = sum + w2a(1,j)*x(1,(i-j-1));
    end
    y2a(1,i) = sum ;
    sum = 0;

    e2(1,i) = (x(1,i-1) - y2a(1,i));
    % e2(1,i) = (x(1,i-1) - y2a(1,i))*10e-13;
    %mse =  3.988933236877022e-006 after adjustment in e2

    uek2(1,i) = 2*m0(1,i)*e2(1,i);
    %  uek2(1,i) = 2*m0(1,i)*e2(1,i)*10e-13;
    %mse = 3.988933236877022e-006 after adjustment in uek2

    for j = 1:1:ord-2
        w2b(1,j) = w1(1,j) + uek2(1,i)*x(1,(i-j-1));
    end
    %ii = i
    for j = 1:1:ord-2
        [w1(1,j) w2b(1,j)];
    end
    %display('next');
    w = w2b;

    % Now we do the prediction for 9th data point.
    sum = 0;
    for j = 1:1:ord-2
        sum = sum + w(1,j)*x(1,(i-j));
    end
    y(1,i) = sum;
    sum = 0;
    e(1,i) = x(1,i) - y(1,i);


end
sq =0;
for m = ord+1:1:sample
    sq = sq +(e(1,m))^2;
end
mse = sq/(sample-ord)
plot(e)