clear;
clc;
% 此为原Paper中Figure6复现代码

% 状态初值如下
X0  = [-10.2999, 0.2575, -4.4997, 3.6258, 3.0922, 9.0156, 3.5099, -2.6645, 2.4552, -4.4921]';

Node_Nums = 10;

D = [   2 0 0 0 0 0 0 0 0 0;
        0 3 0 0 0 0 0 0 0 0;
        0 0 4 0 0 0 0 0 0 0;
        0 0 0 4 0 0 0 0 0 0;
        0 0 0 0 4 0 0 0 0 0;
        0 0 0 0 0 4 0 0 0 0;
        0 0 0 0 0 0 4 0 0 0;
        0 0 0 0 0 0 0 4 0 0;
        0 0 0 0 0 0 0 0 3 0;
        0 0 0 0 0 0 0 0 0 2;];
A   = [ 0 1 1 0 0 0 0 0 0 0;
        1 0 1 1 0 0 0 0 0 0;
        1 1 0 1 1 0 0 0 0 0;
        0 1 1 0 1 1 0 0 0 0;
        0 0 1 1 0 1 1 0 0 0;
        0 0 0 1 1 0 1 1 0 0;
        0 0 0 0 1 1 0 1 1 0;
        0 0 0 0 0 1 1 0 1 1;
        0 0 0 0 0 0 1 1 0 1;
        0 0 0 0 0 0 0 1 1 0;];
L = D - A;

% 设置收敛相关参数
tBegin = 0;                     % 开始时间 
tEnd   = 15;                    % 结束时间
dt     = 0.01;                   % 最小时间间隔
times  = (tEnd-tBegin) / dt;    % 迭代计算次数
time   = 1;
% 定义记录时间数组
t(:,1)   = tBegin;
% 定义图数据存储数组
X(:,1) = X0;
U(:,1) = -L * X0;
Delta(:,1) = X0' * L * X0;

X2(:,1) = X0;
U2(:,1) = -L * X0;
    
% 开始收敛计算
while(time <= times)
    t(:,time+1) = tBegin + time * dt;
    
%     X(:,time+1) = expm(-L * t(:,time+1)) * X0;
    U(:,time) = -L*X(:,time);
    X(:,time+1) = U(:,time)*dt + X(:,time);

    if time<=13
%         U2(:,time) = -L*X(:,time);
%         X2(:,time+1) = U2(:,time)*dt + X(:,time);
        X2(:,time+1) = expm(-L * t(:,time+1)) * X0;
    else
%         U2(:,time) = -L*X2(:,time);
%         X2(:,time+1) = U2(:,time)*dt + X2(:,time);
        X2(:,time+1) = expm(-L * t(:,time+1-13)) * X0;
    end

    if time<=18
%         U3(:,time) = -L*X(:,time);
%         X3(:,time+1) = U(:,time)*dt + X(:,time);
        X3(:,time+1) = expm(-L * t(:,time+1)) * X0;
    else
%         U3(:,time) = -L*X3(:,time);
%         X3(:,time+1) = U3(:,time)*dt + X3(:,time);
        X3(:,time+1) = expm(-L * t(:,time+1-18)) * X0;
    end
    
    if time<=26
%         X4(:,time+1) = expm(-L * t(:,1)) * X0;
        X4(:,time+1) = expm(-L * t(:,time+1)) * X0;
    else
%         X4(:,time+1) = expm(-L * t(:,time+1-26)) * X0;
        X4(:,time+1) = expm(-L * t(:,time+1-26)) * X0;
    end
    
    time = time + 1;
end

% 绘制图数据
subplot(2,2,1);
plot(t,X(1,:), t,X(2,:), t,X(3,:), t,X(4,:), t,X(5,:), t,X(6,:), t,X(7,:), t,X(8,:), t,X(9,:), t,X(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("state");
title("Time-Delay=0(sec)");

subplot(2,2,2);
plot(t,X2(1,:), t,X2(2,:), t,X2(3,:), t,X2(4,:), t,X2(5,:), t,X2(6,:), t,X2(7,:), t,X2(8,:), t,X2(9,:), t,X2(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("state");
title("Time-Delay=0.13(sec)");

subplot(2,2,3);
plot(t,X3(1,:), t,X3(2,:), t,X3(3,:), t,X3(4,:), t,X3(5,:), t,X3(6,:), t,X3(7,:), t,X3(8,:), t,X3(9,:), t,X3(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("state");
title("Time-Delay=0.13(sec)");

subplot(2,2,4);
plot(t,X4(1,:), t,X4(2,:), t,X4(3,:), t,X4(4,:), t,X4(5,:), t,X4(6,:), t,X4(7,:), t,X4(8,:), t,X4(9,:), t,X4(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("state");
title("Time-Delay=0.13(sec)");