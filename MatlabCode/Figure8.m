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
X1(:,1) = X0;
U1(:,1) = -L * X0;
Delta(:,1) = X0' * L * X0;

X2(:,1) = X0;
U2(:,1) = -L * X0;

X3(:,1) = X0;
U3(:,1) = -L * X0;

X4(:,1) = X0;
U4(:,1) = -L * X0;

X5(:,1) = X0;
U5(:,1) = -L * X0;

X6(:,1) = X0;
U6(:,1) = -L * X0;

% 开始收敛计算
while(time <= times)
    t(:,time+1) = tBegin + time * dt;
    
    U1(:,time) = -L*X1(:,time);
    X1(:,time+1) = U1(:,time)*dt + X1(:,time);
%     X(:,time+1) = expm(-L * t(:,time+1)) * X0;


    if time<=13
%         U2(:,time) = -L*X2(:,time);
%         X2(:,time+1) = U2(:,time)*dt + X2(:,time);
        X2(:,time+1) = -L*X2(:,time) * dt + X2(:,time);
%         X2(:,time+1) = expm(-L * t(:,time+1)) * X0;
    else
%         U2(:,time) = -L*X2(:,time-13);
%         X2(:,time+1) = U2(:,time)*dt + X2(:,time-13);
        X2(:,time+1) = -L*X2(:,time-13) * dt + X2(:,time);
%         X2(:,time+1) = expm(-L * t(:,time+1-13)) * X0;
    end

    if time<=18
%         U3(:,time) = -L*X3(:,time);
%         X3(:,time+1) = U3(:,time)*dt + X3(:,time);
        X3(:,time+1) = -L*X3(:,time) * dt + X3(:,time);
%         X3(:,time+1) = expm(-L * t(:,time+1)) * X0;
    else
%         U3(:,time) = -L*X3(:,time-18);
%         X3(:,time+1) = U3(:,time)*dt + X3(:,time-18);
        X3(:,time+1) = -L*X3(:,time-13) * dt + X3(:,time);
%         X3(:,time+1) = expm(-L * t(:,time+1-18)) * X0;
    end
    
    if time<=26
%         U4(:,time) = -L*X4(:,time);
%         X4(:,time+1) = U4(:,time)*dt + X4(:,time);
        X4(:,time+1) = -L*X4(:,time) * dt + X4(:,time);
%         X4(:,time+1) = expm(-L * t(:,time+1)) * X0;
    else
%         U4(:,time) = -L*X4(:,time-26);
%         X4(:,time+1) = U4(:,time)*dt + X4(:,time-26);
        X4(:,time+1) = -L*X4(:,time-26) * dt + X4(:,time);
%         X4(:,time+1) = expm(-L * t(:,time+1-26)) * X0;
    end
    
    if time<=25
        X5(:,time+1) = -L*X5(:,time) * dt + X5(:,time);
    else
        X5(:,time+1) = -L*X5(:,time-25) * dt + X5(:,time);
    end

    if time<=28
        X6(:,time+1) = -L*X6(:,time) * dt + X6(:,time);
    else
        X6(:,time+1) = -L*X6(:,time-28) * dt + X6(:,time);
    end
    
    time = time + 1;
end

% 绘制图数据
subplot(3,2,1);
plot(t,X1(1,:), t,X1(2,:), t,X1(3,:), t,X1(4,:), t,X1(5,:), t,X1(6,:), t,X1(7,:), t,X1(8,:), t,X1(9,:), t,X1(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("state");
title("Time-Delay=0(sec)");

subplot(3,2,2);
plot(t,X2(1,:), t,X2(2,:), t,X2(3,:), t,X2(4,:), t,X2(5,:), t,X2(6,:), t,X2(7,:), t,X2(8,:), t,X2(9,:), t,X2(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("state");
title("Time-Delay=0.13(sec)");

subplot(3,2,3);
plot(t,X3(1,:), t,X3(2,:), t,X3(3,:), t,X3(4,:), t,X3(5,:), t,X3(6,:), t,X3(7,:), t,X3(8,:), t,X3(9,:), t,X3(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("state");
title("Time-Delay=0.18(sec)");

subplot(3,2,4);
plot(t,X4(1,:), t,X4(2,:), t,X4(3,:), t,X4(4,:), t,X4(5,:), t,X4(6,:), t,X4(7,:), t,X4(8,:), t,X4(9,:), t,X4(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("state");
title("Time-Delay=0.26(sec)");

subplot(3,2,5);
plot(t,X5(1,:), t,X5(2,:), t,X5(3,:), t,X5(4,:), t,X5(5,:), t,X5(6,:), t,X5(7,:), t,X5(8,:), t,X5(9,:), t,X5(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("state");
title("Time-Delay=0.25(sec)");

subplot(3,2,6);
plot(t,X6(1,:), t,X6(2,:), t,X6(3,:), t,X6(4,:), t,X6(5,:), t,X6(6,:), t,X6(7,:), t,X6(8,:), t,X6(9,:), t,X6(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("state");
title("Time-Delay=0.28(sec)");