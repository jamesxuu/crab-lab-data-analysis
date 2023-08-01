% clear; close all;

exp_p = 0:0.25:1.5;

exp_vel = [0 0 0; 
           0 0 0; 
           0 0 0; 
           0.5284 0.5279 0.5232;
           0.5188 0.5312 0.5343;  
           0.5529 0.4195 0.5221;
           0 0 0; 
%            0 0 0;
%            0 0 0;
]'; % BL per cycle

exp_disp = [0 0 0; 
           0 0 0; 
           0 0 0; 
           1.6288 1.6312 1.6164;
           1.6030 1.6525 1.6729;  
           1.1478 0.9593 1.0834;
           0 0 0; 
%            0 0 0;
%            0 0 0;
]'; % BL per cycle

exp_E = [nan nan nan; 
         nan nan nan; 
         nan nan nan; 
         19.5310 22.3662 25.7827; %25.7827 22.3662 19.5310;
         17.6285 19.6965 21.1672; %21.1672 17.6285 19.6965;
         16.5020 14.5087 13.1569; %15.5020 14.5087 14.1569;
         nan nan nan; 
%          nan nan nan;
%          nan nan nan;
]'; % per cycle
% 
exp_E_total = [nan nan nan; 
               nan nan nan; 
               nan nan nan; 
               80.7515 69.8721 60.4681;
               65.7029 55.6354 62.9500;
               33.4223 26.5219 27.9174;
               nan nan nan; 
%                nan nan nan;
%                nan nan nan;
]'; % in total

COT = exp_E_total./(exp_disp*0.86)/(1.5*9.8);

exp_waveEfficiency = exp_vel*0.86/0.49; % BL = 0.86 m, wave length = 0.47 m

exp_vel_avg = mean(exp_vel,'omitnan');
exp_vel_err = std(exp_vel,'omitnan');
exp_waveEfficiency_avg = mean(exp_waveEfficiency,'omitnan');
exp_waveEfficiency_err = std(exp_waveEfficiency,'omitnan');
exp_E_avg = mean(exp_E,'omitnan');
exp_E_err = std(exp_E,'omitnan');
COT_avg = mean(COT,'omitnan');
COT_err = std(COT,'omitnan');

figure;
set(gcf,'Position',[100 100 700 500]);
set(gcf,'color','w');
set(gca,'Fontsize',22);
hold on;
box on;
yyaxis left
plot(exp_p,exp_waveEfficiency_avg,'-','LineWidth',1.5,'MarkerSize',10);
errorbar(exp_p(4:6),exp_waveEfficiency_avg(4:6),exp_waveEfficiency_err(4:6),'LineWidth',1.5);
% plot(exp_p,exp_waveEfficiency_avg,'o-','LineWidth',1.5,'MarkerSize',10);
xlim([-0.05 1.55]);
xticks([0 1.5]);
ylim([-0.05 1.05]);
yticks([0 1])
xlabel('$p$','Interpreter','latex');
% ylabel('Displacement (BL/cycle)');
ylabel('\eta');

yyaxis right
errorbar(exp_p,COT_avg,COT_err,'-','LineWidth',1.5,'MarkerSize',10);
% errorbar(exp_p,COT_total_avg,COT_total_err,'.-k','LineWidth',1.5,'MarkerSize',10);
% plot(exp_p,COT_avg,'s--','LineWidth',1.5,'MarkerSize',10);
ylim([-0.75 15.75]);
yticks([0 15])
ylabel('$c_{mt}$','Interpreter','latex');
% title('forward wave spatial frequency = 1.0');
% legend('location','northwest');

% figure;
% hold on;
% box on;
% errorbar(exp_p,exp_E_avg,exp_E_err,'.-b','LineWidth',1.5,'MarkerSize',15);
% xlim([-0.05 1.05]);
% xticks([0 0.5 1])
% ylim([0 50]);
% xlabel('Passiveness');
% ylabel('Energy consumption (J/cycle)');
% % title('forward wave spatial frequency = 1.0');
% % legend('location','northwest');
% set(gcf,'color','w');
% set(gca,'Fontsize',16);