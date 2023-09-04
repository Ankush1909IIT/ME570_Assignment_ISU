
%% Vector Add
% X = [16 64 93 112 1120 9921 1233 1033 4098 4018]; % Data Input
% Y = [1.01 1.16 1.258 1.322 4.795 34.935 5.205 4.52 15.194 14.82];  % Total Computation Time
% figure('DefaultAxesFontSize',20)
% scatter(X,Y,40, 'filled')
% grid on
% set(gca,'XMinorTick','on','YMinorTick','on')
% xlabel('Data Size');
% ylabel('Total GPU Time (ms)');
% set(gca,'xscale','log')
% title('Vector Addition')
% 
% A = [0.07 0.06 0.058 0.06 0.059 0.08 0.066 0.065 0.069 0.075]; % Data Transfer Time
% 
% figure('DefaultAxesFontSize',20)
% scatter(X,A,40, 'filled')
% grid on
% set(gca,'XMinorTick','on','YMinorTick','on')
% xlabel('Data Size');
% ylabel('Data Transfer Time (ms)');
% set(gca,'xscale','log')
% title('Vector Addition')
% 
% B = [0.03 0.03 0.03 0.032 0.026 0.025 0.029 0.025 0.025 0.025]; % CUDA Computation Time
% figure('DefaultAxesFontSize',20)
% scatter(X,B,40, 'filled')
% grid on
% set(gca,'XMinorTick','on','YMinorTick','on')
% xlabel('Data Size');
% ylabel('CUDA Computation Time (ms)');
% set(gca,'xscale','log')
% title('Vector Addition')
% 
% Z = [1 2 4 8 16 32 64 128 256 512 1024]; %Block Size
% C = [35.434 35.06 35.558 34.916 35.056 35.275 35.025 35.105 35.325 35.135 35.815];
% figure('DefaultAxesFontSize',20)
% scatter(Z,C,40, 'filled')
% grid on
% set(gca,'XMinorTick','on','YMinorTick','on')
% xlabel('Block Size for Input data size 9921');
% ylabel('CUDA Computation Time (ms)');
% set(gca,'xscale','log')
% title('Vector Addition')


% %% Basic Matrix Multiplication
% 
% 
% Operations = [7936 520192 1044480 170240 1178352 441280 450240 574345 1703147]; % Number of Multiplications and Addition Operations
% Total_Time = [0.97 2.415 3.871 2.193 3.424 4.424 2.182 3.327 2.627];  % Total Computation Time
% figure('DefaultAxesFontSize',20)
% scatter(Operations,Total_Time,40, 'filled')
% grid on
% set(gca,'XMinorTick','on','YMinorTick','on')
% xlabel('Number of Operations');
% ylabel('Total GPU Time (ms)');
% set(gca,'xscale','log')
% %set(gca,'yscale','log')
% title('Basic Matrix Multiplication (Block Size 16*16)')
% 
% 
% 
% %Operations = [7936 520192 1044480 170240 1178352 441280 450240 574345 1703147]; % Number of Multiplications and Addition Operations
% Data_Transfer_Time = [0.057 0.064 0.07 0.063 0.074 0.081 0.074 0.069 0.128];  % Total Data Transfer Time
% figure('DefaultAxesFontSize',20)
% scatter(Operations,Data_Transfer_Time,40, 'filled')
% grid on
% set(gca,'XMinorTick','on','YMinorTick','on')
% xlabel('Number of Operations');
% ylabel('Data Transfer Time (ms)');
% set(gca,'xscale','log')
% %set(gca,'yscale','log')
% title('Basic Matrix Multiplication (Block Size 16*16)')
% 
% 
% CUDA_Computation_Time = [0.035 0.034 0.034 0.03 0.033 0.035 0.032 0.035 0.029];  % CUDA Computation Time Time
% figure('DefaultAxesFontSize',20)
% scatter(Operations,CUDA_Computation_Time,40, 'filled')
% grid on
% set(gca,'XMinorTick','on','YMinorTick','on')
% xlabel('Number of Operations');
% ylabel('CUDA Computation Time (ms)');
% set(gca,'xscale','log')
% %set(gca,'yscale','log')
% title('Basic Matrix Multiplication (Block Size 16*16)')
% 
% Squared_Block_Size = [1 2 4 8 16 32]; % Squared Block Size
% CUDA_Time = [0.045 0.034 0.034 0.034 0.034 0.037]; % CUDA Time
% figure('DefaultAxesFontSize',20)
% scatter(Squared_Block_Size,CUDA_Time,40, 'filled')
% grid on
% set(gca,'XMinorTick','on','YMinorTick','on')
% xlabel('Block Size for Input data size 64x128 and 128x64');
% ylabel('CUDA Computation Time (ms)');
% %set(gca,'xscale','log')
% title('Basic Matrix Multiplication')

%% Tiled Matrix Multiplication

Operations = [7936 520192 1044480 170240 1178352 441280 450240 574345 1703147]; % Number of Multiplications and Addition Operations
Total_Time = [0.998 2.565 3.833 2.277 3.764 4.516 2.22 3.197 2.839];  % Total Computation Time
figure('DefaultAxesFontSize',20)
scatter(Operations,Total_Time,40, 'filled')
grid on
set(gca,'XMinorTick','on','YMinorTick','on')
xlabel('Number of Operations');
ylabel('Total GPU Time (ms)');
set(gca,'xscale','log')
%set(gca,'yscale','log')
title('Tiled Matrix Multiplication (Block Size 16*16)')



%Operations = [7936 520192 1044480 170240 1178352 441280 450240 574345 1703147]; % Number of Multiplications and Addition Operations
Data_Transfer_Time = [0.058 0.068 0.075 0.112 0.082 0.085 0.112 0.069 0.127];  % Total Data Transfer Time
figure('DefaultAxesFontSize',20)
scatter(Operations,Data_Transfer_Time,40,'filled')
grid on
set(gca,'XMinorTick','on','YMinorTick','on')
xlabel('Number of Operations');
ylabel('Data Transfer Time (ms)');
set(gca,'xscale','log')
%set(gca,'yscale','log')
title('Tiled Matrix Multiplication (Block Size 16*16)')


CUDA_Computation_Time = [0.03 0.027 0.03 0.047 0.299 0.029 0.044 0.031 0.27];  % CUDA Computation Time Time
figure('DefaultAxesFontSize',20)
scatter(Operations,CUDA_Computation_Time,40, 'filled')
grid on
set(gca,'XMinorTick','on','YMinorTick','on')
xlabel('Number of Operations');
ylabel('CUDA Computation Time (ms)');
set(gca,'xscale','log')
%set(gca,'yscale','log')
title('Tiled Matrix Multiplication (Block Size 16*16)')

Squared_Block_Size = [1 2 4 8 16 32]; % Squared Block Size
CUDA_Time = [0.045 0.034 0.034 0.034 0.034 0.037]; % Total Time
figure('DefaultAxesFontSize',20)
scatter(Squared_Block_Size,CUDA_Time,40, 'filled')
grid on
set(gca,'XMinorTick','on','YMinorTick','on')
xlabel('Block Size for Input data size 64x128 and 128x64');
ylabel('CUDA Computation Time (ms)');
%set(gca,'xscale','log')
title('Tiled Matrix Multiplication')
box on
