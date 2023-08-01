clear; close all;

exp_p2 = 1:-0.1:0.5;

exp_vel = [0.4562 0.4533 0.4578;
           0.4536 0.4577 0.4564;
           0.4534 0.4572 0.4561;
           0.4510 0.4529 0.4580;
           0.4556 0.4556 0.4536;
           0.4579 0.4556 0.4554;
]';

exp_E = [71.0121 75.9601 72.1241;
         75.0284 76.0933 75.4253;
         83.2347 83.3079 82.1412;
         104.4757 100.7766 88.4088;
         108.9378 117.0873 102.8517;
         139.1360 124.5018 116.2106;
]'/3;

exp_COT = exp_E./exp_vel;

exp_COT_avg = mean(exp_COT,'omitnan');
exp_COT_err = std(exp_COT,'omitnan');

figure;
hold on;
box on;
errorbar(exp_p2,exp_COT_avg,exp_COT_err,'.-k','LineWidth',1.5,'MarkerSize',15);
xlim([-0.05 1.05]);
xticks([0 0.5 1])
ylim([40 110]);
xlabel('Passiveness');
ylabel('E/Disp (J/BL)');
% title('forward wave spatial frequency = 1.0');
% legend('location','northwest');
set(gcf,'color','w');
set(gca,'Fontsize',16);