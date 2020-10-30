clear;
clc;
% 此为原Paper中第六部分测试代码

% 状态初值如下
X0  = [-10.2999, 0.2575, -4.4997, 3.6258, 3.0922, 9.0156, 3.5099, -2.6645, 2.4552, -4.4921]';

Node_Nums = 10;

% b图度矩阵，邻接矩阵，拉普拉斯矩阵
D_a = [ 1 0 0 0 0 0 0 0 0 0;
        0 1 0 0 0 0 0 0 0 0;
        0 0 1 0 0 0 0 0 0 0;
        0 0 0 1 0 0 0 0 0 0;
        0 0 0 0 1 0 0 0 0 0;
        0 0 0 0 0 1 0 0 0 0;
        0 0 0 0 0 0 1 0 0 0;
        0 0 0 0 0 0 0 1 0 0;
        0 0 0 0 0 0 0 0 1 0;
        0 0 0 0 0 0 0 0 0 1;];
A_a = [ 0 1 0 0 0 0 0 0 0 0;
        0 0 1 0 0 0 0 0 0 0;
        0 0 0 1 0 0 0 0 0 0;
        0 0 0 0 1 0 0 0 0 0;
        0 0 0 0 0 1 0 0 0 0;
        0 0 0 0 0 0 1 0 0 0;
        0 0 0 0 0 0 0 1 0 0;
        0 0 0 0 0 0 0 0 1 0;
        0 0 0 0 0 0 0 0 0 1;
        1 0 0 0 0 0 0 0 0 0;];
L_a = D_a - A_a;

% b图度矩阵，邻接矩阵，拉普拉斯矩阵
D_b = [ 1 0 0 0 0 0 0 0 0 0;
        0 2 0 0 0 0 0 0 0 0;
        0 0 2 0 0 0 0 0 0 0;
        0 0 0 2 0 0 0 0 0 0;
        0 0 0 0 1 0 0 0 0 0;
        0 0 0 0 0 2 0 0 0 0;
        0 0 0 0 0 0 1 0 0 0;
        0 0 0 0 0 0 0 2 0 0;
        0 0 0 0 0 0 0 0 1 0;
        0 0 0 0 0 0 0 0 0 2;];
A_b = [ 0 1 0 0 0 0 0 0 0 0;
        0 0 1 0 0 0 0 0 0 1;
        0 0 0 1 0 0 0 1 0 0;
        0 0 0 0 1 1 0 0 0 0;
        0 0 0 0 0 1 0 0 0 0;
        0 0 0 1 0 0 1 0 0 0;
        0 0 0 0 0 0 0 1 0 0;
        0 0 1 0 0 0 0 0 1 0;
        0 0 0 0 0 0 0 0 0 1;
        1 1 0 0 0 0 0 0 0 0;];
L_b = D_b - A_b;

% c图度矩阵，邻接矩阵，拉普拉斯矩阵
D_c = [ 2 0 0 0 0 0 0 0 0 0;
        0 1 0 0 0 0 0 0 0 0;
        0 0 1 0 0 0 0 0 0 0;
        0 0 0 2 0 0 0 0 0 0;
        0 0 0 0 1 0 0 0 0 0;
        0 0 0 0 0 1 0 0 0 0;
        0 0 0 0 0 0 1 0 0 0;
        0 0 0 0 0 0 0 2 0 0;
        0 0 0 0 0 0 0 0 2 0;
        0 0 0 0 0 0 0 0 0 1;];
A_c = [ 0 1 0 0 0 0 0 0 1 0;
        0 0 1 0 0 0 0 0 0 0;
        0 0 0 1 0 0 0 0 0 0;
        0 0 0 0 1 0 0 1 0 0;
        0 0 0 0 0 1 0 0 0 0;
        0 0 0 0 0 0 1 0 0 0;
        0 0 0 0 0 0 0 1 0 0;
        0 0 0 1 0 0 0 0 1 0;
        1 0 0 0 0 0 0 0 0 1;
        1 0 0 0 0 0 0 0 0 0;];
L_c = D_c - A_c;

% d图度矩阵，邻接矩阵，拉普拉斯矩阵
D_d = [ 2 0 0 0 0 0 0 0 0 0;
        0 2 0 0 0 0 0 0 0 0;
        0 0 1 0 0 0 0 0 0 0;
        0 0 0 2 0 0 0 0 0 0;
        0 0 0 0 2 0 0 0 0 0;
        0 0 0 0 0 1 0 0 0 0;
        0 0 0 0 0 0 2 0 0 0;
        0 0 0 0 0 0 0 3 0 0;
        0 0 0 0 0 0 0 0 2 0;
        0 0 0 0 0 0 0 0 0 1;];
% 邻接矩阵，有向拓扑结构
A_d = [ 0 1 0 0 0 0 0 0 1 0;
        0 0 1 0 0 0 0 1 0 0;
        0 0 0 1 0 0 0 0 0 0;
        0 0 0 0 1 0 0 1 0 0;
        0 0 0 0 0 1 1 0 0 0;
        0 0 0 0 0 0 1 0 0 0;
        0 0 0 0 1 0 0 1 0 0;
        0 1 0 1 0 0 0 0 1 0;
        1 0 0 0 0 0 0 0 0 1;
        1 0 0 0 0 0 0 0 0 0;];
