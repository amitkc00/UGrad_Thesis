% h(n) = h(n-1) + m(h(n-1)*x(n-1) - d(n-1))*x(n-1) -- Eq - (1)
% h(n) = h(n-1) + m(h(n)*x(n-1)   - d(n-1))*x(n-1) -- Eq - (2)

% Putting Eq(1) in equation (2) We get
% h(n) = h(n-1) + m[{h(n-1) + m(h(n-1)*x(n-1) - d(n-1))*x(n-1)}*x(n-1)   - d(n-1)]*x(n-1)

clc
clear all
format short e;
% Welcome to Part 1.
x = dataSS';
%x = dataLS';
sample = 200;
x1 = x(1:sample);
ord = 8;
w = zeros(1,ord);
y1 = zeros(1,sample);
e1 = zeros(1,sample);
y2 = zeros(1,sample);
e2 = zeros(1,sample);
sum = 0;
m1 = .023602; % For Small Spread
m2 = .023602; % For Small Spread
%m1 = 10e-8;  % For Large Spread
%m2 = 10e-8;  % For Large Spread
for i = (ord+1):1:sample
    % Equation (1) Implementation
    for j = 1:1:ord
        sum = sum + w(1,j)*x(1,(i-j));
    end
    y1(1,i) = sum;%y(1,(i-1)) is not applicable as per the FIR
    % Filter Equation.
    sum = 0;
    e1(1,i) = x(1,i) - y1(1,i);
    uek1 = 2*m1*e1(1,i);
    for j = 1:1:ord
        w(1,j) = w(1,j) + uek1*x(1,(i-j));
    end

    % Equation (2) Implementation
    for j = 1:1:ord
        sum = sum + w(1,j)*x(1,(i-j));
    end
    y2(1,i) = sum;%y(1,(i-1)) is not applicable as per the FIR
    % Filter Equation.
    sum = 0;
    e2(1,i) = x(1,i) - y2(1,i);
    uek2 = 2*m2*e2(1,i);
    for j = 1:1:ord
        w(1,j) = w(1,j) + uek2*x(1,(i-j));
    end
end
sq = 0;
for m = (ord+1):1:sample
    sq = sq + (e1(1,m))^2;
    erper1(m)=((e1(m)/x(m))*100);
end
mse1 = sq/(sample-ord);
mseSSDB1 =mse1 % mseSSDB = mean square error for the small spread data base.
ySSDB1 =y1;
eSSDB1 =e1;
erperSSDB1 =erper1; % error percentage for small spread database
sq =0;
for m = (ord+1):1:sample
    sq = sq + square(e2(1,m));
    erper2(m)=((e2(m)/x(m))*100);
end
mse2 = sq/(sample-ord);
mseSSDB2 =mse2; % mseSSDB = mean square error for the small spread data base.
ySSDB2 =y2;
eSSDB2 =e2;
erperSSDB2 =erper2; % error percentage for small spread database
plot(e2);


