
Matrix = [8 64 256 1024 4096 16384];
CPU_Time = [ 1.51 1.67 2.43 14.5 206.63 3217.4];
Pattern1_GPU = [165.13 181.53 160.30 195.07 372.44 3521.8];
Pattern2_GPU = [173.33 176.97 166.16 175.43 407.29 3547.04]; 

figure('DefaultAxesFontSize',20)
plot(Matrix,CPU_Time,'r',Matrix,Pattern1_GPU,'b',Matrix,Pattern2_GPU,'k','LineWidth',2)
grid on
set(gca,'XMinorTick','on','YMinorTick','on')
xlabel('Square Matrix Dimension');
ylabel('Total GPU Time (ms)');
%set(gca,'xscale','log')
set(gca,'yscale','log')
title('Block Size 16x16')
legend({'CPU Time','Pattern 1 GPU Time', 'Pattern 2 GPU Time'},'Location','northwest')

% figure
% plot(x,y,'--gs',...
%     'LineWidth',2,...
%     'MarkerSize',10,...
%     'MarkerEdgeColor','b',...
%     'MarkerFaceColor',[0.5,0.5,0.5])

Square_Block = [1 2 4 8 16 32];
Pattern2_GPU = [3662.86 3565.11 3575.87 3552.11 3547.04 3545.8]; 

figure('DefaultAxesFontSize',20)
plot(Square_Block,Pattern2_GPU,'k','LineWidth',2)
grid on
set(gca,'XMinorTick','on','YMinorTick','on')
xlabel('Square Block Dimension');
ylabel('Total GPU Time (ms)');
%set(gca,'xscale','log')
%set(gca,'yscale','log')
title('Pattern 2 Matrix Size - 16384x16384')
%legend({'CPU Time','Pattern 1 GPU Time', 'Pattern 2 GPU Time'},'Location','northwest')