L_d = D_d - A_d;

% 设置收敛相关参数
tBegin = 0;                     % 开始时间 
tEnd   = 15;                    % 结束时间
dt     = 0.1;                   % 最小时间间隔
times  = (tEnd-tBegin) / dt;    % 迭代计算次数
time   = 1;
% 定义记录时间数组
t(:,1)   = tBegin;
% 定义图a数据存储数组
X_a(:,1) = X0;
U_a(:,1) = -L_a * X0;
Delta_a(:,1) = X0' * L_a * X0;
% 定义图b数据存储数组
X_b(:,1) = X0;
U_b(:,1) = -L_b * X0;
Delta_b(:,1) = X0' * L_b * X0;

X_c(:,1) = X0;
U_c(:,1) = -L_c * X0;
Delta_c(:,1) = X0' * L_c * X0;

X_d(:,1) = X0;
U_d(:,1) = -L_d * X0;
Delta_d(:,1) = X0' * L_d * X0;
% 开始收敛计算
while(time <= times)
    t(:,time+1) = tBegin + time * dt;
    % 图a数据迭代
    X_a(:,time+1) = expm(-L_a * t(:,time+1)) * X0;                          % Xt = expm(-Lx)*X0 添加更新后的Xt值
    U_a(:,time+1) = -L_a * X_a(:,time+1);                                   % Ut = -LXt 添加更新后的Ut值 
    Delta_a(:,time+1) = X_a(:,time+1)'*L_a*X_a(:,time+1);                   % Delta = X^T * L * X
    % 图b数据迭代
    X_b(:,time+1) = expm(-L_b * t(:,time+1)) * X0;
    U_b(:,time+1) = -L_b * X_b(:,time+1);
    Delta_b(:,time+1) = X_b(:,time+1)'*L_b*X_b(:,time+1);

    X_c(:,time+1) = expm(-L_c * t(:,time+1)) * X0;
    U_c(:,time+1) = -L_c * X_c(:,time+1);
    Delta_c(:,time+1) = X_c(:,time+1)'*L_c*X_c(:,time+1);

    X_d(:,time+1) = expm(-L_d * t(:,time+1)) * X0;
    U_d(:,time+1) = -L_d * X_d(:,time+1);
    Delta_d(:,time+1) = X_d(:,time+1)'*L_d*X_d(:,time+1);

    time = time + 1;
end

% 矩阵的代数连通度
eig_val_a = eig(L_a);                       % L_a的特征值
eig_val_a = sort(eig_val_a,'ascend');       % 从小到大排序，最小特征值为0
AC_a      = real(eig_val_a(2));             % algebraic connectivity 代数连通度：lap_matrix的第二小特征值>0，连通图

eig_val_b = eig(L_b);                       % L_b的特征值
eig_val_b = sort(eig_val_b,'ascend');       % 从小到大排序，最小特征值为0
AC_b      = real(eig_val_b(2));             % algebraic connectivity 代数连通度：lap_matrix的第二小特征值>0，连通图

eig_val_c = eig(L_c);
eig_val_c = sort(eig_val_c,'ascend');
AC_c      = real(eig_val_c(2));

eig_val_d = eig(L_d);
eig_val_d = sort(eig_val_d,'ascend');
AC_d      = real(eig_val_d(2));

% 绘制图a数据
subplot(4,2,1);
plot(t,X_a(1,:), t,X_a(2,:), t,X_a(3,:), t,X_a(4,:), t,X_a(5,:), t,X_a(6,:), t,X_a(7,:), t,X_a(8,:), t,X_a(9,:), t,X_a(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("node value");
title("Algebraic Connectivity="+num2str(AC_a));
subplot(4,2,3);
plot(t,Delta_a, 'linewidth',1.5);
xlabel("time(sec)");ylabel("disagreement");

subplot(4,2,2);
plot(t,X_b(1,:), t,X_b(2,:), t,X_b(3,:), t,X_b(4,:), t,X_b(5,:), t,X_b(6,:), t,X_b(7,:), t,X_b(8,:), t,X_b(9,:), t,X_b(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("node value");
title("Algebraic Connectivity="+num2str(AC_b));
subplot(4,2,4);
plot(t,Delta_b, 'linewidth',1.5);
xlabel("time(sec)");ylabel("disagreement");

subplot(4,2,5);
plot(t,X_c(1,:), t,X_c(2,:), t,X_c(3,:), t,X_c(4,:), t,X_c(5,:), t,X_c(6,:), t,X_c(7,:), t,X_c(8,:), t,X_c(9,:), t,X_c(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("node value");
title("Algebraic Connectivity="+num2str(AC_c));
subplot(4,2,7);
plot(t,Delta_c, 'linewidth',1.5);
xlabel("time(sec)");ylabel("disagreement");

subplot(4,2,6);
plot(t,X_d(1,:), t,X_d(2,:), t,X_d(3,:), t,X_d(4,:), t,X_d(5,:), t,X_d(6,:), t,X_d(7,:), t,X_d(8,:), t,X_d(9,:), t,X_d(10,:), 'linewidth',1.5)
xlabel("time(sec)");ylabel("node value");
title("Algebraic Connectivity="+num2str(AC_d));
subplot(4,2,8);
plot(t,Delta_d, 'linewidth',1.5);
xlabel("time(sec)");ylabel("disagreement");