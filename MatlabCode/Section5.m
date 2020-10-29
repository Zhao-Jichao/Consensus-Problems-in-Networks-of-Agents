clear;
clc;
% 此为Paper中Scetion5代码
% 拉普拉斯矩阵如下
L = [2, -1, -1;
     0,  1, -1;
    -1,  0,  1;];

%% 根据所给出的拉普拉斯矩阵推断可知：
% 节点顺序为3-1
% 度矩阵为
D = [2, 0, 0;
     0, 1, 0;
     1, 0, 1;];
% 邻接矩阵为
A = [0, 1, 1;
     0, 0, 1;
     1, 0, 0;];
 
%% 求其特征值和特征向量
% 依次返回（右）特征向量，特征值，左特征向量
[eigenVector, eigenValue, lefteigenVector] = eig(L);

%% Equation 17
syms x1 x2 x3 real;
X0 = [x1 x2 x3]';
Xt = -L * X0;
sum(Xt);

%% Equation 18
syms t;
R = expm(-L * t);
R1 = limit(R, t, inf);
R2 = eigenVector * lefteigenVector'; 




 
 
 
 

